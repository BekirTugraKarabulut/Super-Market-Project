package com.tugra.service.impl;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciUI;
import com.tugra.dto.RefreshTokenRequest;
import com.tugra.exception.BaseException;
import com.tugra.exception.ErrorMessage;
import com.tugra.exception.MessageType;
import com.tugra.jwt.AuthRequest;
import com.tugra.jwt.AuthResponse;
import com.tugra.jwt.JwtService;
import com.tugra.model.Kullanici;
import com.tugra.model.RefreshToken;
import com.tugra.model.Role;
import com.tugra.repository.AuthRepository;
import com.tugra.repository.RefreshTokenRepository;
import com.tugra.service.AuthService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthRepository authRepository;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private AuthenticationProvider authenticationProvider;

    @Autowired
    private JwtService jwtService;


    @Override
    public DtoKullanici register(DtoKullaniciUI dtoKullaniciUI) {

        Kullanici kullanici = new Kullanici();

        kullanici.setUsername(dtoKullaniciUI.getUsername());
        kullanici.setKullaniciAd(dtoKullaniciUI.getKullaniciAd());
        kullanici.setPassword(bCryptPasswordEncoder.encode(dtoKullaniciUI.getPassword()));
        kullanici.setTelefonNo(dtoKullaniciUI.getTelefonNo());
        kullanici.setAdres(dtoKullaniciUI.getAdres());
        kullanici.setRole(Role.KULLANICI);

        if(authRepository.findByUsername(kullanici.getUsername()).isPresent()){
            throw new BaseException(new ErrorMessage(MessageType.KULLANILMIS_EMAİL , dtoKullaniciUI.getUsername()));
        }

        if (authRepository.findByTelefonNo(kullanici.getTelefonNo()).isPresent()) {
            throw new BaseException(new ErrorMessage(MessageType.KULLANILMIS_TELEFON_NO , dtoKullaniciUI.getTelefonNo()));
        }

        Kullanici dbKullanici = authRepository.save(kullanici);
        DtoKullanici dtoKullanici = new DtoKullanici();
        BeanUtils.copyProperties(dbKullanici, dtoKullanici);

        return dtoKullanici;
    }

    public RefreshToken createRefreshToken(Kullanici kullanici) {
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setKullanici(kullanici);
        refreshToken.setCreatedDate(new Date());
        refreshToken.setExpiredDate(new Date(System.currentTimeMillis() + 3600 * 1000));
        refreshToken.setRefreshToken(UUID.randomUUID().toString());
        return refreshToken;
    }

    @Override
    public AuthResponse authenticate(AuthRequest authRequest) {

        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword());
        authenticationProvider.authenticate(authenticationToken);

        Optional<Kullanici> kullanici = authRepository.findByUsername(authRequest.getUsername());

        if (kullanici.isEmpty()){
            throw new BaseException(new ErrorMessage(MessageType.KULLANICI_BULUNAMADI , authRequest.getUsername()));
        }

        String accessToken = jwtService.generateToken(kullanici.get());
        RefreshToken refreshToken = createRefreshToken(kullanici.get());
        RefreshToken dbRefreshToken = refreshTokenRepository.save(refreshToken);

        return new AuthResponse(accessToken , dbRefreshToken.getRefreshToken());
    }

    public boolean isValidExpired(Date expiredDate) {
        return new Date().before(expiredDate);
    }

    @Override
    public AuthResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {

        Optional<RefreshToken> refreshToken = refreshTokenRepository.findByRefreshToken(refreshTokenRequest.getToken());

        if (refreshToken.isEmpty()){
            throw new BaseException(new ErrorMessage(MessageType.TOKEN_BULUNAMADI , refreshTokenRequest.getToken()));
        }

        if(!isValidExpired(refreshToken.get().getExpiredDate())){
            throw new BaseException(new ErrorMessage(MessageType.TOKEN_SURESİ_BİTMİS , refreshToken.get().getExpiredDate().toString()));
        }

        Kullanici kullanici = refreshToken.get().getKullanici();

        String accessToken = jwtService.generateToken(kullanici);
        RefreshToken refreshTokenCreate = createRefreshToken(kullanici);
        RefreshToken dbRefreshToken = refreshTokenRepository.save(refreshTokenCreate);

        return new AuthResponse(accessToken , dbRefreshToken.getRefreshToken());
    }


}

package com.tugra.service.impl;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciUI;
import com.tugra.dto.RefreshTokenRequest;
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
    private JwtService jwtService;

    @Autowired
    private AuthenticationProvider authenticationProvider;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public DtoKullanici kayitKullanici(DtoKullaniciUI dtoKullaniciUI) {

        Kullanici kullanici = new Kullanici();

        kullanici.setUsername(dtoKullaniciUI.getUsername());
        kullanici.setAd(dtoKullaniciUI.getAd());
        kullanici.setSoyad(dtoKullaniciUI.getSoyad());
        kullanici.setPassword(bCryptPasswordEncoder.encode(dtoKullaniciUI.getPassword()));
        kullanici.setTelefonNo(dtoKullaniciUI.getTelefonNo());
        kullanici.setAdres(dtoKullaniciUI.getAdres());
        kullanici.setRole(Role.KULLANICI);

        if(authRepository.findByUsername(kullanici.getUsername()).isPresent()){
            return null;
        }

        if(authRepository.findByTelefonNo(kullanici.getTelefonNo()).isPresent()){
            return null;
        }

        Kullanici dbKullanici = authRepository.save(kullanici);
        DtoKullanici dtoKullanici = new DtoKullanici();
        BeanUtils.copyProperties(dbKullanici, dtoKullanici);

        return dtoKullanici;
    }

    private RefreshToken createdRefreshToken(Kullanici kullanici) {
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setKullanici(kullanici);
        refreshToken.setCreatedDate(new Date());
        refreshToken.setExpiredDate(new Date(System.currentTimeMillis() + 3600 * 1000));
        refreshToken.setRefreshToken(UUID.randomUUID().toString());
        return refreshToken;
    }


    @Override
    public AuthResponse authenticate(AuthRequest authRequest) {

        UsernamePasswordAuthenticationToken  token =
                new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword());
        authenticationProvider.authenticate(token);

        Optional<Kullanici> kullanici = authRepository.findByUsername(authRequest.getUsername());

        if(kullanici.isEmpty()){
            return null;
        }

        String accessToken = jwtService.generateToken(kullanici.get());
        RefreshToken refreshToken = createdRefreshToken(kullanici.get());
        RefreshToken dbRefreshToken = refreshTokenRepository.save(refreshToken);

        return new AuthResponse(accessToken, dbRefreshToken.getRefreshToken());
    }

    public boolean isValidToken(Date expiration) {
        return new Date().before(expiration);
    }

    @Override
    public AuthResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {

        Optional<RefreshToken> refreshToken = refreshTokenRepository.findByRefreshToken(refreshTokenRequest.getToken());

        if(refreshToken.isEmpty()){
            return null;
        }

        if(!isValidToken(refreshToken.get().getExpiredDate())){
            return null;
        }

        Kullanici kullanici = refreshToken.get().getKullanici();

        String accessToken = jwtService.generateToken(kullanici);
        RefreshToken createdRefreshToken = createdRefreshToken(kullanici);
        RefreshToken dbRefreshToken = refreshTokenRepository.save(createdRefreshToken);

        return new AuthResponse(accessToken, dbRefreshToken.getRefreshToken());
    }
}

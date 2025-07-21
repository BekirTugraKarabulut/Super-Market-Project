package com.tugra.service;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciUI;
import com.tugra.dto.RefreshTokenRequest;
import com.tugra.jwt.AuthRequest;
import com.tugra.jwt.AuthResponse;

public interface AuthService {

    public DtoKullanici register(DtoKullaniciUI dtoKullaniciUI);

    public AuthResponse authenticate(AuthRequest authRequest);

    public AuthResponse refreshToken(RefreshTokenRequest refreshTokenRequest);

}

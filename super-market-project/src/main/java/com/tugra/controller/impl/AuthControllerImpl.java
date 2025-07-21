package com.tugra.controller.impl;

import com.tugra.controller.AuthController;
import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciUI;
import com.tugra.dto.RefreshTokenRequest;
import com.tugra.jwt.AuthRequest;
import com.tugra.jwt.AuthResponse;
import com.tugra.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthControllerImpl implements AuthController {

    @Autowired
    private AuthService authService;


    @Override
    @PostMapping(path = "/register")
    public DtoKullanici register(@RequestBody DtoKullaniciUI dtoKullaniciUI) {
        return authService.register(dtoKullaniciUI);
    }

    @Override
    @PostMapping(path = "/authenticate")
    public AuthResponse authenticate(@RequestBody AuthRequest authRequest) {
        return authService.authenticate(authRequest);
    }

    @Override
    @PostMapping(path = "/refresh_token")
    public AuthResponse refreshToken(@RequestBody RefreshTokenRequest refreshTokenRequest) {
        return authService.refreshToken(refreshTokenRequest);
    }

}

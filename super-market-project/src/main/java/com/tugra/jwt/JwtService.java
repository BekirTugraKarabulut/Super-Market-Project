package com.tugra.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.function.Function;

@Service
public class JwtService {

    private static final String SECRET_KEY = "EhYHaehnpLDNcdck/awxoieJ6Jumd7VW7HLMgLww1fg=";

    public String generateToken(UserDetails userDetails) {

        return Jwts.builder()
                .setSubject(userDetails.getUsername())
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() * 3600000))
                .signWith(getKey() ,  SignatureAlgorithm.HS256)
                .compact();
    }

    public Claims getClaims(String token) {

        Claims claims = Jwts.parserBuilder()
                .setSigningKey(getKey())
                .build()
                .parseClaimsJws(token).getBody();

        return claims;
    }

    public <T> T exportToken(String token, Function<Claims , T> claimsTFunction){
        Claims claims = getClaims(token);
        return claimsTFunction.apply(claims);
    }

    public String getUsernameByToken(String token) {
        return exportToken(token, claims -> claims.getSubject());
    }

    public boolean isValidToken(String token) {
        Date expiredDate = exportToken(token, claims -> claims.getExpiration());
        return new Date().before(expiredDate);
    }

    public Key getKey(){
        byte[] bytes = Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(bytes);
    }

}

package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "kullanici")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Kullanici implements UserDetails {

    @Id
    @Column(name = "username")
    private String username;

    @Column(name = "kullanici_ad")
    private String kullaniciAd;

    @Column(name = "password")
    private String password;

    @Column(name = "telefon_no" , unique = true)
    private String telefonNo;

    @Column(name = "adres")
    private String adres;

    @Enumerated(EnumType.STRING)
    @Column(name = "role")
    private Role role;

    @OneToMany(mappedBy = "kullanici" , fetch = FetchType.LAZY)
    private List<RefreshToken> refreshTokens;

    @OneToMany(mappedBy = "kullanici" , fetch = FetchType.LAZY)
    private List<Begen> begen;

    @OneToMany(mappedBy = "kullanici" , fetch = FetchType.LAZY)
    private List<SatinAlinanlar> satinAlinanlar;

    @OneToMany(mappedBy = "kullanici" , fetch = FetchType.LAZY)
    private List<Sepet> sepet;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public boolean isAccountNonExpired() {
        return UserDetails.super.isAccountNonExpired();
    }

    @Override
    public boolean isAccountNonLocked() {
        return UserDetails.super.isAccountNonLocked();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return UserDetails.super.isCredentialsNonExpired();
    }

    @Override
    public boolean isEnabled() {
        return UserDetails.super.isEnabled();
    }
}

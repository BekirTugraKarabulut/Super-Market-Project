package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoKullanici {

    private String username;

    private String kullaniciAd;

    private String password;

    private String telefonNo;

    private String adres;

}

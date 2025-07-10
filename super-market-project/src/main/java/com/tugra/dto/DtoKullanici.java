package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoKullanici {

    private String username;

    private String password;

    private String ad;

    private String soyad;

    private String telefonNo;

    private String adres;

}

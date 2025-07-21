package com.tugra.dto;

import jakarta.validation.constraints.Email;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoKullaniciUI {

    @Email(message = "Lütfen email türünde giriniz !")
    private String username;

    private String kullaniciAd;

    private String password;

    private String telefonNo;

    private String adres;

}

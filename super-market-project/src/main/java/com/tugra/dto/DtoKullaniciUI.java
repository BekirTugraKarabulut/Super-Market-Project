package com.tugra.dto;

import jakarta.validation.constraints.Email;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoKullaniciUI {

    @Email(message = "Lütfen e-mail türünde giriniz!")
    private String username;

    private String password;

    private String ad;

    private String soyad;

    private String telefonNo;

    private String adres;


}

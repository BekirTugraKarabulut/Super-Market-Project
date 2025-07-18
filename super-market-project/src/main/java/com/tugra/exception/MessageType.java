package com.tugra.exception;

import lombok.Getter;

@Getter
public enum MessageType {

    KULLANICI_ADI_ALINMIS("111" , "Kullanılmış E-mail !"),
    TELEFON_NO_ALINMIS("112" , "Kullanılmış Telefon Numarası !"),
    KULLANICI_BULUNAMADI("113" , "Kullanıcı Bulunamadı !"),
    TOKEN_BULUNAMADI("114" , "Token Bulunamadı !"),
    TOKEN_SURESI_DOLMUS("115" , "Token Süresi Dolmuş !");

    private String code;
    private String message;

    MessageType(String code, String message) {
        this.code = code;
        this.message = message;
    }

}

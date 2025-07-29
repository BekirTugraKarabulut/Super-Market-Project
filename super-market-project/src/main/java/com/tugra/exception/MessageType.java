package com.tugra.exception;

import lombok.Getter;

@Getter
public enum MessageType {

    KULLANILMIS_EMAİL("111" , "Kullanılmış E-Mail. Lütfen başka bir E-mail deneyiniz !"),
    KULLANILMIS_TELEFON_NO("112" , "Kullanılmış Telefon Numarası. Lütfen başka bir telefon numarası deneyiniz !"),
    KULLANICI_BULUNAMADI("113" , "Kullanıcı Bulunamadı !"),
    TOKEN_BULUNAMADI("114" , "Token Bulunamadi !"),
    TOKEN_SURESİ_BİTMİS("115" , "Token Süresi Bitmiştir !"),
    URUN_BULUNAMADI("116" , "Ürün Bulunamadı !");

    private String code;
    private String message;

    MessageType(String code, String message) {
        this.code = code;
        this.message = message;
    }


}

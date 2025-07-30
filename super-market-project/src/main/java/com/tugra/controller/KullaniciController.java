package com.tugra.controller;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciGuncelle;

public interface KullaniciController {

    public DtoKullanici getKullanici(String username);

    public DtoKullanici guncelleKullanici(String username, DtoKullaniciGuncelle dtoKullaniciGuncelle);


}

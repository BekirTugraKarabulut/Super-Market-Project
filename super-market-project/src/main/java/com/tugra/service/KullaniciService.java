package com.tugra.service;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciGuncelle;

public interface KullaniciService {

    public DtoKullanici getKullanici(String username);

    public DtoKullanici guncelleKullanici(String username,DtoKullaniciGuncelle dtoKullaniciGuncelle);


}

package com.tugra.service;

import com.tugra.dto.DtoSepet;
import com.tugra.dto.DtoSepetUI;

import java.util.List;

public interface SepetService {

    public List<DtoSepet> findByKullanici_username(String username);

    public double sepetToplamTutari(String username);

    public DtoSepet sepeteEkle(DtoSepetUI dtoSepetUI);

    public void deleteByKullanici_usernameAndUrunler_UrunId(String username, Long urunId);

}

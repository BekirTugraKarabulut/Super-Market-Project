package com.tugra.controller;

import com.tugra.dto.DtoUrunler;
import com.tugra.dto.DtoUrunlerUI;

import java.util.List;

public interface UrunlerController {

    public List<DtoUrunler> getAllUrunler();

    public DtoUrunler urunEkle(DtoUrunlerUI dtoUrunlerUI);

    public List<DtoUrunler> getUrunlerByKategoriId(Long kategorilerKategoriId);

}

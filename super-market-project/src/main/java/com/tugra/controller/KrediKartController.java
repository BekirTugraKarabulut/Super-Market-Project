package com.tugra.controller;

import com.tugra.dto.DtoKrediKart;
import com.tugra.dto.DtoKrediKartUI;

import java.util.List;

public interface KrediKartController {

    public DtoKrediKart kartEkle(DtoKrediKartUI dtoKrediKartUI);

    public List<DtoKrediKart> kartlariGetir(String username);

}

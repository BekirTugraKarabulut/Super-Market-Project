package com.tugra.service;

import com.tugra.dto.DtoKrediKart;
import com.tugra.dto.DtoKrediKartUI;

import java.util.List;

public interface KrediKartService {

    public DtoKrediKart kartEkle(DtoKrediKartUI dtoKrediKartUI);

    public List<DtoKrediKart> kartlariGetir(String username);

}

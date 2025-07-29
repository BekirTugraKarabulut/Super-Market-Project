package com.tugra.service;

import com.tugra.dto.DtoBegen;
import com.tugra.dto.DtoBegenUI;

import java.util.List;

public interface BegenService {

    public DtoBegen begenEkle(DtoBegenUI dtoBegenUI);

    public void deleteBegen(Long urunId , String username);

    public List<DtoBegen> findByUsername(String username);

}

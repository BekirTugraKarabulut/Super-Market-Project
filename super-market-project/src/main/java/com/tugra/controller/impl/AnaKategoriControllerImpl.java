package com.tugra.controller.impl;

import com.tugra.controller.AnaKategoriController;
import com.tugra.dto.DtoAnaKategori;
import com.tugra.dto.DtoAnaKategoriUI;
import com.tugra.service.AnaKategoriService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/ana-kategori")
public class AnaKategoriControllerImpl implements AnaKategoriController {

    @Autowired
    private AnaKategoriService anaKategoriService;

    @Override
    @PostMapping(path = "/ekle")
    public DtoAnaKategori ekleAnaKategori(@RequestBody DtoAnaKategoriUI dtoAnaKategoriUI) {
        return anaKategoriService.ekleAnaKategori(dtoAnaKategoriUI);
    }

}

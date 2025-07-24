package com.tugra.controller.impl;

import com.tugra.controller.UrunlerController;
import com.tugra.dto.DtoUrunler;
import com.tugra.dto.DtoUrunlerUI;
import com.tugra.service.UrunlerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/urun")
public class UrunlerControllerImpl implements UrunlerController {

    @Autowired
    private UrunlerService urunlerService;

    @Override
    @GetMapping(path = "/0")
    public List<DtoUrunler> getAllUrunler() {
        return urunlerService.getAllUrunler();
    }

    @Override
    @PostMapping(path = "/ekle")
    public DtoUrunler urunEkle(@RequestBody DtoUrunlerUI dtoUrunlerUI) {
        return urunlerService.urunEkle(dtoUrunlerUI);
    }

    @Override
    @GetMapping(path = "/{kategorilerKategoriId}")
    public List<DtoUrunler> getUrunlerByKategoriId(@PathVariable(name = "kategorilerKategoriId" , required = true) Long kategorilerKategoriId) {
        return urunlerService.getUrunlerByKategoriId(kategorilerKategoriId);
    }

}

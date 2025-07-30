package com.tugra.controller.impl;

import com.tugra.controller.SepetController;
import com.tugra.dto.DtoSepet;
import com.tugra.dto.DtoSepetUI;
import com.tugra.service.SepetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/sepet")
public class SepetControllerImpl implements SepetController {

    @Autowired
    private SepetService sepetService;

    @Override
    @GetMapping(path = "/{username}")
    public List<DtoSepet> findByKullanici_username(@PathVariable(name = "username", required = true) String username) {
        return sepetService.findByKullanici_username(username);
    }

    @Override
    @GetMapping(path = "/toplamtutar/{username}")
    public double sepetToplamTutari(@PathVariable(name = "username" , required = true) String username) {
        return sepetService.sepetToplamTutari(username);
    }

    @Override
    @PostMapping(path = "/ekle")
    public DtoSepet sepeteEkle(@RequestBody DtoSepetUI dtoSepetUI) {
        return sepetService.sepeteEkle(dtoSepetUI);
    }

    @Override
    @DeleteMapping(path = "/sil/{username}/{urunId}")
    public void deleteByKullanici_usernameAndUrunler_UrunId(@PathVariable(name = "username" , required = true) String username,@PathVariable(name = "urunId" , required = true) Long urunId) {
        sepetService.deleteByKullanici_usernameAndUrunler_UrunId(username, urunId);
    }

}

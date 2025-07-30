package com.tugra.controller.impl;

import com.tugra.controller.KullaniciController;
import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciGuncelle;
import com.tugra.service.KullaniciService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/kullanici")
public class KullaniciControllerImpl implements KullaniciController {

    @Autowired
    private KullaniciService kullaniciService;

    @Override
    @GetMapping(path = "/{username}")
    public DtoKullanici getKullanici(@PathVariable(name = "username" , required = true) String username) {
        return kullaniciService.getKullanici(username);
    }

    @Override
    @PutMapping(path = "/guncelle/{username}")
    public DtoKullanici guncelleKullanici(@PathVariable(name = "username" , required = true) String username,@RequestBody DtoKullaniciGuncelle dtoKullaniciGuncelle) {
        return kullaniciService.guncelleKullanici(username, dtoKullaniciGuncelle);
    }

}

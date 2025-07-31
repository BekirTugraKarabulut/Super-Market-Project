package com.tugra.controller.impl;

import com.tugra.controller.KrediKartController;
import com.tugra.dto.DtoKrediKart;
import com.tugra.dto.DtoKrediKartUI;
import com.tugra.service.KrediKartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping
public class KrediKartControllerImpl implements KrediKartController {

    @Autowired
    private KrediKartService krediKartService;


    @Override
    @PostMapping(path = "/kartEkle")
    public DtoKrediKart kartEkle(@RequestBody DtoKrediKartUI dtoKrediKartUI) {
        return krediKartService.kartEkle(dtoKrediKartUI);
    }

    @Override
    @GetMapping(path = "/kartlariGetir/{username}")
    public List<DtoKrediKart> kartlariGetir(@PathVariable(name = "username",required = true) String username) {
        return krediKartService.kartlariGetir(username);
    }

}

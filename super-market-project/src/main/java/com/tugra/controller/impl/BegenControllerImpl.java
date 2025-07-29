package com.tugra.controller.impl;

import com.tugra.controller.BegenController;
import com.tugra.dto.DtoBegen;
import com.tugra.dto.DtoBegenUI;
import com.tugra.service.BegenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/begen")
public class BegenControllerImpl implements BegenController {

    @Autowired
    private BegenService begenService;


    @Override
    @PostMapping(path = "/ekle")
    public DtoBegen begenEkle(@RequestBody DtoBegenUI dtoBegenUI) {
        return begenService.begenEkle(dtoBegenUI);
    }

    @Override
    @DeleteMapping(path = "/sil/{urunId}/{username}")
    public void deleteBegen(@PathVariable(name = "urunId", required = true) Long urunId,@PathVariable(name = "username" ,required = true) String username) {
        begenService.deleteBegen(urunId,username);
    }

    @Override
    @GetMapping(path = "/{username}")
    public List<DtoBegen> findByUsername(@PathVariable(name = "username" , required = true) String username) {
        return begenService.findByUsername(username);
    }

}

package com.tugra.controller.impl;

import com.tugra.controller.SatinAlinanlarController;
import com.tugra.dto.DtoSatinAlinanlar;
import com.tugra.service.SatinAlinanlarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/satin-alinanlar")
public class SatinAlinanlarControllerImpl implements SatinAlinanlarController {

    @Autowired
    private SatinAlinanlarService satinAlinanlarService;


    @Override
    @PostMapping(path = "/{username}")
    public List<DtoSatinAlinanlar> satinAlByUsername(@PathVariable(name = "username" ,required = true) String username) {
        return satinAlinanlarService.satinAlByUsername(username);
    }

    @Override
    @GetMapping(path = "/getir/{username}")
    public List<DtoSatinAlinanlar> satinAlinanlarByUsername(@PathVariable(name = "username") String username) {
        return satinAlinanlarService.satinAlinanlarByUsername(username);
    }

}

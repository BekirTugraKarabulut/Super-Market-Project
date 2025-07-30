package com.tugra.controller.impl;

import com.tugra.controller.SatinAlinanlarController;
import com.tugra.dto.DtoSatinAlinanlar;
import com.tugra.service.SatinAlinanlarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

}

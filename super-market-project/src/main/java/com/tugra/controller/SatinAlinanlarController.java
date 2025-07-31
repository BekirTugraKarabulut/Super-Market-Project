package com.tugra.controller;

import com.tugra.dto.DtoSatinAlinanlar;

import java.util.List;

public interface SatinAlinanlarController {

    public List<DtoSatinAlinanlar> satinAlByUsername(String username);

    public List<DtoSatinAlinanlar> satinAlinanlarByUsername(String username);

}

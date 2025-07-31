package com.tugra.service;

import com.tugra.dto.DtoSatinAlinanlar;

import java.util.List;

public interface SatinAlinanlarService {

    public List<DtoSatinAlinanlar> satinAlByUsername(String username);

    public List<DtoSatinAlinanlar> satinAlinanlarByUsername(String username);

}

package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoSatinAlinanlar {

    private Long satinAlinanlarId;

    private DtoKullanici kullanici;

    private DtoUrunler urunler;
}

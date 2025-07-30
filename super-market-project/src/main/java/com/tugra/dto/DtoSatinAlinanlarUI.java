package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoSatinAlinanlarUI {

    private Long satinAlinanlarId;

    private DtoKullanici kullanici;

    private DtoUrunler urunler;
}

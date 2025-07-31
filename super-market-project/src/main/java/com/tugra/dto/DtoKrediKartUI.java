package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoKrediKartUI {

    private Long krediKartId;

    private String kartNumarasi;

    private String gecerlilikTarihi;

    private String cvv;

    private DtoKullanici kullanici;

}

package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoUrunler {

    private Long urunId;

    private String urunAdi;

    private String urunResmi;

    private double urunFiyati;

}

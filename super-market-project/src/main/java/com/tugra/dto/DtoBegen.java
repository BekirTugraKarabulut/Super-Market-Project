package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoBegen {

    private Long begenId;

    private DtoUrunler urunler;

    private DtoKullanici kullanici;


}

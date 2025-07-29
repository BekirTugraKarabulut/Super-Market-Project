package com.tugra.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoBegenUI {

    private Long begenId;

    private DtoUrunler urunler;

    private DtoKullanici kullanici;

}

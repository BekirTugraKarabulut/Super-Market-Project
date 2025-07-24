package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "ana_kategori")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AnaKategori {

    @Id
    @Column(name = "ana_kategori_id")
    private Long anaKategoriId;

    @Column(name = "ana_kategori_adi")
    private String anaKategoriAdi;

    @OneToMany(mappedBy = "anaKategori" ,  fetch = FetchType.LAZY)
    private List<Kategoriler> kategoriler;

    @OneToMany(mappedBy = "anaKategori")
    private List<Urunler> urunler;

}

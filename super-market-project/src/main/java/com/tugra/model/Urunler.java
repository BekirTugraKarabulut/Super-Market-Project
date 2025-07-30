package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "urunler")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Urunler {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "urun_id")
    private Long urunId;

    @Column(name = "urun_adi")
    private String urunAdi;

    @Column(name = "urun_fiyati")
    private double urunFiyati;

    @Column(name = "urun_resmi")
    private String urunResmi;

    @OneToMany(fetch = FetchType.LAZY)
    private List<Begen> begen;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "kategori_id" ,referencedColumnName = "kategori_id")
    private Kategoriler kategoriler;

    @OneToMany(mappedBy = "urunler", fetch = FetchType.LAZY)
    private List<SatinAlinanlar> satinAlinanlar;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ana_kategori_id" , referencedColumnName = "ana_kategori_id")
    private AnaKategori anaKategori;

    @OneToMany(mappedBy = "urunler",cascade = CascadeType.ALL , fetch = FetchType.LAZY)
    private List<Sepet> sepet;

}

package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "kategoriler")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Kategoriler {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "kategori_id")
    private Long kategoriId;

    @Column(name = "kategori_adi")
    private String kategoriAdi;

    @JoinColumn(name = "ana_kategori_id" , referencedColumnName = "ana_kategori_id")
    @ManyToOne(fetch =  FetchType.LAZY ,  cascade = CascadeType.ALL)
    private AnaKategori anaKategori;

    @OneToMany(mappedBy = "kategoriler")
    private List<Urunler> urunler;


}

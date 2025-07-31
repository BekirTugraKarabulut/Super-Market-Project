package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "kredi_kart")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class KrediKart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "kredi_kart_id")
    private Long krediKartId;

    @Column(name = "kart_numarasi")
    private String kartNumarasi;

    @Column(name = "gecerlilik_tarihi")
    private String gecerlilikTarihi;

    @Column(name = "cvv")
    private String cvv;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username" , referencedColumnName = "username")
    private Kullanici kullanici;

}

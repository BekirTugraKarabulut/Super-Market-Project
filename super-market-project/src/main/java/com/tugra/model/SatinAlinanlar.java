package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Entity
@Table(name = "satin_alinanlar")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SatinAlinanlar {

    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    @Column(name = "satin_alinanlar_id")
    private Long satinAlinanlarId;

    @ManyToOne(fetch = FetchType.LAZY)
    private Kullanici kullanici;

    @ManyToOne(fetch = FetchType.LAZY)
    private Urunler urunler;

}

package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(
        name = "begen",
        uniqueConstraints = {@UniqueConstraint(columnNames = {"urun_id, username"})})
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Begen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "begen_id")
    private Long begenId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "urun_id" , referencedColumnName = "urun_id")
    private Urunler urunler;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username" , referencedColumnName = "username")
    private Kullanici kullanici;

}

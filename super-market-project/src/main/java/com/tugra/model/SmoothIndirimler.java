package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "smooth_indirimler")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SmoothIndirimler {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "smooth_id")
    private Long smoothId;

    @Column(name = "resim_adi")
    private String resimAdi;

}

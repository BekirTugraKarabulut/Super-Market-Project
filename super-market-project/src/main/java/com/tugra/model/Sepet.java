package com.tugra.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(
        name = "sepet",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"username", "urun_id"})
        }
)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Sepet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long sepetId;

    @ManyToOne(fetch =  FetchType.LAZY)
    @JoinColumn(name = "username", referencedColumnName = "username")
    private Kullanici kullanici;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "urun_id", referencedColumnName = "urun_id")
    private Urunler urunler;

}

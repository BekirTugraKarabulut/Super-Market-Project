package com.tugra.repository;

import com.tugra.model.Urunler;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface UrunlerRepository extends JpaRepository<Urunler,Long> {

    Optional<Urunler> findByKategoriler_KategoriId(Long kategorilerKategoriId);

}

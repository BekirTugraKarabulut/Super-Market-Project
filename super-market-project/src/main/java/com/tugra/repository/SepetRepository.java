package com.tugra.repository;

import com.tugra.model.Sepet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SepetRepository extends JpaRepository<Sepet,Long> {

    List<Sepet> findByKullanici_username(String username);

    Optional<Sepet> findByKullanici_UsernameAndUrunler_UrunId(String username, Long urunId);

    List<Sepet> findByKullanici_Username(String username);
}

package com.tugra.repository;

import com.tugra.model.Begen;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BegenRepository extends JpaRepository<Begen,Long> {

    Optional<Begen> findByBegenId(Long begenId);

    List<Begen> findByKullanici_Username(String username);

    void deleteByUrunler_UrunIdAndKullanici_Username(Long urunId, String username);

}

package com.tugra.repository;

import com.tugra.model.KrediKart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface KrediKartRepository extends JpaRepository<KrediKart,Long> {

      List<KrediKart> findByKullanici_Username(String username);

}

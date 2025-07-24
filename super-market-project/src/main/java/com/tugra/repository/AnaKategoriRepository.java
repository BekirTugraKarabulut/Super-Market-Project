package com.tugra.repository;

import com.tugra.model.AnaKategori;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AnaKategoriRepository extends JpaRepository<AnaKategori,Long> {


}

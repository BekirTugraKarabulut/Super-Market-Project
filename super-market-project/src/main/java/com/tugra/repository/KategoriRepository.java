package com.tugra.repository;

import com.tugra.model.Kategoriler;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KategoriRepository extends JpaRepository<Kategoriler,Long> {


}

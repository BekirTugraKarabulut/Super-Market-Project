package com.tugra.repository;

import com.tugra.model.SatinAlinanlar;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SatinAlinanlarRepository extends JpaRepository<SatinAlinanlar, Long> {

}

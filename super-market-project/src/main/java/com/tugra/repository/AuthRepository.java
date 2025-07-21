package com.tugra.repository;

import com.tugra.model.Kullanici;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AuthRepository extends JpaRepository<Kullanici,String> {

    Optional<Kullanici> findByUsername(String username);

    Optional<Kullanici> findByTelefonNo(String telefonNo);

}

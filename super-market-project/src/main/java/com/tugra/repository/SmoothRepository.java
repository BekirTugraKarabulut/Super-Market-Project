package com.tugra.repository;

import com.tugra.model.SmoothIndirimler;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SmoothRepository extends JpaRepository<SmoothIndirimler , Long> {


}

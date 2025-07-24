package com.tugra.service.impl;

import com.tugra.repository.KategoriRepository;
import com.tugra.service.KategoriService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KategoriServiceImpl implements KategoriService {

    @Autowired
    private KategoriRepository kategoriRepository;




}

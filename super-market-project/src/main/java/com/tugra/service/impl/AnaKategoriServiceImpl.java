package com.tugra.service.impl;

import com.tugra.dto.DtoAnaKategori;
import com.tugra.dto.DtoAnaKategoriUI;
import com.tugra.model.AnaKategori;
import com.tugra.repository.AnaKategoriRepository;
import com.tugra.service.AnaKategoriService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AnaKategoriServiceImpl implements AnaKategoriService {

    @Autowired
    private AnaKategoriRepository anaKategoriRepository;

    @Override
    public DtoAnaKategori ekleAnaKategori(DtoAnaKategoriUI dtoAnaKategoriUI) {

        AnaKategori anaKategori = new AnaKategori();

        anaKategori.setAnaKategoriId(dtoAnaKategoriUI.getAnaKategoriId());
        anaKategori.setAnaKategoriAdi(dtoAnaKategoriUI.getAnaKategoriAdi());

        AnaKategori dbAnaKategori = anaKategoriRepository.save(anaKategori);
        DtoAnaKategori dtoAnaKategori = new DtoAnaKategori();

        BeanUtils.copyProperties(dbAnaKategori, dtoAnaKategori);

        return dtoAnaKategori;
    }
}

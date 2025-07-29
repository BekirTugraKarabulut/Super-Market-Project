package com.tugra.service.impl;

import com.tugra.dto.DtoUrunler;
import com.tugra.dto.DtoUrunlerUI;
import com.tugra.model.Urunler;
import com.tugra.repository.UrunlerRepository;
import com.tugra.service.UrunlerService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UrunlerServiceImpl implements UrunlerService {

    @Autowired
    private UrunlerRepository urunlerRepository;

    @Override
    public List<DtoUrunler> getAllUrunler() {

        List<Urunler> urunlers = urunlerRepository.findAll();
        List<DtoUrunler> dtoUrunlers = new ArrayList<>();

        if (urunlers.isEmpty()) {
            return null;
        }

        for (Urunler urunler : urunlers) {
            DtoUrunler dtoUrunler = new DtoUrunler();
            BeanUtils.copyProperties(urunler, dtoUrunler);
            dtoUrunlers.add(dtoUrunler);
        }

        return dtoUrunlers;
    }

    @Override
    public DtoUrunler urunEkle(DtoUrunlerUI dtoUrunlerUI) {

        Urunler urun = new Urunler();

        urun.setUrunAdi(dtoUrunlerUI.getUrunAdi());
        urun.setUrunFiyati(dtoUrunlerUI.getUrunFiyati());

        if(urun.getUrunFiyati() < 0 ){
            return null;
        }

        Urunler dbUrun = urunlerRepository.save(urun);
        DtoUrunler dtoUrunler = new DtoUrunler();
        BeanUtils.copyProperties(dbUrun, dtoUrunler);

        return dtoUrunler;
    }

    @Override
    public List<DtoUrunler> getUrunlerByKategoriId(Long kategorilerKategoriId) {

        List<Urunler> urun = urunlerRepository.findAll();
        List<DtoUrunler> dtoUrunlers = new ArrayList<>();

        if(urun.isEmpty()){
            return null;
        }

        for (Urunler urunler : urun) {
            if(urunler.getKategoriler().getKategoriId().equals(kategorilerKategoriId)){
                DtoUrunler dtoUrunler = new DtoUrunler();
                BeanUtils.copyProperties(urunler, dtoUrunler);
                dtoUrunlers.add(dtoUrunler);
            }
        }

        return dtoUrunlers;
    }
}

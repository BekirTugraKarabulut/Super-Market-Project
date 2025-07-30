package com.tugra.service.impl;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoSatinAlinanlar;
import com.tugra.dto.DtoUrunler;
import com.tugra.model.Kullanici;
import com.tugra.model.SatinAlinanlar;
import com.tugra.model.Sepet;
import com.tugra.model.Urunler;
import com.tugra.repository.AuthRepository;
import com.tugra.repository.SatinAlinanlarRepository;
import com.tugra.repository.SepetRepository;
import com.tugra.repository.UrunlerRepository;
import com.tugra.service.SatinAlinanlarService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class SatinAlinanlarServiceImpl implements SatinAlinanlarService {

    @Autowired
    private SatinAlinanlarRepository satinAlinanlarRepository;

    @Autowired
    private AuthRepository authRepository;

    @Autowired
    private UrunlerRepository urunlerRepository;

    @Autowired
    private SepetRepository sepetRepository;


    @Override
    public List<DtoSatinAlinanlar> satinAlByUsername(String username) {

        List<Sepet> sepetList = sepetRepository.findByKullanici_username(username);
        List<DtoSatinAlinanlar> dtoSatinAlinanlars = new ArrayList<>();

        if (sepetList.isEmpty()) {
            return null;
        }

        for(Sepet sepet : sepetList.stream().toList()) {

            SatinAlinanlar satinAlinanlar = new SatinAlinanlar();

            Optional<Kullanici> kullanici = authRepository.findByUsername(sepet.getKullanici().getUsername());

            if (kullanici.isEmpty()) {
                return null;
            }
            satinAlinanlar.setKullanici(kullanici.get());

            Optional<Urunler> urunler = urunlerRepository.findByUrunId(sepet.getUrunler().getUrunId());

            if (urunler.isEmpty()) {
                return null;
            }
            satinAlinanlar.setUrunler(urunler.get());

            SatinAlinanlar dbSatinAlinanlar = satinAlinanlarRepository.save(satinAlinanlar);

            DtoSatinAlinanlar dtoSatinAlinanlar = new DtoSatinAlinanlar();
            BeanUtils.copyProperties(dbSatinAlinanlar, dtoSatinAlinanlar);

            DtoKullanici dtoKullanici = new DtoKullanici();
            BeanUtils.copyProperties(dbSatinAlinanlar.getKullanici(), dtoKullanici);
            dtoSatinAlinanlar.setKullanici(dtoKullanici);

            DtoUrunler dtoUrunler = new DtoUrunler();
            BeanUtils.copyProperties(dbSatinAlinanlar.getUrunler(), dtoUrunler);
            dtoSatinAlinanlar.setUrunler(dtoUrunler);

            dtoSatinAlinanlars.add(dtoSatinAlinanlar);
        }

        return dtoSatinAlinanlars;
    }

}

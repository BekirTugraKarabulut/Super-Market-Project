package com.tugra.service.impl;

import com.tugra.dto.DtoKrediKart;
import com.tugra.dto.DtoKrediKartUI;
import com.tugra.dto.DtoKullanici;
import com.tugra.model.KrediKart;
import com.tugra.model.Kullanici;
import com.tugra.repository.AuthRepository;
import com.tugra.repository.KrediKartRepository;
import com.tugra.service.KrediKartService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class KrediKartServiceImpl implements KrediKartService {

    @Autowired
    private KrediKartRepository krediKartRepository;

    @Autowired
    private AuthRepository authRepository;

    @Override
    public DtoKrediKart kartEkle(DtoKrediKartUI dtoKrediKartUI) {

        KrediKart krediKart = new KrediKart();

        krediKart.setKartNumarasi(dtoKrediKartUI.getKartNumarasi());
        krediKart.setGecerlilikTarihi(dtoKrediKartUI.getGecerlilikTarihi());
        krediKart.setCvv(dtoKrediKartUI.getCvv());

        Kullanici kullanici = new Kullanici();
        kullanici.setUsername(dtoKrediKartUI.getKullanici().getUsername());
        Optional<Kullanici> kullaniciOptional = authRepository.findByUsername(kullanici.getUsername());

        if (kullaniciOptional.isEmpty()){
            return null;
        }

        krediKart.setKullanici(kullaniciOptional.get());
        KrediKart dbKrediKart = krediKartRepository.save(krediKart);

        DtoKrediKart dtoKrediKart = new DtoKrediKart();
        BeanUtils.copyProperties(dbKrediKart,dtoKrediKart);

        DtoKullanici dtoKullanici = new DtoKullanici();
        BeanUtils.copyProperties(dbKrediKart.getKullanici(), dtoKullanici);
        dtoKrediKart.setKullanici(dtoKullanici);

        return dtoKrediKart;
    }

    @Override
    public List<DtoKrediKart> kartlariGetir(String username) {

        List<KrediKart> krediKartlar = krediKartRepository.findByKullanici_Username(username);
        List<DtoKrediKart> dtoKrediKarts = new ArrayList<>();

        if(krediKartlar.isEmpty()){
            return null;
        }

        for(KrediKart krediKart : krediKartlar){
            DtoKrediKart dtoKrediKart = new DtoKrediKart();
            BeanUtils.copyProperties(krediKart, dtoKrediKart);

            DtoKullanici dtoKullanici = new DtoKullanici();
            BeanUtils.copyProperties(krediKart.getKullanici(), dtoKullanici);
            dtoKrediKart.setKullanici(dtoKullanici);

            dtoKrediKarts.add(dtoKrediKart);
        }

        return dtoKrediKarts;
    }
}




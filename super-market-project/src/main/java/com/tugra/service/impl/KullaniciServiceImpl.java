package com.tugra.service.impl;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoKullaniciGuncelle;
import com.tugra.model.Kullanici;
import com.tugra.repository.KullaniciRepository;
import com.tugra.service.KullaniciService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class KullaniciServiceImpl implements KullaniciService {

    @Autowired
    private KullaniciRepository kullaniciRepository;

    @Override
    public DtoKullanici getKullanici(String username) {

        Optional<Kullanici> kullanici = kullaniciRepository.findByUsername(username);

        if(kullanici.isEmpty()){
            return  null;
        }

        DtoKullanici dtoKullanici = new DtoKullanici();
        BeanUtils.copyProperties(kullanici.get(),dtoKullanici);

        return dtoKullanici;
    }

    @Override
    public DtoKullanici guncelleKullanici(String username,DtoKullaniciGuncelle dtoKullaniciGuncelle) {

        Optional<Kullanici> kullanici = kullaniciRepository.findByUsername(username);
        DtoKullanici dtoKullanici = new DtoKullanici();

        if(kullanici.isEmpty()){
            return null;
        }

        kullanici.get().setUsername(username);
        kullanici.get().setKullaniciAd(dtoKullaniciGuncelle.getKullaniciAd());
        kullanici.get().setAdres(dtoKullaniciGuncelle.getAdres());
        kullanici.get().setPassword(kullanici.get().getPassword());
        kullanici.get().setTelefonNo(dtoKullaniciGuncelle.getTelefonNo());

        Kullanici updateKullanici = kullaniciRepository.save(kullanici.get());
        BeanUtils.copyProperties(updateKullanici,dtoKullanici);

        return dtoKullanici;
    }


}

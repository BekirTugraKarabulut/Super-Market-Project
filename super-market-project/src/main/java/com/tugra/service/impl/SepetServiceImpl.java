package com.tugra.service.impl;

import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoSepet;
import com.tugra.dto.DtoSepetUI;
import com.tugra.dto.DtoUrunler;
import com.tugra.model.Kullanici;
import com.tugra.model.Sepet;
import com.tugra.model.Urunler;
import com.tugra.repository.AuthRepository;
import com.tugra.repository.SepetRepository;
import com.tugra.repository.UrunlerRepository;
import com.tugra.service.SepetService;
import jakarta.transaction.Transactional;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class SepetServiceImpl implements SepetService {

    @Autowired
    private SepetRepository sepetRepository;

    @Autowired
    private AuthRepository authRepository;

    @Autowired
    private UrunlerRepository urunlerRepository;


    @Override
    public List<DtoSepet> findByKullanici_username(String username) {

        List<Sepet> sepetList = sepetRepository.findByKullanici_username(username);
        List<DtoSepet> dtoSepetList = new ArrayList<>();

        if(sepetList.isEmpty()){
            return null;
        }

        for(Sepet sepet : sepetList){
            DtoSepet dtoSepet = new DtoSepet();
            BeanUtils.copyProperties(sepet,dtoSepet);

            DtoUrunler dtoUrunler = new DtoUrunler();
            BeanUtils.copyProperties(sepet.getUrunler(),dtoUrunler);
            dtoSepet.setUrunler(dtoUrunler);

            DtoKullanici dtoKullanici = new DtoKullanici();
            BeanUtils.copyProperties(sepet.getKullanici(),dtoKullanici);
            dtoSepet.setKullanici(dtoKullanici);

            dtoSepetList.add(dtoSepet);

        }
        return dtoSepetList;
    }

    @Override
    public double sepetToplamTutari(String username) {

        List<Sepet> sepetList = sepetRepository.findByKullanici_username(username);
        List<DtoSepet> dtoSepetList = new ArrayList<>();

        if(sepetList.isEmpty()){
            return 0.0;
        }

        for(Sepet sepet : sepetList){
            DtoSepet dtoSepet = new DtoSepet();
            BeanUtils.copyProperties(sepet, dtoSepet);

            DtoUrunler dtoUrunler = new DtoUrunler();
            BeanUtils.copyProperties(sepet.getUrunler(), dtoUrunler);
            dtoSepet.setUrunler(dtoUrunler);

            DtoKullanici dtoKullanici = new DtoKullanici();
            BeanUtils.copyProperties(sepet.getKullanici(), dtoKullanici);
            dtoSepet.setKullanici(dtoKullanici);

            double totalPrice = 0.0;
            totalPrice = totalPrice + sepet.getUrunler().getUrunFiyati();
            dtoSepetList.add(dtoSepet);
        }

        return dtoSepetList.stream()
                .mapToDouble(sepet -> sepet.getUrunler().getUrunFiyati())
                .sum();
    }

    @Override
    public DtoSepet sepeteEkle(DtoSepetUI dtoSepetUI) {

        Sepet sepet = new Sepet();

        Kullanici kullanici = new Kullanici();
        kullanici.setUsername(dtoSepetUI.getKullanici().getUsername());

        Optional<Kullanici> dbKullanici = authRepository.findByUsername(kullanici.getUsername());

        if (dbKullanici.isEmpty()){
            return null;
        }

        sepet.setKullanici(dbKullanici.get());

        Urunler urunler = new Urunler();
        urunler.setUrunId(dtoSepetUI.getUrunler().getUrunId());

        Optional<Urunler> dbUrun = urunlerRepository.findByUrunId(urunler.getUrunId());

        if (dbUrun.isEmpty()){
            return null;
        }

        sepet.setUrunler(dbUrun.get());
        Sepet dbSepet = sepetRepository.save(sepet);

        DtoSepet dtoSepet = new DtoSepet();
        BeanUtils.copyProperties(dbSepet,dtoSepet);

        DtoKullanici dtoKullanici = new DtoKullanici();
        BeanUtils.copyProperties(dbSepet.getKullanici(),dtoKullanici);
        dtoSepet.setKullanici(dtoKullanici);

        DtoUrunler dtoUrunler = new DtoUrunler();
        BeanUtils.copyProperties(dbSepet.getUrunler(),dtoUrunler);
        dtoSepet.setUrunler(dtoUrunler);

        return dtoSepet;
    }

    @Transactional
    @Override
    public void deleteByKullanici_usernameAndUrunler_UrunId(String username, Long urunId) {

        Optional<Kullanici> kullanici = authRepository.findByUsername(username);

        if (kullanici.isEmpty()){
            return;
        }

        Optional<Urunler> urun = urunlerRepository.findByUrunId(urunId);

        if (urun.isEmpty()){
            return;
        }

        Optional<Sepet> sepet = sepetRepository.findByKullanici_UsernameAndUrunler_UrunId(kullanici.get().getUsername(), urun.get().getUrunId());

        if (sepet.isEmpty()){
            return;
        }

        sepetRepository.delete(sepet.get());
    }
}

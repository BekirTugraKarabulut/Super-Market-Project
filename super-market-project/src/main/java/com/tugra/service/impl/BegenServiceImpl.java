package com.tugra.service.impl;

import com.tugra.dto.DtoBegen;
import com.tugra.dto.DtoBegenUI;
import com.tugra.dto.DtoKullanici;
import com.tugra.dto.DtoUrunler;
import com.tugra.exception.BaseException;
import com.tugra.exception.ErrorMessage;
import com.tugra.exception.MessageType;
import com.tugra.model.Begen;
import com.tugra.model.Kullanici;
import com.tugra.model.Urunler;
import com.tugra.repository.AuthRepository;
import com.tugra.repository.BegenRepository;
import com.tugra.repository.UrunlerRepository;
import com.tugra.service.BegenService;
import jakarta.transaction.Transactional;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class BegenServiceImpl implements BegenService {

    @Autowired
    private BegenRepository begenRepository;

    @Autowired
    private AuthRepository authRepository;

    @Autowired
    private UrunlerRepository urunlerRepository;

    @Override
    public DtoBegen begenEkle(DtoBegenUI dtoBegenUI) {

        Begen begen = new Begen();

        Kullanici kullanici = new Kullanici();
        kullanici.setUsername(dtoBegenUI.getKullanici().getUsername());

        Optional<Kullanici> kullaniciOptional = authRepository.findByUsername(kullanici.getUsername());

        if(kullaniciOptional.isEmpty()){
            return null;
        }

        begen.setKullanici(kullaniciOptional.get());

        Urunler urunler = new Urunler();
        urunler.setUrunId(dtoBegenUI.getUrunler().getUrunId());

        Optional<Urunler> urunlerOptional = urunlerRepository.findByUrunId(urunler.getUrunId());

        if(urunlerOptional.isEmpty()){
            return null;
        }

        begen.setUrunler(urunlerOptional.get());
        Begen dbBegen = begenRepository.save(begen);

        DtoBegen dtoBegen =  new DtoBegen();
        BeanUtils.copyProperties(dbBegen, dtoBegen);

        DtoUrunler dtoUrunler = new DtoUrunler();
        BeanUtils.copyProperties(dbBegen.getUrunler(), dtoUrunler);

        dtoBegen.setUrunler(dtoUrunler);

        DtoKullanici dtoKullanici = new DtoKullanici();
        BeanUtils.copyProperties(dbBegen.getKullanici(), dtoKullanici);

        dtoBegen.setKullanici(dtoKullanici);

        return dtoBegen;
    }

    @Transactional
    @Override
    public void deleteBegen(Long urunId , String username) {

        Optional<Urunler> urunlerOptional = urunlerRepository.findByUrunId(urunId);

        if(urunlerOptional.isEmpty()){
            throw new BaseException(new ErrorMessage(MessageType.URUN_BULUNAMADI , urunId.toString()));
        }

        Optional<Kullanici> kullaniciOptional = authRepository.findByUsername(username);

        if (kullaniciOptional.isEmpty()){
            throw new BaseException(new ErrorMessage(MessageType.KULLANICI_BULUNAMADI , username));
        }

        begenRepository.deleteByUrunler_UrunIdAndKullanici_Username(urunId, username);
    }

    @Override
    public List<DtoBegen> findByUsername(String username) {

    List<Begen> begenList = begenRepository.findByKullanici_Username(username);
    List<DtoBegen> dtoBegenList = new ArrayList<>();

    if(begenList.isEmpty()){
        return null;
    }

    for (Begen begen : begenList) {

        DtoBegen dtoBegen =  new DtoBegen();
        BeanUtils.copyProperties(begen, dtoBegen);

        DtoUrunler dtoUrunler = new DtoUrunler();
        BeanUtils.copyProperties(begen.getUrunler(), dtoUrunler);

        dtoBegen.setUrunler(dtoUrunler);

        DtoKullanici dtoKullanici = new DtoKullanici();
        BeanUtils.copyProperties(begen.getKullanici(), dtoKullanici);

        dtoBegen.setKullanici(dtoKullanici);

        dtoBegenList.add(dtoBegen);
    }

        return dtoBegenList;
    }

}

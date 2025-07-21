package com.tugra.service.impl;

import com.tugra.dto.DtoSmooth;
import com.tugra.model.SmoothIndirimler;
import com.tugra.repository.SmoothRepository;
import com.tugra.service.SmoothService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SmoothServiceImpl implements SmoothService {

    @Autowired
    private SmoothRepository smoothRepository;


    @Override
    public List<DtoSmooth> getAllSmooth() {

        List<SmoothIndirimler> smoothIndirimlers = smoothRepository.findAll();
        List<DtoSmooth> dtoSmooths = new ArrayList<>();

        if(smoothIndirimlers.isEmpty()){
            return null;
        }

        for (SmoothIndirimler smoothIndirimler : smoothIndirimlers) {
            DtoSmooth dtoSmooth = new DtoSmooth();
            BeanUtils.copyProperties(smoothIndirimler, dtoSmooth);
            dtoSmooths.add(dtoSmooth);
        }

        return dtoSmooths;
    }
}

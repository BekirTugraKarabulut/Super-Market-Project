package com.tugra.controller.impl;

import com.tugra.controller.SmoothController;
import com.tugra.dto.DtoSmooth;
import com.tugra.service.SmoothService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class SmoothControllerImpl implements SmoothController {


    @Autowired
    private SmoothService smoothService;

    @Override
    @GetMapping(path = "/all-smooth")
    public List<DtoSmooth> getAllSmooth() {
        return smoothService.getAllSmooth();
    }

}

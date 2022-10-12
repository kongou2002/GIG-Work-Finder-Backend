package com.seal.api.gwf.controller;

import com.seal.api.gwf.dto.Business;
import com.seal.api.gwf.service.BusinessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("Business")
public class BusinessContrroller {
    @Autowired
    BusinessService businessService;


    @GetMapping("/ID/{id}")
    public Business getById(@PathVariable int id) {return businessService.getByID(id);}

    @GetMapping(value = { "/ALL"})
    @ResponseBody
    public List<Business> getAllJobOffers(@RequestParam(required = false) Integer limit) {
        if (limit == null)
            return businessService.getAllBusiness(0);
        else
            return businessService.getAllBusiness(limit);
    }
}
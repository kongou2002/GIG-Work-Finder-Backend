package com.seal.api.gwf.controller;

import com.seal.api.gwf.entity.ReviewDetailEntity;
import com.seal.api.gwf.service.ReviewDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("RD")
public class ReviewDetailController {
    @Autowired
    ReviewDetailService reviewDetailService;

    @GetMapping("/ID/{id}")
    public ReviewDetailEntity getByID(@PathVariable int id) {return reviewDetailService.getByID(id);}

    @GetMapping("/AID/{id}")
    public List<ReviewDetailEntity> getByAccountID(@PathVariable int id) {return reviewDetailService.getByAccountID(id);}
}

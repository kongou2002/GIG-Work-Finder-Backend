package com.seal.api.gwf.controller;

import com.seal.api.gwf.dto.JobOffer;
import com.seal.api.gwf.dto.create.JobOfferForm;
import com.seal.api.gwf.entity.JobOfferEntity;
import com.seal.api.gwf.service.CreateJOService;
import com.seal.api.gwf.service.JobOfferService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "JobOffer")
public class JobOfferController {

    @Autowired
    JobOfferService jobOfferService;
    @Autowired
    CreateJOService createJOService;

    //Test Entity
    @GetMapping("/Test/{id}")
    public JobOfferEntity test(@PathVariable int id)  {return jobOfferService.getByID(id);}




    @GetMapping("/ID/{id}")
    public JobOffer getByOfferID(@PathVariable int id) {return jobOfferService.findByOfferID(id);}

    @GetMapping("/BusinessID/{id}")
    public List<JobOffer> getByBusinessID(@PathVariable int id) {return jobOfferService.findByBusinessID(id);}

    @GetMapping(value = { "/ALL"})
    @ResponseBody
    public List<JobOffer> getAllJobOffers(@RequestParam(required = false) Integer limit) {
        if (limit == null)
            return jobOfferService.getAllJobOffers(0);
        else
            return jobOfferService.getAllJobOffers(limit);
    }
    @GetMapping("/GetHurry")
    @ResponseBody
    public List<JobOffer> getHurryJobOffers(@RequestParam(required = false) Integer limit){
        if (limit == null)
            return jobOfferService.getHurryJobOffers(0);
        else
            return jobOfferService.getHurryJobOffers(limit);
    }

    @GetMapping("/GetPopular")
    @ResponseBody
    public List<JobOffer> getPopularJobOffers(@RequestParam(required = false) Integer limit) {
        if (limit == null)
            return jobOfferService.getPopularJobOffers(0);
        else
            return jobOfferService.getPopularJobOffers(limit);
    }

    @GetMapping("/CreateJO/{id}")
    public CreateJOService.CreateJO getInfo(@PathVariable int id){
        return createJOService.getInfo(id);
    }

    @PostMapping("/CreateJO")
    public ResponseEntity createJO(@ModelAttribute JobOfferForm joe) {
        jobOfferService.createJO(joe);
        return ResponseEntity.ok(HttpStatus.OK);
    }
}

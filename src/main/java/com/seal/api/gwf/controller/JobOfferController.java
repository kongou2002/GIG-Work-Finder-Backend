package com.seal.api.gwf.controller;

import com.seal.api.gwf.dto.JobOffer;
import com.seal.api.gwf.dto.create.JobOfferForm;
import com.seal.api.gwf.dto.get.AllJobOffer;
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

    @GetMapping("/GetAllJO/{aid}")
    public List<JobOffer> getAllJobOffersByAID(@PathVariable int aid) {return jobOfferService.getAllJobOffersByAID(aid);}

    @GetMapping("/GetAllJOActive/{aid}")
    public List<JobOffer> getAllJobOffersByAIDActive(@PathVariable int aid) {return jobOfferService.getAllJobOffersByAIDStatus(aid ,1);}

    @GetMapping("/GetAllJOUnActive/{aid}")
    public List<JobOffer> getAllJobOffersByAIDUnActive(@PathVariable int aid) {return jobOfferService.getAllJobOffersByAIDStatus(aid ,0);}

    @GetMapping("/AppIDUnValid/{aid}")
    public List<AllJobOffer> getAllJOByApplicantIDUnValid(@PathVariable int aid){
        return jobOfferService.getAllJOOfferedByApplicantID(aid);
    }

    @GetMapping("/AppIDValid/{aid}")
    public List<AllJobOffer> getAllJOByApplicantIDValid(@PathVariable int aid){
        return jobOfferService.getAllJOValidAndFinishByApplicantID(aid, 1);
    }

    @GetMapping("/AppIDFinish/{aid}")
    public List<AllJobOffer> getAllJOByApplicantIDFinish(@PathVariable int aid){
        return jobOfferService.getAllJOValidAndFinishByApplicantID(aid, 2);
    }

    @PostMapping("/ApplyJO")
    public ResponseEntity<?> applyJO(@RequestParam(value = "oid") int oid,
                                     @RequestParam(value = "jaid") int jaid){
        try {
            Integer result = jobOfferService.applyJO(oid, jaid);
            if (result == 1)
                return ResponseEntity.ok(HttpStatus.OK);
            else
                return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(null);
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getStackTrace());
        }
    }

    @GetMapping("/CreateJO/{id}")
    public CreateJOService.CreateJO getInfo(@PathVariable int id){
        return createJOService.getInfo(id);
    }

    @PostMapping("/CreateJO")
    public ResponseEntity<?> createJO(@RequestBody JobOfferForm joe) {
        try {
            Integer result = jobOfferService.createJO(joe);
            if (result == 1)
                return ResponseEntity.ok(HttpStatus.OK);
            else
                return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(null);
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getStackTrace());
        }

    }

    @PutMapping("/UpdateJO")
    public ResponseEntity<?> updateJO(@RequestBody JobOfferForm joe){
        try{
            Integer result = jobOfferService.updateJO(joe);
            if (result == 1)
                return ResponseEntity.ok(HttpStatus.OK);
            else
                return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(null);
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getStackTrace());
        }
    }

    @DeleteMapping("/DeleteJO/{id}")
    public ResponseEntity<?> deleteJO(@PathVariable int id){
        try{
        Integer result = jobOfferService.deleteJO(id);
        if (result == 1)
            return ResponseEntity.ok(HttpStatus.OK);
        else
            return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(null);
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getStackTrace());
        }
    }
}

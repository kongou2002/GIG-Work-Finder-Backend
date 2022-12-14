package com.seal.api.gwf.controller;

import com.seal.api.gwf.dto.Business;
import com.seal.api.gwf.dto.create.BusinessForm;
import com.seal.api.gwf.service.BusinessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("Business")
public class BusinessController {
    @Autowired
    BusinessService businessService;


    @GetMapping("/ID/{id}")
    public Business getById(@PathVariable int id) {
        return businessService.getByID(id);
    }

    @GetMapping("/AID/{aid}")
    public List<Business> getByAccountId(@PathVariable int aid) {
        return businessService.getByAccountID(aid);
    }

    @GetMapping(value = {"/ALL"})
    @ResponseBody
    public List<Business> getAllJobOffers(@RequestParam(required = false) Integer limit) {
        if (limit == null)
            return businessService.getAllBusiness(0);
        else
            return businessService.getAllBusiness(limit);
    }

    @PostMapping("/CreateBu")
    public ResponseEntity<?> createBu(@RequestParam("locationID") Integer locationID,
                                      @RequestParam("accountID") Integer accountID,
                                      @RequestParam(value = "address", required = false) String address,
                                      @RequestParam(value = "businessName", required = false) String businessName,
                                      @RequestParam(value = "businessLogo", required = false) String businessLogo,
                                      @RequestParam(value = "description", required = false) String description,
                                      @RequestParam(value = "benefit", required = false) String benefit) {
        try {
            if (address == null)
                address = "Chưa cập nhật";
            if (address.equals("undefined"))
                address = "Chưa cập nhật";
            if (businessName == null)
                businessName = "Chưa cập nhật";
            if (businessName.equals("undefined"))
                businessName = "Chưa cập nhật";
            if (businessLogo == null)
                businessLogo = "https://gwfapp.s3.ap-southeast-1.amazonaws.com/Pictures/NullLogo.png";
            if (businessLogo.equals("undefined"))
                businessLogo = "https://gwfapp.s3.ap-southeast-1.amazonaws.com/Pictures/NullLogo.png";
            if (description == null)
                description = "Chưa cập nhật";
            if (description.equals("undefined"))
                description = "Chưa cập nhật";
            if (benefit == null)
                benefit = "Chưa cập nhật";
            if (benefit.equals("undefined"))
                benefit = "Chưa cập nhật";
            BusinessForm bf = new BusinessForm(locationID, accountID, address, businessName, businessLogo, description, benefit);
            Integer result = businessService.createBu(bf);
            if (result == 1)
                return ResponseEntity.ok(HttpStatus.OK);
            else
                return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getStackTrace());
        }
    }

    @PutMapping("/UpdateBu")
    public ResponseEntity<?> UpdateBu(@RequestParam("businessID") Integer businessID,
                                      @RequestParam(value = "locationID", required = false) String LocationID,
                                      @RequestParam("accountID") Integer accountID,
                                      @RequestParam(value = "address", required = false) String address,
                                      @RequestParam(value = "businessName", required = false) String businessName,
                                      @RequestParam(value = "businessLogo", required = false) String businessLogo,
                                      @RequestParam(value = "description", required = false) String description,
                                      @RequestParam(value = "benefit", required = false) String benefit) {
        try {
            Integer locationID = null;
            if (LocationID != null)
                if (!LocationID.equals("undefined"))
                    locationID = Integer.parseInt(LocationID);
            if (address != null)
                if (address.equals("undefined"))
                    address = null;
            if (businessName != null)
                if (businessName.equals("undefined"))
                    businessName = null;
            if (businessLogo != null)
                if (businessLogo.equals("undefined"))
                    businessLogo = null;
            if (description != null)
                if (description.equals("undefined"))
                    description = null;
            if (benefit != null)
                if (benefit.equals("undefined"))
                    benefit = null;
            BusinessForm bf = new BusinessForm(businessID, locationID, accountID, address, businessName, businessLogo, description, benefit);
            Integer result = businessService.updateBu(bf);
            if (result == 1)
                return ResponseEntity.ok(HttpStatus.OK);
            else
                return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getStackTrace());
        }
    }
}

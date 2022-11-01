package com.seal.api.gwf.service;

import com.seal.api.gwf.dao.JobApplication;
import com.seal.api.gwf.dao.JobOffer;
import com.seal.api.gwf.dto.create.JobApplicationForm;
import com.seal.api.gwf.dto.get.AllJobApplication;
import com.seal.api.gwf.dto.get.AllJobOffer;
import com.seal.api.gwf.entity.JobApplicationEntity;
import com.seal.api.gwf.repository.JobApplicationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.util.List;

@Service
public class JobApplicationService {
    @Autowired
    JobApplicationRepository jobApplicationRepository;

    @Autowired
    JobApplication jobApplication;

    @Autowired
    JobOffer jobOffer;


    public List<JobApplicationEntity> getAll() {
        return jobApplicationRepository.getAll();
    }

    public List<JobApplicationEntity> getAllByOfferID(int offerID) {
        return jobApplicationRepository.getAllByOfferID(offerID);
    }

    public List<AllJobApplication> getAllJAByRecruiterIDUnValid(int aid) {
        return jobApplication.getAllJAByRecruiterIDUnValid(aid);
    }

    public List<AllJobApplication> getAllJAByRecruiterIDValid(int aid) {
        return jobApplication.getAllJAByRecruiterIDValid(aid);
    }

    public List<AllJobApplication> getAllJAByRecruiterIDFinish(int aid) {
        return jobApplication.getAllJAByRecruiterIDFinish(aid);
    }

    public List<AllJobOffer> getAllByApplicantID(int aid) {
        return jobOffer.getAllByApplicantID(aid);
    }

    public Integer updateJA(JobApplicationForm jaf){
        JobApplicationEntity jae = jobApplicationRepository.findByApplicationId(jaf.getApplicationID());

        Time startTime;
        if (jaf.getStartTime() == null) {
            startTime = jae.getStartTime();
        } else {
            startTime = Time.valueOf(jaf.getStartTime() + ":00");
        }
        Time endTime;
        if (jaf.getEndTime() == null) {
            endTime = jae.getEndTime();
        } else {
            endTime = Time.valueOf(jaf.getEndTime() + ":00");
        }

        if (jaf.getOther() == null) {
            jaf.setOther(jae.getOther());
        }
        return jobApplicationRepository.updateJA(jaf.getAccountID(), jaf.getOther(), startTime, endTime, jaf.getAvailable());
    }


    public Integer applyJA(Integer oid, int jaid, int aid) {
        return jobApplicationRepository.applyJA(oid, jaid, aid);
    }
}

package com.seal.api.gwf.service;

import com.seal.api.gwf.dto.JobOffer;
import com.seal.api.gwf.entity.JobOfferEntity;
import com.seal.api.gwf.repository.JobOfferRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class JobOfferService {

    @Autowired
    JobOfferRepository jobOfferRepository;
    @Autowired
    private ModelMapper mapper;

    //Test Entity
    public JobOfferEntity getByID(int ID){
        return jobOfferRepository.findByOfferID(ID);
    }


    public JobOffer findByOfferID(int ID) {
        JobOfferEntity jo =  jobOfferRepository.findByOfferID(ID);
        return mapper.map(jo, JobOffer.class);
    }

    public List<JobOffer> findByBusinessID(int ID) {

        List<JobOfferEntity> jo = jobOfferRepository.findByBusinessID(ID);
        ArrayList<JobOffer> list = new ArrayList<>();
        for (JobOfferEntity j :
                jo) {
            list.add(mapper.map(j, JobOffer.class));
        }
        return list;
    }

    public List<JobOffer> getAllJobOffers(int quantity){
        ArrayList<JobOfferEntity> jo = (ArrayList<JobOfferEntity>) jobOfferRepository.getAll();
        ArrayList<JobOffer> list = new ArrayList<>();
        for (JobOfferEntity j :
                jo) {
            list.add(mapper.map(j, JobOffer.class));
        }
        int max = list.size();
        if (quantity>=max || quantity == 0)
            return list;
        while (max > quantity){
            int randomIndex = (int)Math.floor(Math.random()*(max));
            list.remove(randomIndex);
            max--;
        }
        return list;
    }

    public List<JobOffer> getHurryJobOffers(int quantity){
        ArrayList<JobOfferEntity> jo = (ArrayList<JobOfferEntity>) jobOfferRepository.getHurryJobOffer();
        ArrayList<JobOffer> list = new ArrayList<>();
        for (JobOfferEntity j :
                jo) {
            list.add(mapper.map(j, JobOffer.class));
        }
        if (quantity==0 || quantity>= list.size())
            return list;
        else{
            return list.subList(0, quantity);
        }
    }


    public List<JobOffer> getPopularJobOffers(int quantity){
        ArrayList<JobOfferEntity> jo = (ArrayList<JobOfferEntity>) jobOfferRepository.getAll();
        ArrayList<JobOffer> list = new ArrayList<>();
        for (JobOfferEntity j :
                jo) {
            list.add(mapper.map(j, JobOffer.class));
        }
        //calculate popularScore
        for (JobOffer j :
                list) {
            j.setPopularScore(jobOfferRepository.calPopularScore(j.getOfferID()));
        }
        //sort lai theo popularScore DESC
        list.sort(((o1, o2) -> o2.getPopularScore().compareTo(o1.getPopularScore())));
        if (quantity==0 || quantity>= list.size())
            return list;
        else{
            return list.subList(0, quantity);
        }
    }

}

package com.seal.api.gwf.dto;

import com.seal.api.gwf.entity.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Time;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class JobOffer {

    private int offerID;

    private Recruiter recruiter;

    private JobType jobType;

    private Location location;

    private Degree degree;

    private Business business;

    private int numOfRecruit;

    private Date offerEndTime;

    private Date createdDate;

    private int status;

    private Integer salary;

    private Integer age;

    private Integer visual;

    private String jobDescription;

    private String other;

    private Time startTime;

    private Time endTime;

    private String address;

    private Float popularScore;

    private Set<CommentEntity> commentEntities = new HashSet<>();
}

package com.seal.api.gwf.entity;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Applicant")
public class ApplicantEntity {
    @Id
    @Column(name = "AccountID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int accountID;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "LocationID")
    private LocationEntity location;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "DegreeID")
    private DegreeEntity degree;


    @Column(name = "FirstName")
    private String firstName;

    @Column(name = "LastName")
    private String lastName;

    @Column(name = "Phone")
    private String phone;

    @Column(name = "DOB")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dob;

    @Column(name = "Gender")
    private String gender;

    @Column(name = "Email")
    private String email;

    @Column(name = "Address", columnDefinition = "ntext")
    private String address;

    @Column(name = "TotalOfReviews")
    private int totalOfReviews;

    @Column(name = "AverageStars")
    private Float averageStars;

    @Column(name = "Verify")
    private int verify;

    @Column(name = "Status")
    private int status;

    @Column(name = "Description", columnDefinition = "ntext")
    private String description;

    @Column(name = "Avatar")
    private String avatar;

    @Column(name = "Available")
    private int available;

    @JsonBackReference
    @OneToMany(mappedBy = "accountID",fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = JobApplicationEntity.class)
    private Set<JobApplicationEntity> jobApplications = new HashSet<>();

    //Ktra lai. ?
//    @JsonManagedReference
//    @OneToMany(mappedBy = "jobOffer",fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = CommentEntity.class)
//    private Set<CommentEntity> commentEntities = new HashSet<>();

//    @JsonManagedReference
//    @OneToMany(mappedBy = "createdBy",fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = ReviewDetailEntity.class)
//    private Set<ReviewDetailEntity> reviewDetailEntities = new HashSet<>();
}

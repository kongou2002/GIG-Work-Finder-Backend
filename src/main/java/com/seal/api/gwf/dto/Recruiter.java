package com.seal.api.gwf.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Recruiter {
    private int accountID;

    private String firstName;

    private String lastName;

    private String phone;

    private String email;

    private int totalOfReviews;

    private Float averageStars;

    private int verify;

    private String description;
}

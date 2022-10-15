package com.seal.api.gwf.authorization;

import com.seal.api.gwf.entity.RecruiterEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.GeneralSecurityException;

@RestController
@RequestMapping("Authorization")
public class AuthorizationController {

    @Autowired
    AuthorizationService authorizationService;
    @PostMapping("")
    public Data CheckAndCreateAccountAndAccountTokenForAuthorization(@RequestBody Data data){
            return authorizationService.CheckAndAuthorizationWithEmail(data.getEmail(), data.getRole(), data.getPicUrl());
    }
    @PostMapping("/google-verifier")
    public ResponseEntity GoogleVerifier(@RequestHeader(value = "Authorization") String idToken){
        Data data = new Data();
        String[] RequestToken = idToken.split(" ");
        String idTokenString = new String(RequestToken[1]);
        System.out.println(idTokenString);
        try {
             data = GoogleApiVerifier.VerifyGoogleToken(idTokenString);
        } catch (IOException exception){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("IOException!");
        } catch (GeneralSecurityException exception){
            return  ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("GeneralSecurityException!");
        }
//        if (data.getToken() == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Fail idToken!");
        return ResponseEntity.ok(data);
    }
}

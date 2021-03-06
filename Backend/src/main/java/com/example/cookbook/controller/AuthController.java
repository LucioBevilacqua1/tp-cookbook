package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;
import com.example.cookbook.dto.SigninDTO;
import java.util.HashMap;
import java.util.Map;
import com.example.cookbook.dto.SignupDTO;
import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.service.AuthService;
import com.example.cookbook.utils.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @CrossOrigin(maxAge = 3600)
    @RequestMapping(value = "/signup.json", method = RequestMethod.POST)
    ResponseEntity<ResponseDTO> signup(@RequestBody SignupDTO signupDTO) {
		Map<String, Object> data = new HashMap<>();
        try {
            UserDTO newUserDTO = authService.signup(signupDTO);
			System.out.println("newUserDTO: " + newUserDTO.toString()); 
			data.put("user", newUserDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
        } catch(Exception exception) {
            throw new ResponseStatusException(
           HttpStatus.INTERNAL_SERVER_ERROR, "Sign up error", exception);
        }
    }

    @CrossOrigin(maxAge = 3600)
    @RequestMapping(value = "/signin.json", method = RequestMethod.POST)
    ResponseEntity<String> signin(@RequestBody SigninDTO signinDTO) {
        try {
            String link = authService.signin(signinDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(link);
        } catch(Exception exception) {
            throw new ResponseStatusException(
           HttpStatus.INTERNAL_SERVER_ERROR, "Sign in error", exception);
        }
    }
}


package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.example.cookbook.dto.SigninDTO;
import com.example.cookbook.dto.SignupDTO;
import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.service.AuthService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    ResponseEntity<UserDTO> signup(@RequestBody SignupDTO signupDTO) {
        try {
            UserDTO newUserDTO = authService.signup(signupDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(newUserDTO);
        } catch(Exception exception) {
            throw new ResponseStatusException(
           HttpStatus.INTERNAL_SERVER_ERROR, "Sign up error", exception);
        }
    }

    @RequestMapping(value = "/signin", method = RequestMethod.POST)
    ResponseEntity<UserDTO> signin(@RequestBody SigninDTO signinDTO) {
        try {
            UserDTO userDTO = authService.signin(signinDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(userDTO);
        } catch(Exception exception) {
            throw new ResponseStatusException(
           HttpStatus.INTERNAL_SERVER_ERROR, "Sign in error", exception);
        }
    }
}


package com.example.cookbook.dto;

import java.util.Map;

import com.example.cookbook.interfaces.DtoInterface;

public class SigninDTO implements DtoInterface<SignupDTO>{
    private String email;
    private String password;
    

    public SigninDTO(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public SigninDTO() {
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    @Override
    public Map<String, Object> toJson() {
        return Map.of("email", this.email, "password", this.password);
    }

    public static SigninDTO fromJson(Map<String, Object> json) {
        return new SigninDTO((String) json.get("email"), (String) json.get("password"));
    }

    @Override
    public String toString() {
        return "SigninDTO [password=" + password + ", email=" + email + "]";
    }

}

package com.example.cookbook.dto;

import java.util.Map;

import com.example.cookbook.interfaces.DtoInterface;

public class SignupDTO implements DtoInterface<SignupDTO>{
    private String email;
    private NameDTO name;
    private String password;
    private String role;
    

    public SignupDTO(String email, NameDTO name, String password, String role) {
        this.email = email;
        this.name = name;
        this.password = password;
        this.role = role;
    }

    public SignupDTO() {
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public NameDTO getName() {
        return name;
    }

    public void setName(NameDTO name) {
        this.name = name;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public Map<String, Object> toJson() {
        return Map.of("email", this.email, "name", this.name.toJson(), "password", this.password, "role",
                this.role);
    }

    @SuppressWarnings("unchecked")
    public static SignupDTO fromJson(Map<String, Object> json) {
        return new SignupDTO((String) json.get("email"),
                (NameDTO) NameDTO.fromJson((Map<String, Object>) json.get("name")), (String) json.get("password"),
                (String) json.get("role"));
    }

    @Override
    public String toString() {
        return "SignupDTO [password=" + password + ", email=" + email + ", name.firstNamme=" + name.getFirstName()
                + ", name.surname=" + name.getSurname() + ", role=" + role + "]";
    }

}

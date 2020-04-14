package com.example.cookbook.dto;

public class PersonDTO {
    private String name;

    public PersonDTO() {
    }

    public PersonDTO(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
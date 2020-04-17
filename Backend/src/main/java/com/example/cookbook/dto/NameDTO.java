package com.example.cookbook.dto;
import java.util.Map;
import com.example.cookbook.interfaces.DtoInterface;

public class NameDTO implements DtoInterface<NameDTO> {
    private String firstName;
    private String surname;

    public NameDTO(String firstName, String surname) {
        this.firstName = firstName;
        this.surname = surname;
    }

    public NameDTO() {
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    @Override
    public Map<String, Object> toJson() {
        return Map.of("firstName", this.firstName, "surname",this.surname);
    }

    public static NameDTO fromJson(Map<String, Object> json) {
        return new NameDTO((String) json.get("firstName"),(String) json.get("surname"));
    }

}
package com.example.cookbook.dto;

import java.util.Map;

import com.example.cookbook.interfaces.DtoInterface;

public class UserDTO implements DtoInterface<UserDTO> {
    private String email;
    private NameDTO name;
    private String deviceToken;
    private String photoURL;
    private String uid;
    

    public UserDTO(String email, NameDTO name, String deviceToken, String photoURL, String uid) {
        this.email = email;
        this.name = name;
        this.deviceToken = deviceToken;
        this.photoURL = photoURL;
        this.uid = uid;
    }

    public UserDTO() {
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

    public String getDeviceToken() {
        return deviceToken;
    }

    public void setDeviceToken(String deviceToken) {
        this.deviceToken = deviceToken;
    }

    public String getPhotoURL() {
        return photoURL;
    }

    public void setPhotoURL(String photoURL) {
        this.photoURL = photoURL;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    @Override
    public Map<String, Object> toJson() {
        return Map.of("email", this.email, "name", this.name.toJson(), "deviceToken", this.deviceToken, "photoURL",
                this.photoURL, "uid", this.uid);
    }

    @SuppressWarnings("unchecked")
    public static UserDTO fromJson(Map<String, Object> json) {
        return new UserDTO((String) json.get("email"),
                (NameDTO) NameDTO.fromJson((Map<String, Object>) json.get("name")), (String) json.get("deviceToken"),
                (String) json.get("photoURL"), (String) json.get("uid"));
    }

    @Override
    public String toString() {
        return "UserDTO [deviceToken=" + deviceToken + ", email=" + email + ", name.firstNamme=" + name.getFirstName()
                + ", name.surname=" + name.getSurname() + ", photoURL=" + photoURL + ", uid=" + uid + "]";
    }

}
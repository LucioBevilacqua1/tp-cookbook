package com.example.cookbook.dto;

import java.util.Date;
import java.util.Map;

import com.example.cookbook.interfaces.DtoInterface;

public class UserDTO implements DtoInterface<UserDTO> {
    private String email;
    private NameDTO name;
    private String deviceToken;
    private String photoURL;
    private String uid;
    private String role;
    private Date lastSeen;

    public UserDTO(String email, NameDTO name, String deviceToken, String photoURL, String uid, String role,
            Date lastSeen) {
        this.email = email;
        this.name = name;
        this.deviceToken = deviceToken;
        this.photoURL = photoURL;
        this.uid = uid;
        this.setRole(role);
        this.setLastSeen(lastSeen);
    }

    public Date getLastSeen() {
        return lastSeen;
    }

    public void setLastSeen(Date lastSeen) {
        this.lastSeen = lastSeen;
    }

    public UserDTO() {
    }

    public String getRole() {
        return role;
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

    public void setRole(String role) {
        this.role = role;
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
                this.photoURL, "uid", this.uid, "role", this.role, "lastSeen", this.lastSeen);
    }

    @SuppressWarnings("unchecked")
    public static UserDTO fromJson(Map<String, Object> json) {
        System.out.println(json.toString());
        return new UserDTO((String) json.get("email"),
                (NameDTO) NameDTO.fromJson((Map<String, Object>) json.get("name")), (String) json.get("deviceToken"),
                (String) json.get("photoURL"), (String) json.get("uid"), (String) json.get("role"),
                (Date) json.get("lastSeen"));
    }

    @Override
    public String toString() {
        return "UserDTO [deviceToken=" + deviceToken + ", email=" + email + ", name.firstNamme=" + name.getFirstName()
                + ", name.surname=" + name.getSurname() + ", photoURL=" + photoURL + ", uid=" + uid + ", role=" + role
                + ", lastSeen=" + lastSeen + "]";
    }

}
package com.example.cookbook.dto;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import com.example.cookbook.interfaces.DtoInterface;

public class MenuItemDTO implements DtoInterface<NameDTO> {
    private String id;
    private double price;
    private String description;
    private String photoUrl;
    private String name;

    public MenuItemDTO(String id, double price, String description, String photoUrl, String name) {
        this.setId(id);
        this.price = price;
        this.description = description;
        this.photoUrl = photoUrl;
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public static MenuItemDTO fromJson(Map<String, Object> json, String id) {
        return new MenuItemDTO(id, (double) json.get("price"), (String) json.get("description"),
                (String) json.get("photoUrl"), (String) json.get("name"));
    }

    @Override
    public Map<String, Object> toJson() {
        Map<String, Object> map = new HashMap<String, Object>();

        if (!Objects.isNull(this.price)) {
            map.put("price", this.price);
        }
        if (!Objects.isNull(this.description)) {
            map.put("description", this.description);
        }
        if (!Objects.isNull(this.photoUrl)) {
            map.put("photoUrl", this.photoUrl);
        }
        if (!Objects.isNull(this.name)) {
            map.put("name", this.name);
        }
        return map;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}

package com.example.cookbook.dto;

import java.util.Map;

import com.example.cookbook.interfaces.DtoInterface;

public class MenuItemDTO implements DtoInterface<NameDTO> {
    private double price;
    private String description;
    private String photoUrl;
    private String name;

    public MenuItemDTO(double price, String description, String photoUrl, String name) {
        this.price = price;
        this.description = description;
        this.photoUrl = photoUrl;
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public Map<String, Object> toJson() {
        return Map.of("price", this.price, "description", this.description, "photoUrl", this.photoUrl, "name",
                this.name);
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

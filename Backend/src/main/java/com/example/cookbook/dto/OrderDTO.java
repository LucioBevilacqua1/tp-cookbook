package com.example.cookbook.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.example.cookbook.interfaces.DtoInterface;
import com.google.gson.Gson;

public class OrderDTO implements DtoInterface<OrderDTO> {

    private String id;
    private String userOrderedId;
    private double totalPrice;
    private String status;
    private List<MenuItemDTO> items;
    private Date createdAt;
    Gson gson = new Gson();

    public OrderDTO(String id, String userOrdered, double totalPrice, String status, List<MenuItemDTO> items,
            Date createdAt) {
        this.setId(id);
        this.items = items;
        this.userOrderedId = userOrdered;        
        double sumTotal = 0;
        for (MenuItemDTO menuItemDTO : items) {
            sumTotal += menuItemDTO.getPrice();
        }
        this.totalPrice = sumTotal;
        this.status = status;
        this.setCreatedAt(createdAt);
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public String getUserOrderedId() {
        return userOrderedId;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setUserOrderedId(String userOrderedId) {
        this.userOrderedId = userOrderedId;
    }

    public static OrderDTO fromJson(Map<String, Object> json, String id) {
        List<Map<String, Object>> itemsJson = (List<Map<String, Object>>) json.get("items");
        List<MenuItemDTO> listItems = new ArrayList<MenuItemDTO>();
        for (Map<String, Object> itemJson : itemsJson) {
            listItems.add(MenuItemDTO.fromJson(itemJson, id));
        }
        return new OrderDTO(id, (String) json.get("userOrderedId"), (double) json.get("totalPrice"),
                (String) json.get("status"),
                listItems, (Date) json.get("createdAt"));
    }

    @Override
    public Map<String, Object> toJson() {
        Map<String, Object> map = new HashMap<String, Object>();

        if (!Objects.isNull(this.userOrderedId)) {
            map.put("userOrderedId", this.userOrderedId);
        }
        if (!Objects.isNull(this.totalPrice)) {
            map.put("totalPrice", this.totalPrice);
        }
        if (!Objects.isNull(this.status)) {
            map.put("status", this.status);
        }
        if (!Objects.isNull(this.createdAt)) {
            map.put("createdAt", this.createdAt);
        }
        if (!Objects.isNull(this.items)) {
            ArrayList<Object> listItems = new ArrayList<>();
            for (MenuItemDTO menuItemDTO : items) {
                listItems.add(menuItemDTO.toJson());
            }
            map.put("items", listItems);
        }
        return map;
    }

    public List<MenuItemDTO> getItems() {
        return items;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setItems(List<MenuItemDTO> items) {
        this.items = items;
    }
}

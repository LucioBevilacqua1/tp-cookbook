package com.example.cookbook.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.interfaces.DtoInterface;
import com.google.firebase.cloud.FirestoreClient;
import com.google.gson.Gson;

public class OrderDTO implements DtoInterface<OrderDTO> {

    private String id;
    private double totalPrice;
    private String status;
    private List<MenuItemDTO> items;
    private Date createdAt;
    Gson gson = new Gson();

    public OrderDTO(String id, double totalPrice, String status, List<MenuItemDTO> items, Date createdAt) {
        this.setId(id);
        this.items = items;
        System.out.println("items: " + items.toString());
        System.out.println("status: " + status.toString());
        System.out.println("totalPrice: " + totalPrice);
        System.out.println("id: " + id);
        double sumTotal = 0;
        for (MenuItemDTO menuItemDTO : items) {
            sumTotal += menuItemDTO.getPrice();
        }
        this.totalPrice = sumTotal;
        System.out.println("totalPrice after: " + this.totalPrice);
        this.status = status;
        this.setCreatedAt(createdAt);
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public static OrderDTO fromJson(Map<String, Object> json, String id) {
        System.out.println("ITEMS");
        System.out.println(json.get("items").toString());
        List<Map<String, Object>> itemsJson = (List<Map<String, Object>>) json.get("items");
        List<MenuItemDTO> listItems = new ArrayList<MenuItemDTO>();
        for (Map<String, Object> itemJson : itemsJson) {
            listItems.add(MenuItemDTO.fromJson(itemJson, id));
        }
        return new OrderDTO(id, (double) json.get("totalPrice"), (String) json.get("status"),
                listItems, (Date) json.get("createdAt"));
    }

    @Override
    public Map<String, Object> toJson() {
        Map<String, Object> map = new HashMap<String, Object>();

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

            System.out.println("List");
            System.out.println(gson.toJson(listItems).toString());
            map.put("items", listItems);
        }
        System.out.println("MAPA");
        System.out.println(gson.toJson(map).toString());
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

    public OrderDTO update(String id) throws InterruptedException, ExecutionException {
        FirestoreClient.getFirestore().collection("orderCollection").document(id).update(toJson()).get();
        return this;

    }
}

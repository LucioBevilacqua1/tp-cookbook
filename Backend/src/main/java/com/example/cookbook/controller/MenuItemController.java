package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashMap;
import java.util.Map;

import com.example.cookbook.dto.MenuItemDTO;
import com.example.cookbook.service.MenuItemService;
import com.example.cookbook.utils.ResponseDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
@RequestMapping("/menuItem")
public class MenuItemController {
    @Autowired
    private MenuItemService menuItemService;

    @RequestMapping(value = "/createMenuItem.json", method = RequestMethod.POST)
    ResponseEntity<ResponseDTO> createMenuItem(@RequestBody MenuItemDTO menuItemBodyDTO) {
        Map<String, Object> data = new HashMap<>();
        try {
            MenuItemDTO newItem = menuItemService.create(menuItemBodyDTO);
            System.out.println("newItem: " + newItem.toString());
            data.put("newItem", newItem);
            return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Sign up error", exception);
        }
    }
}

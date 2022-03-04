package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import com.example.cookbook.dto.MenuItemDTO;
import com.example.cookbook.service.MenuItemService;
import com.example.cookbook.utils.ResponseDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/menuItem")
public class MenuItemController {
    @Autowired
    private MenuItemService menuItemService;

    @CrossOrigin(maxAge = 3600)
    @GetMapping(value = "/getAllMenuItems.json")
    public ResponseEntity<ResponseDTO> getAllMenuItems() {
        Map<String, Object> data = new HashMap<>();
        try {
            Collection<MenuItemDTO> menuItemDTOCollection = menuItemService.getAll();
            System.out.println("menuItemDTOCollection: " + menuItemDTOCollection.toString());
            data.put("menuItems", menuItemDTOCollection);
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error getting Menu Items", exception);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
    }

    @CrossOrigin(maxAge = 3600)
    @RequestMapping(value = "/createMenuItem.json", method = RequestMethod.POST)
    ResponseEntity<ResponseDTO> createMenuItem(@RequestBody MenuItemDTO menuItemBodyDTO) {
        Map<String, Object> data = new HashMap<>();
        try {
            MenuItemDTO newItem = menuItemService.create(menuItemBodyDTO);
            System.out.println("newItem: " + newItem.toString());
            data.put("menuItem", newItem);
            return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error creating Menu Item", exception);
        }
    }

    @CrossOrigin(maxAge = 3600)
    @PutMapping(value = "/editMenuItem/{id}.json")
    public ResponseEntity<ResponseDTO> editMenuItem(@PathVariable("id") String id,
            @RequestBody MenuItemDTO menuItemBodyDTO) {
        Map<String, Object> data = new HashMap<>();
        try {
            MenuItemDTO menuItemDTOUpdated = menuItemService.update(id, menuItemBodyDTO);
            System.out.println("menuItemDTOUpdated: " + menuItemDTOUpdated.toString());
            data.put("menuItem", menuItemDTOUpdated);
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error getting Menu Items", exception);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
    }

    @CrossOrigin(maxAge = 3600)
    @DeleteMapping(value = "/deleteMenuItem/{id}.json")
    public ResponseEntity<ResponseDTO> someHttp(@PathVariable("id") String id) {
        Map<String, Object> data = new HashMap<>();
        try {
            menuItemService.delete(id);
            return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error deleting Menu Item", exception);
        }
    }
}

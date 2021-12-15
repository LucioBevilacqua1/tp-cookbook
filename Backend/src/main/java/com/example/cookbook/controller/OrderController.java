package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import com.example.cookbook.dto.OrderDTO;
import com.example.cookbook.service.OrderService;
import com.example.cookbook.utils.ResponseDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @GetMapping(value = "/getAllOrders.json")
    public ResponseEntity<ResponseDTO> getAllOrders() {
        Map<String, Object> data = new HashMap<>();
        try {
            Collection<OrderDTO> orderDTOCollection = orderService.getAll();
            System.out.println("orderCollection: " + orderDTOCollection.toString());
            data.put("orders", orderDTOCollection);
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error getting Orders", exception);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
    }

    @RequestMapping(value = "/createOrder.json", method = RequestMethod.POST)
    ResponseEntity<ResponseDTO> createOrder(@RequestBody OrderDTO orderBodyDTO) {
        Map<String, Object> data = new HashMap<>();
        try {
            OrderDTO newOrder = orderService.create(orderBodyDTO);
            System.out.println("newOrder: " + newOrder.toString());
            data.put("order", newOrder);
            return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error creating Order", exception);
        }
    }

    @PutMapping(value = "/editOrder/{id}.json")
    public ResponseEntity<ResponseDTO> editOrder(@PathVariable("id") String id,
            @RequestBody OrderDTO orderBodyDTO) {
        Map<String, Object> data = new HashMap<>();
        try {
            OrderDTO orderDTOUpdated = orderService.update(id, orderBodyDTO);
            System.out.println("orderDTOUpdated: " + orderDTOUpdated.toString());
            data.put("order", orderDTOUpdated);
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error getting Order", exception);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
    }

    @DeleteMapping(value = "/deleteOrder/{id}.json")
    public ResponseEntity<ResponseDTO> deleteOrder(@PathVariable("id") String id) {
        Map<String, Object> data = new HashMap<>();
        try {
            orderService.delete(id);
            return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
        } catch (Exception exception) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error deleting Order", exception);
        }
    }
}

package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.service.UsersService;
import com.example.cookbook.utils.ResponseDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class UsersController {
	@Autowired
	private UsersService usersService;

	@RequestMapping("/api-users")
	public String index() {
		return "This is the users controller index";
	}

	@GetMapping(value = "/api-users/getAllUsers.json")
	public ResponseEntity<ResponseDTO> getAllUsers() {
		Map<String, Object> data = new HashMap<>();
		try {
			Collection<UserDTO> userDTOCollection = usersService.getAll();
			System.out.println("userDTO: " + userDTOCollection.toString());
			data.put("users", userDTOCollection);
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
	}

	@PutMapping(value = "/api-users/getCurrentUserAndUpdateUserData/{uid}.json")
	public ResponseEntity<ResponseDTO> someHttp(@PathVariable("uid") String uid) {
		Map<String, Object> data = new HashMap<>();
		try {
			UserDTO userDTO = usersService.get(uid);
			System.out.println("userDTO: " + userDTO.toString());
			data.put("user", userDTO);
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
	}
}

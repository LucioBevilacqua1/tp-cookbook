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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@CrossOrigin(maxAge = 3600)
@RestController
public class UsersController {
	@Autowired
	private UsersService usersService;

	@CrossOrigin
	@RequestMapping("/api-users")
	public String index() {
		return "This is the users controller index";
	}

	@CrossOrigin(maxAge = 3600)
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
	
	@CrossOrigin(maxAge = 3600)
	@PutMapping(value = "/api-users/getCurrentUserAndUpdateUserData/{uid}.json")
	public ResponseEntity<ResponseDTO> someHttp(@PathVariable("uid") String uid) {
		Map<String, Object> data = new HashMap<>();
		try {
			UserDTO userDTO = usersService.get(uid);
			UserDTO updatedUser = usersService.update(uid, userDTO);
			System.out.println("updatedUser: " + updatedUser.toString());
			data.put("user", updatedUser);
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
	}
}

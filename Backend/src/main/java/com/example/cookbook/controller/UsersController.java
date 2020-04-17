package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.service.UsersService;
import com.example.cookbook.utils.ResponseDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
public class UsersController {

	@Autowired
	private UsersService usersService;

	@RequestMapping("/api-users")
	public String index() {
		return "This is the users controller index";
	}

	@RequestMapping(value = "/api-users/getCurrentUserAndUpdateUserData/{uid}", method = RequestMethod.PUT)
	public ResponseEntity<ResponseDTO> someHttp(@PathVariable("uid") String uid) {

		Map<String, Object> data = new HashMap<>();
		try {
			UserDTO userDTO = usersService.get(uid);
			data.put("user", userDTO.toJson());
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
		
		return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
	}

}

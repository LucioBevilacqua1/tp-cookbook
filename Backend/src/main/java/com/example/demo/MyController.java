package com.example.demo;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
public class MyController {

	@RequestMapping("/")
	public String index() {
		return "Prueba";
    }

    @RequestMapping(value="/postPerson", method= RequestMethod.POST)
	public ResponseEntity<PersonDTO> someHttp(@RequestBody PersonDTO person) {
		return ResponseEntity.status(HttpStatus.CREATED).body(person);
    }
    
}


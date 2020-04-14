package com.example.cookbook.controller;

import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.utils.ResponseDTO;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
public class UsersController {

	@RequestMapping("/api-users")
	public String index() {
		return "This is the users controller index";
	}

	@RequestMapping(value = "/api-users/getCurrentUserAndUpdateUserData/{uid}", method = RequestMethod.PUT)
	public ResponseEntity<ResponseDTO> someHttp(@PathVariable("uid") String uid) {
		Firestore db = FirestoreClient.getFirestore();

		DocumentReference docRef = db.collection("usersCollection").document(uid);
		// asynchronously retrieve the document
		ApiFuture<DocumentSnapshot> future = docRef.get();
		// ...
		// future.get() blocks on response
		DocumentSnapshot document;
		Map<String, Object> data = Map.of();
		try {
			document = future.get();
			if (document.exists()) {
				System.out.println("Document data: " + document.getData());
				data = document.getData();
			} else {
				System.out.println("No such document!");
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ResponseEntity.status(HttpStatus.CREATED).body(new ResponseDTO(true, data, "", ""));
	}

}

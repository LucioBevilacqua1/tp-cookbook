package com.example.cookbook;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = { "com.example.cookbook" })
public class Application {
	public static void main(String[] args) throws IOException {
		SpringApplication.run(Application.class, args);
		try {
			FileInputStream serviceAccount = new FileInputStream(
					"../Backend/cookbook-dev1-firebase-adminsdk-l7kds-e5ead19e91.json");

			FirebaseOptions options = new FirebaseOptions.Builder()
					.setCredentials(GoogleCredentials.fromStream(serviceAccount))
					.setDatabaseUrl("https://cookbook-dev1.firebaseio.com")
					.build();

			FirebaseApp.initializeApp(options);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
}

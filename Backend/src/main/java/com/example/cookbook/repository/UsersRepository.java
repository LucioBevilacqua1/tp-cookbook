package com.example.cookbook.repository;

import java.util.Collection;
import java.util.concurrent.ExecutionException;
import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.interfaces.RepositoryInterface;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

@Repository
public class UsersRepository implements RepositoryInterface<UserDTO> {


    @Override
    public UserDTO get(String uid) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
		DocumentReference docRef = db.collection("usersCollection").document(uid);
		ApiFuture<DocumentSnapshot> future = docRef.get();
        DocumentSnapshot document = future.get();
        return UserDTO.fromJson(document.getData());
    }

    @Override
    public void create(UserDTO product) {
        // TODO Auto-generated method stub

    }

    @Override
    public void update(String uid, UserDTO product) {
        // TODO Auto-generated method stub

    }

    @Override
    public void delete(String uid) {
        // TODO Auto-generated method stub

    }

    @Override
    public Collection<UserDTO> getAll() {
        // TODO Auto-generated method stub
        return null;
    }

   
}
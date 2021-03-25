package com.example.cookbook.repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.concurrent.ExecutionException;
import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.interfaces.RepositoryInterface;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
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
    public Collection<UserDTO> getAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Collection<UserDTO> allUserList = new ArrayList<>();
        ApiFuture<QuerySnapshot> future = db.collection("usersCollection").get();
        QuerySnapshot documentsQuerySnapshot = future.get();
        for (QueryDocumentSnapshot queryDocumentSnapshot : documentsQuerySnapshot.getDocuments()) {
            allUserList.add(UserDTO.fromJson(queryDocumentSnapshot.getData()));
        }
        return allUserList;
    }

    @Override
    public UserDTO create(UserDTO userDTO) throws InterruptedException, ExecutionException {
        FirestoreClient.getFirestore().collection("usersCollection").document(userDTO.getUid()).set(userDTO.toJson());
        return userDTO;
    }

    @Override
    public UserDTO update(String uid, UserDTO userDTO) throws InterruptedException, ExecutionException {
        userDTO.setLastSeen(new Date());
        ApiFuture<WriteResult> future = FirestoreClient.getFirestore().collection("usersCollection")
                .document(userDTO.getUid()).set(userDTO.toJson());
        future.get();
        return userDTO;
    }

    @Override
    public void delete(String uid) {

    }
}
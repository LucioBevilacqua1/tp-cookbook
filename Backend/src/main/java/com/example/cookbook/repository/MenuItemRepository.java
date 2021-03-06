package com.example.cookbook.repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.MenuItemDTO;
import com.example.cookbook.interfaces.RepositoryInterface;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;

import org.springframework.stereotype.Repository;

@Repository
public class MenuItemRepository implements RepositoryInterface<MenuItemDTO> {

    @Override
    public MenuItemDTO create(MenuItemDTO menuItemDTO) throws InterruptedException, ExecutionException {
        DocumentReference menuItemCreated = FirestoreClient.getFirestore().collection("menuItemCollection")
                .add(menuItemDTO.toJson()).get();
        menuItemDTO.setId(menuItemCreated.getId());
        return menuItemDTO;
    }

    @Override
    public MenuItemDTO update(String id, MenuItemDTO menuItemDTO)  throws InterruptedException, ExecutionException{
        FirestoreClient.getFirestore().collection("menuItemCollection").document(id).update(menuItemDTO.toJson()).get();
        return menuItemDTO;

    }

    @Override
    public void delete(String id) throws InterruptedException, ExecutionException {
        FirestoreClient.getFirestore().collection("menuItemCollection").document(id).delete().get();
    }

    @Override
    public MenuItemDTO get(String uid) throws InterruptedException, ExecutionException {
        return null;
    }

    @Override
    public Collection<MenuItemDTO> getAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Collection<MenuItemDTO> allMenuItemsList = new ArrayList<>();
        ApiFuture<QuerySnapshot> future = db.collection("menuItemCollection").get();
        QuerySnapshot documentsQuerySnapshot = future.get();
        for (QueryDocumentSnapshot queryDocumentSnapshot : documentsQuerySnapshot.getDocuments()) {
            allMenuItemsList.add(MenuItemDTO.fromJson(queryDocumentSnapshot.getData(), queryDocumentSnapshot.getId()));
        }
        return allMenuItemsList;
    }

}

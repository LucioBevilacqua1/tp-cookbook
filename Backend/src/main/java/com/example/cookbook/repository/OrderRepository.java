package com.example.cookbook.repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.OrderDTO;
import com.example.cookbook.interfaces.RepositoryInterface;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;

import org.springframework.stereotype.Repository;

@Repository
public class OrderRepository implements RepositoryInterface<OrderDTO> {
    @Override
    public OrderDTO create(OrderDTO orderDTO) throws InterruptedException, ExecutionException {
        orderDTO.setCreatedAt(new Date());
        DocumentReference orderCreated = FirestoreClient.getFirestore().collection("orderCollection")
                .add(orderDTO.toJson()).get();
        orderDTO.setId(orderCreated.getId());
        return orderDTO;
    }

    @Override
    public void delete(String id) throws InterruptedException, ExecutionException {
        FirestoreClient.getFirestore().collection("orderCollection").document(id).delete().get();
    }

    @Override
    public OrderDTO get(String uid) throws InterruptedException, ExecutionException {
        return null;
    }

    @Override
    public Collection<OrderDTO> getAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Collection<OrderDTO> allOrdersList = new ArrayList<>();
        ApiFuture<QuerySnapshot> future = db.collection("orderCollection").get();
        QuerySnapshot documentsQuerySnapshot = future.get();
        for (QueryDocumentSnapshot queryDocumentSnapshot : documentsQuerySnapshot.getDocuments()) {
            allOrdersList.add(OrderDTO.fromJson(queryDocumentSnapshot.getData(), queryDocumentSnapshot.getId()));
        }
        return allOrdersList;
    }

    @Override
    public OrderDTO update(String id, OrderDTO orderDTO) throws InterruptedException, ExecutionException {
        FirestoreClient.getFirestore().collection("orderCollection").document(id).update(orderDTO.toJson()).get();
        return orderDTO;

    }

}

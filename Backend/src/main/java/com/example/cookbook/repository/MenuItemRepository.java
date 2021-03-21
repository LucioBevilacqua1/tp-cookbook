package com.example.cookbook.repository;

import java.util.Collection;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.MenuItemDTO;
import com.example.cookbook.interfaces.RepositoryInterface;
import com.google.firebase.cloud.FirestoreClient;

public class MenuItemRepository implements RepositoryInterface<MenuItemDTO> {

    @Override
    public MenuItemDTO create(MenuItemDTO menuItemDTO) throws InterruptedException, ExecutionException {
        FirestoreClient.getFirestore().collection("menuItemCollection").document().set(menuItemDTO.toJson());
        return menuItemDTO;
    }

    @Override
    public void update(String uid, MenuItemDTO t) {

    }

    @Override
    public void delete(String uid) {

    }

    @Override
    public MenuItemDTO get(String uid) throws InterruptedException, ExecutionException {
        return null;
    }

    @Override
    public Collection<MenuItemDTO> getAll() throws InterruptedException, ExecutionException {
        return null;
    }

}

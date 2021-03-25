package com.example.cookbook.service;

import java.util.Collection;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.MenuItemDTO;
import com.example.cookbook.interfaces.RepositoryInterface;
import com.example.cookbook.repository.MenuItemRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MenuItemService implements RepositoryInterface<MenuItemDTO> {

    @Autowired
    private MenuItemRepository menuItemRepository;

    @Override
    public MenuItemDTO create(MenuItemDTO menuItemDTO) throws InterruptedException, ExecutionException {
        return menuItemRepository.create(menuItemDTO);
    }

    @Override
    public MenuItemDTO update(String id, MenuItemDTO menuItemDTO) throws InterruptedException, ExecutionException {
        return menuItemRepository.update(id, menuItemDTO);

    }

    @Override
    public void delete(String id) throws InterruptedException, ExecutionException {
        menuItemRepository.delete(id);
    }

    @Override
    public MenuItemDTO get(String uid) throws InterruptedException, ExecutionException {
        return null;
    }

    @Override
    public Collection<MenuItemDTO> getAll() throws InterruptedException, ExecutionException {
        return menuItemRepository.getAll();
    }

}

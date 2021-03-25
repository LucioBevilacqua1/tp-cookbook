package com.example.cookbook.service;

import java.util.Collection;
import java.util.concurrent.ExecutionException;
import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.interfaces.ServiceInterface;
import com.example.cookbook.repository.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsersService implements ServiceInterface<UserDTO> {

    @Autowired
    private UsersRepository usersRepository;

    @Override
    public void create(UserDTO product) {

    }

    @Override
    public UserDTO update(String uid, UserDTO userDTO) throws InterruptedException, ExecutionException {
        UserDTO updatedUser = usersRepository.update(uid, userDTO);
        return updatedUser;
    }

    @Override
    public void delete(String uid) {

    }

    @Override
    public UserDTO get(String uid) throws InterruptedException, ExecutionException {
        UserDTO userDTO = usersRepository.get(uid);
        return userDTO;
    }

    @Override
    public Collection<UserDTO> getAll() throws InterruptedException, ExecutionException {
        return usersRepository.getAll();
    }
}
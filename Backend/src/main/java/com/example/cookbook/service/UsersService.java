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
    public UserDTO get(String uid) throws InterruptedException,ExecutionException {
        UserDTO userDTO = usersRepository.get(uid);
        System.out.println("userDTO: " + userDTO.toString()); 
        return userDTO;
    }

    @Override
    public Collection<UserDTO> getAll() {
        // TODO Auto-generated method stub
        return null;
    }
}
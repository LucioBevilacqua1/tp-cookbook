package com.example.cookbook.interfaces;

import java.util.Collection;
import java.util.concurrent.ExecutionException;
import com.example.cookbook.dto.UserDTO;

public interface RepositoryInterface<T> {
    public abstract UserDTO create(T t) throws InterruptedException, ExecutionException;

    public abstract void update(String uid, T t);

    public abstract void delete(String uid);

    public abstract T get(String uid) throws InterruptedException, ExecutionException;

    public abstract Collection<T> getAll() throws InterruptedException, ExecutionException;
}
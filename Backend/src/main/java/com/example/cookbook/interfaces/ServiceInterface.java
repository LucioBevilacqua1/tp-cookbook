package com.example.cookbook.interfaces;

import java.util.Collection;
import java.util.concurrent.ExecutionException;

public interface ServiceInterface<T> {
    public abstract void create(T t);
    public abstract T update(String uid, T t) throws InterruptedException, ExecutionException;
    public abstract void delete(String uid);
    public abstract T get(String uid) throws InterruptedException,ExecutionException;
    public abstract Collection<T> getAll() throws InterruptedException,ExecutionException;
}
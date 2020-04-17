package com.example.cookbook.interfaces;

import java.util.Map;

public interface DtoInterface<T> {

    public abstract Map<String, Object> toJson();

}
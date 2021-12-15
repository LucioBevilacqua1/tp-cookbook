package com.example.cookbook.service;

import java.util.Collection;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.OrderDTO;
import com.example.cookbook.interfaces.RepositoryInterface;
import com.example.cookbook.repository.OrderRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService implements RepositoryInterface<OrderDTO> {

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public OrderDTO create(OrderDTO orderDTO) throws InterruptedException, ExecutionException {
        return orderRepository.create(orderDTO);
    }

    @Override
    public OrderDTO update(String id, OrderDTO orderDTO) throws InterruptedException, ExecutionException {
        return orderRepository.update(id, orderDTO);

    }

    @Override
    public void delete(String id) throws InterruptedException, ExecutionException {
        orderRepository.delete(id);
    }

    @Override
    public OrderDTO get(String id) throws InterruptedException, ExecutionException {
        return null;
    }

    @Override
    public Collection<OrderDTO> getAll() throws InterruptedException, ExecutionException {
        return orderRepository.getAll();
    }

}

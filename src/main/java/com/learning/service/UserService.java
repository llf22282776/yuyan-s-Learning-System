package com.learning.service;

import org.springframework.stereotype.Service;

import com.learning.pojo.User;
@Service
public interface UserService {
    public boolean isUser(String userName , String password);
    public User getUser(String userName , String password);
    public boolean insertUser(User user);
}

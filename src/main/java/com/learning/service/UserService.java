package com.learning.service;

import com.learning.pojo.User;

public interface UserService {
    public boolean isUser(String userName , String password);
    public User getUser(String userName , String password);
}

package com.learning.service.imp;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.learning.dao.UserDao;
import com.learning.pojo.User;
import com.learning.service.UserService;
@Service
public class UserServiceImp implements UserService {

    
    @Resource
    private UserDao userDao;
    
    public boolean isUser(String userName, String password) {
        // TODO Auto-generated method stub
        return userDao.getLoginUser(userName, password) == null?false:true;
    }

    public User getUser(String userName, String password) {
        // TODO Auto-generated method stub
        return userDao.getLoginUser(userName, password);
    }

}

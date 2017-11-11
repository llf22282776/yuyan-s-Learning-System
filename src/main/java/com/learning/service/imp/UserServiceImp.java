package com.learning.service.imp;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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

    @Override
    @Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class,timeout=1,isolation=Isolation.DEFAULT) 
    public boolean insertUser(User user) {
        // TODO Auto-generated method stub
        int num=userDao.insertUser(user.getUid(), user.getPassword(), user.getPosition(),user.getUname());
        
       
        return num<0?false:true;
    }

}

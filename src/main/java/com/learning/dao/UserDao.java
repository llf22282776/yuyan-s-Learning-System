package com.learning.dao;

import com.learning.pojo.User;

public interface UserDao {
    //1.从表中查询某个账号的条目数（添加账号的时候查一下）
    public int getNumsOfOneUserName(String uid);
    
    //2.从表中返回一个User对象（登陆验证账号）
    public User getLoginUser(String uid,String password);
    
    //3.添加一个用户
    public int insertUser(String uid,String password,int position,String uname);
    
    
}

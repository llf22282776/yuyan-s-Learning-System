package com.learning.pojo;

import java.io.Serializable;

import org.springframework.stereotype.Service;
@Service
public class User implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String uid;
    private String password;
    private String uname;
    private int position;
   
    public String getUid() {
        return uid;
    }
    public void setUid(String uid) {
        this.uid = uid;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public int getPosition() {
        return position;
    }
    public void setPosition(int position) {
        this.position = position;
    }
    public String getUname() {
        return uname;
    }
    public void setUname(String uname) {
        this.uname = uname;
    }
    
    
}

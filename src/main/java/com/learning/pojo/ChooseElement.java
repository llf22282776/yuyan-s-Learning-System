package com.learning.pojo;

import java.io.Serializable;

import org.springframework.stereotype.Service;
@Service
public class ChooseElement implements Serializable{
   /**
     * 
     */
    private static final long serialVersionUID = 1L;

   private String   text;

   private int cid;
public String getText() {
    return text;
}
public void setText(String text) {
    this.text = text;
}
 
public int getCid() {
    return cid;
} 
public void setCid(int cid) {
    this.cid = cid;
}
   
}

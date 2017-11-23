package com.learning.pojo;

import java.io.Serializable;

public class Subject_line implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int sid;
    public int getSid() {
        return sid;
    }
    public void setSid(int sid) {
        this.sid = sid;
    }
    public int getLid() {
        return lid;
    }
    public void setLid(int lid) {
        this.lid = lid;
    }
    public int getIndex() {
        return index;
    }
    public void setIndex(int index) {
        this.index = index;
    }
    private int lid;
    private int index;
}

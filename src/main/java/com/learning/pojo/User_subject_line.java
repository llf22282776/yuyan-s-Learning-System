package com.learning.pojo;

import java.io.Serializable;

public class User_subject_line implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String uid;
    private int pid;
    private int sid;
    private int lid;
    private int lotherId;

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

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

    public int getLotherId() {
        return lotherId;
    }

    public void setLotherId(int lotherId) {
        this.lotherId = lotherId;
    }

}

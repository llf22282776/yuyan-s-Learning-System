package com.learning.pojo;

import java.io.Serializable;

public class User_subject_choose implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String uid;
    private int pid;
    private int sid;
    private int chooseId;

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

    public int getChooseId() {
        return chooseId;
    }

    public void setChooseId(int chooseId) {
        this.chooseId = chooseId;
    }

}

package com.learning.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

public class Paper implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String pname;
    private Timestamp pdate;
    private int totalScore;
    private int pid;
    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public Timestamp getPdate() {
        return pdate;
    }

    public void setPdate(Timestamp pdate) {
        this.pdate = pdate;
    }

    public int getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

}

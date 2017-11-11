package com.learning.pojo;

import java.io.Serializable;

import org.springframework.stereotype.Service;

@Service
public class Subject implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String stitle;
    private int stype;
    private int totalScore;
    private int sid;


    public int getStype() {
        return stype;
    }

    public void setStype(int stype) {
        this.stype = stype;
    }

    public int getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }

    public String getStitle() {
        return stitle;
    }

    public void setStitle(String stitle) {
        this.stitle = stitle;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

}

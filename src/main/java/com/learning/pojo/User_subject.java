package com.learning.pojo;

import java.io.Serializable;

public class User_subject implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String uid;
    private int pid;
    private int sid;
    private int score;
    private boolean isWrong;
    private long totalSecond;

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

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public boolean isWrong() {
        return isWrong;
    }

    public void setWrong(boolean isWrong) {
        this.isWrong = isWrong;
    }

    public long getTotalSecond() {
        return totalSecond;
    }

    public void setTotalSecond(long totalSecond) {
        this.totalSecond = totalSecond;
    }

}

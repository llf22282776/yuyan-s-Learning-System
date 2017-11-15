package com.learning.pojo;

import java.io.Serializable;

public class PaperUserDone implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String title;
    private int pid;
    private int scoreGetted;
    private String startTime;
    private String endTime;
    private String totalTime;
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getScoreGetted() {
        return scoreGetted;
    }

    public void setScoreGetted(int scoreGetted) {
        this.scoreGetted = scoreGetted;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public String getTotalTime() {
        return totalTime;
    }

    public void setTotalTime(String totalTime) {
        this.totalTime = totalTime;
    }

}

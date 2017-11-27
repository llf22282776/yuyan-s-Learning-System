package com.learning.pojo;

import java.io.Serializable;
import java.util.List;

public class UserMix implements Serializable{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private List<SubjectMix> subjects;
    private int scoreRank; //排名
    private int timeRank; //排名
    private String totalSecond ;//总时间
    private String endTime ;//结束时间
    private String uid;
    private int totalScore;//用户这张卷子的得分
    private String uname;
    public List<SubjectMix> getSubjects() {
        return subjects;
    }
    public void setSubjects(List<SubjectMix> subjects) {
        this.subjects = subjects;
    }
    public int getScoreRank() {
        return scoreRank;
    }
    public void setScoreRank(int scoreRank) {
        this.scoreRank = scoreRank;
    }
    public int getTimeRank() {
        return timeRank;
    }
    public void setTimeRank(int timeRank) {
        this.timeRank = timeRank;
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
    public String getTotalSecond() {
        return totalSecond;
    }
    public void setTotalSecond(String totalSecond) {
        this.totalSecond = totalSecond;
    }
    public String getUid() {
        return uid;
    }
    public void setUid(String uid) {
        this.uid = uid;
    }
    public String getUname() {
        return uname;
    }
    public void setUname(String uname) {
        this.uname = uname;
    }
    public int getTotalScore() {
        return totalScore;
    }
    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }
}

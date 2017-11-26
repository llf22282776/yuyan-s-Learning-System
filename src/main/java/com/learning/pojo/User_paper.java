package com.learning.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

public class User_paper implements Serializable{
  /**
     * 
     */
    private static final long serialVersionUID = 1L;
private String uid;
  private int  pid;
  private int totalScore;
  private Timestamp startTime;
  private Timestamp endTime;
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
public int getTotalScore() {
    return totalScore;
}
public void setTotalScore(int totalScore) {
    this.totalScore = totalScore;
}
public Timestamp getStartTime() {
    return startTime;
}
public void setStartTime(Timestamp startTime) {
    this.startTime = startTime;
}
public Timestamp getEndTime() {
    return endTime;
}
public void setEndTime(Timestamp endTime) {
    this.endTime = endTime;
}
  

    
}

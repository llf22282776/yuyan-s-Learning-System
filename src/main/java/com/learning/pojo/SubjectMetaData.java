package com.learning.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
/**
 * 
 * 用于查询的时候渲染表格
 * 
 * */
public class SubjectMetaData implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private List<Long> times =new ArrayList<Long>();
    private List<Integer> scores =new ArrayList<Integer>();
    public Long getMaxTime() {
        return maxTime;
    }
    public void setMaxTime(Long maxTime) {
        this.maxTime = maxTime;
    }
    public int getMaxScore() {
        return maxScore;
    }
    public void setMaxScore(int maxScore) {
        this.maxScore = maxScore;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    private Long maxTime=(long)0;
    private int maxScore=0;
    public List<Long> getTimes() {
        return times;
    }
    public void setTimes(List<Long> times) {
        this.times = times;
    }
    public List<Integer> getScores() {
        return scores;
    }
    public void setScores(List<Integer> scores) {
        this.scores = scores;
    }
    public void countAllTimes(User_subject[] user_subjects){
        for(User_subject user_subject:user_subjects){
            this.scores.add(user_subject.getScore());
            if(maxScore<user_subject.getScore())maxScore=user_subject.getScore();
            this.times.add(user_subject.getTotalSecond());
            if(maxTime<user_subject.getTotalSecond())maxTime=user_subject.getTotalSecond();
            
        }
    }
    public int getTimeRank(long l){
        int rank=0;
        for(int i=0;i<this.times.size();i++ ){
            
            if(this.times.get(i) == l){
                rank=i+1;
                break;
            }
        }
        return rank;
    }
    public int getScoreRank(int score){
        int rank=0;
        for(int i=0;i<this.scores.size();i++ ){
            
            if(this.scores.get(i) == score){
                rank=i+1;
                break;
            }
        }
        return rank;
    }
}

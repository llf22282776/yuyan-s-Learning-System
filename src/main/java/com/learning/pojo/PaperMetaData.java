package com.learning.pojo;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.learning.util.ConstantUtil;
/**
 * 
 * 这个类是查询的时候返回给前端的
 * 需要这些数据
 * 
 * */
public class PaperMetaData implements Serializable{
    
    /**
     * 
     */
    private static final long serialVersionUID = -134030962733497519L;
    
    private List<Integer> scores=new ArrayList<Integer>();
    private List<Long> times=new ArrayList<>();
    private List<SubjectMetaData> subjectMetaDatas=new ArrayList<>();
    
    
    public List<Integer> getScores() {
        return scores;
    }
    public void setScores(List<Integer> scores) {
        this.scores = scores;
    }
    public List<Long> getTimes() {
        return times;
    }
    public void setTimes(List<Long> times) {
        this.times = times;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    /**
     * 
     * 填充源信息
     * 
     * 
     * */
    public void insertPapers(List<User_paper> user_papers){
        //吧up里面的东西填进来,保证是顺序的
        for(User_paper user_paper :user_papers){
            this.scores.add(user_paper.getTotalScore());
            this.times.add(ConstantUtil.getTimeBetween(user_paper.getStartTime(), user_paper.getEndTime()));
        }
    }
    public void insertPapers(User_paper[] user_papers){
        //吧up里面的东西填进来,保证是顺序的
        for(User_paper user_paper :user_papers){
            this.scores.add(user_paper.getTotalScore());
            this.times.add(ConstantUtil.getTimeBetween(user_paper.getStartTime(), user_paper.getEndTime()));
        }
    }
    /**
     * 
     * 获取某个分数的排名
     * 
     * 
     * */
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
    /**
     * 
     * 获取某个分数的排名
     * 
     * 
     * */
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
    public List<SubjectMetaData> getSubjectMetaDatas() {
        return subjectMetaDatas;
    }
    public void setSubjectMetaDatas(List<SubjectMetaData> subjectMetaDatas) {
        this.subjectMetaDatas = subjectMetaDatas;
    }
}

package com.learning.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PaperMix implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private boolean result=false;
    private int pid;
    private String title;
    private int totalScore;
    private List<SubjectMix> subjects=new ArrayList<SubjectMix>();
    
    public boolean isResult() {
        return result;
    }

    public void setResult(boolean result) {
        this.result = result;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }

    public List<SubjectMix> getSubjects() {
        return subjects;
    }

    public void setSubjects(List<SubjectMix> subjects) {
        this.subjects = subjects;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }
    
    
}

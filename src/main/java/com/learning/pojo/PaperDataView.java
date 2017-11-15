package com.learning.pojo;

import java.io.Serializable;

public class PaperDataView implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    // 提供一个总的数据浏览
    private int maxScore;
    private int minScore;
    private String avageTime;
    private String topStudent;
    private String lowStudent;

    public int getMaxScore() {
        return maxScore;
    }

    public void setMaxScore(int maxScore) {
        this.maxScore = maxScore;
    }

    public int getMinScore() {
        return minScore;
    }

    public void setMinScore(int minScore) {
        this.minScore = minScore;
    }

    public String getAvageTime() {
        return avageTime;
    }

    public void setAvageTime(String avageTime) {
        this.avageTime = avageTime;
    }

    public String getTopStudent() {
        return topStudent;
    }

    public void setTopStudent(String topStudent) {
        this.topStudent = topStudent;
    }

    public String getLowStudent() {
        return lowStudent;
    }

    public void setLowStudent(String lowStudent) {
        this.lowStudent = lowStudent;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

}

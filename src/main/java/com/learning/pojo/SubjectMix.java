package com.learning.pojo;

import java.io.Serializable;
import java.util.List;

public class SubjectMix implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String title;
    private int sid;
    private int type;//题目类型
    private int totalScore;
    private List<String> audios;
    private List<String> pics;
    private List<String> words;
    private List<String> texts;//填空题和选择题都是这个
    private List<Integer> scores;
    
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
    public List<String> getAudios() {
        return audios;
    }
    public void setAudios(List<String> audios) {
        this.audios = audios;
    }
    public List<String> getPics() {
        return pics;
    }
    public void setPics(List<String> pics) {
        this.pics = pics;
    }
    public List<String> getWords() {
        return words;
    }
    public void setWords(List<String> words) {
        this.words = words;
    }
    public List<String> getTexts() {
        return texts;
    }
    public void setTexts(List<String> texts) {
        this.texts = texts;
    }
    public List<Integer> getScores() {
        return scores;
    }
    public void setScores(List<Integer> scores) {
        this.scores = scores;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    public int getSid() {
        return sid;
    }
    public void setSid(int sid) {
        this.sid = sid;
    }
    public int getType() {
        return type;
    }
    public void setType(int type) {
        this.type = type;
    }
    
}

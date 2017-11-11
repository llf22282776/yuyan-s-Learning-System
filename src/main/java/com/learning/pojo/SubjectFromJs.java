package com.learning.pojo;

import java.io.Serializable;
import java.util.Vector;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
@Service
public class SubjectFromJs implements Serializable{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    
    private String title;
    private int totalScore;
    private int pid;
    private Vector<MultipartFile> picFiles=new Vector<>();
    private Vector<MultipartFile> audioFiles=new Vector<>();
    private Vector<String> words=new Vector<>();
    private Vector<String> texts=new Vector<>();
    private Vector<String> picUrl=new Vector<>();
    private Vector<String> videoUrl=new Vector<>();
    private Vector<Integer> scores=new Vector<>();
    private int rightIndex;
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
    public Vector<MultipartFile> getPicFiles() {
        return picFiles;
    }
    public void setPicFiles(Vector<MultipartFile> picFiles) {
        this.picFiles = picFiles;
    }
    public Vector<MultipartFile> getAudioFiles() {
        return audioFiles;
    }
    public void setAudioFiles(Vector<MultipartFile> audioFiles) {
        this.audioFiles = audioFiles;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    public Vector<String> getWords() {
        return words;
    }
    public void setWords(Vector<String> words) {
        this.words = words;
    }
    public Vector<Integer> getScores() {
        return scores;
    }
    public void setScores(Vector<Integer> scores) {
        this.scores = scores;
    }
    public Vector<String> getTexts() {
        return texts;
    }
    public void setTexts(Vector<String> texts) {
        this.texts = texts;
    }
    public Vector<String> getPicUrl() {
        return picUrl;
    }
    public void setPicUrl(Vector<String> picUrl) {
        this.picUrl = picUrl;
    }
    public Vector<String> getVideoUrl() {
        return videoUrl;
    }
    public void setVideoUrl(Vector<String> videoUrl) {
        this.videoUrl = videoUrl;
    }
    public int getPid() {
        return pid;
    }
    public void setPid(int pid) {
        this.pid = pid;
    }
    public int getRightIndex() {
        return rightIndex;
    }
    public void setRightIndex(int rightIndex) {
        this.rightIndex = rightIndex;
    };
    
    
    
    

}

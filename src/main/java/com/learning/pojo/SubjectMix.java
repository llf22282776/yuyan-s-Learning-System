package com.learning.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class SubjectMix implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String title;
    private int sid;
    private int type;//题目类型
    private int totalScore;
    private String startTime ="";
    private String endTime="" ;
    private List<String> audios=new ArrayList<>();
    private List<String> pics=new ArrayList<>();
    private List<String> words=new ArrayList<>();
    private List<String> texts=new ArrayList<>();//填空题和选择题都是这个
   
    private int answerIndex;
    
    @JSONField(name = "choosenIndex")
    private int choosenIndex;
    
    
    private List<Integer> scores=new ArrayList<>();
    
    private List<Integer> eid=new ArrayList<>();//lid 或者 cid或者 fid
    @JSONField(name="selectList")
    private List<Integer> seq =new ArrayList<>();//如果是选择题，只有一个值，eid的索引,如果是连线题，单词匹配的eid列表顺序，本来是 0 1 2 3，
    @JSONField(name="textList")
    private List<String>  seqStrings=new ArrayList<>();//如果是填空题，eid顺次的空
    @JSONField(name="inedxList")
    private List<Integer> indexSeq=new ArrayList<>();
    
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
    public List<Integer> getEid() {
        return eid;
    }
    public void setEid(List<Integer> eid) {
        this.eid = eid;
    }
    public List<Integer> getSeq() {
        return seq;
    }
    public void setSeq(List<Integer> seq) {
        this.seq = seq;
    }
    public List<String> getSeqStrings() {
        return seqStrings;
    }
    public void setSeqStrings(List<String> seqStrings) {
        this.seqStrings = seqStrings;
    }
    public int getAnswerIndex() {
        return answerIndex;
    }
    public void setAnswerIndex(int answerIndex) {
        this.answerIndex = answerIndex;
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
    public List<Integer> getIndexSeq() {
        return indexSeq;
    }
    public void setIndexSeq(List<Integer> indexSeq) {
        this.indexSeq = indexSeq;
    }
  
    public int getChoosenIndex() {
        return choosenIndex;
    }
    public void setChoosenIndex(int choosenIndex) {
        this.choosenIndex = choosenIndex;
    }
}

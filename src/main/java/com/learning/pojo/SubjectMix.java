package com.learning.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.learning.util.ConstantUtil;

public class SubjectMix implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String title;
    private int sid;
    private int type;//题目类型
    private int totalScore;//查询阶段有用
    private int score;//查询阶段有用
    private String startTime ="";
    private String endTime="" ;//这两个字段在查询阶段是没有用的
    private String totalSecond;//这个字段是有效的
    private List<String> audios=new ArrayList<>();
    private List<String> pics=new ArrayList<>();
    private List<String> words=new ArrayList<>();
    private List<String> texts=new ArrayList<>();//填空题和选择题都是这个
    private int scoreRank; //排名
    private int timeRank; //排名
    private int answerIndex;
    
    @JSONField(name = "choosenIndex")
    private int choosenIndex;
    
    
    private List<Integer> scores=new ArrayList<>();
    
    private List<Integer> eid=new ArrayList<>();//lid 或者 cid或者 fid
    @JSONField(name="selectList")
    private List<Integer> seq =new ArrayList<>();//如果是选择题，只有一个值，eid的索引,如果是连线题，单词匹配的eid列表顺序，本来是 0 1 2 3，
    @JSONField(name="textList")
    private List<String>  seqStrings=new ArrayList<>();//如果是填空题，eid顺次的空
    @JSONField(name="indexList")
    private List<Integer> indexList=new ArrayList<>();
    
    public List<Integer> getIndexList() {
        return indexList;
    }
    public void setIndexList(List<Integer> indexList) {
        this.indexList = indexList;
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
    
  
    public int getChoosenIndex() {
        return choosenIndex;
    }
    public void setChoosenIndex(int choosenIndex) {
        this.choosenIndex = choosenIndex;
    }
    public String getTotalSecond() {
        return totalSecond;
    }
    public void setTotalSecond(String totalSecond) {
        this.totalSecond = totalSecond;
    }
    public void setSubjectMixByU_sAndEle(User_subject user_subject,int type,User_subject_choose[] user_subject_chooses,User_subject_line[] user_subject_lines){
        if(type == ConstantUtil.SUBJECT_CHOOSE){
            this.setSubjectMixByU_sAndEle_Choose(user_subject, type, user_subject_chooses);
            
        }else if(type == ConstantUtil.SUBJECT_LINE){
            
            this.setSubjectMixByU_sAndEle_Line(user_subject, type, user_subject_lines);
        }
        
    }
    public void setSubjectMixByU_sAndEle_Line(User_subject user_subject,int type,User_subject_line[] user_subject_lines){
        
        
    }
     public void setSubjectMixByU_sAndEle_Choose(User_subject user_subject,int type,User_subject_choose[] user_subject_chooses){
     
     
 }
     public void setElementsByType(ElementMix[] elementMixs,int type){
        
         if(type == ConstantUtil.SUBJECT_LINE){
             //连线题的相关，那就设置
             List<Integer> selectSwapList=new ArrayList<>();
             for(ElementMix elementMix:elementMixs){
                 selectSwapList.add(elementMix.getLotherId());
             }
            for(ElementMix elementMix:elementMixs){
                audios.add(elementMix.getVideo());
                pics.add(elementMix.getPic());
                scores.add(elementMix.getScore());
                indexList.add(elementMix.getIndex());
                seq.add(selectSwapList.indexOf(elementMix.getLotherId()));
                eid.add(elementMix.getLid());
            }

         }else if(type == ConstantUtil .SUBJECT_CHOOSE){
             for(ElementMix elementMix:elementMixs){
                 choosenIndex=elementMix.getChooseId();
                 answerIndex=elementMix.getAnswerId();
                 texts.add(elementMix.getText());
                 eid.add(elementMix.getCid());
             }
             
         }
         
         
     }
    public int getScore() {
        return score;
    }
    public void setScore(int score) {
        this.score = score;
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
}

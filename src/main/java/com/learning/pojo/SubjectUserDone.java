package com.learning.pojo;

import java.io.Serializable;
import java.util.List;

public class SubjectUserDone implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int sid;
    private int scoreGetted;
    private String title;
    private String totalTime;
    private int selectIndex;// 如果是选择题就有用了
    private List<Integer> selectIndexs;// 连线题
    private List<String> fillTextList;

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getScoreGetted() {
        return scoreGetted;
    }

    public void setScoreGetted(int scoreGetted) {
        this.scoreGetted = scoreGetted;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTotalTime() {
        return totalTime;
    }

    public void setTotalTime(String totalTime) {
        this.totalTime = totalTime;
    }

    public int getSelectIndex() {
        return selectIndex;
    }

    public void setSelectIndex(int selectIndex) {
        this.selectIndex = selectIndex;
    }

    public List<Integer> getSelectIndexs() {
        return selectIndexs;
    }

    public void setSelectIndexs(List<Integer> selectIndexs) {
        this.selectIndexs = selectIndexs;
    }

    public List<String> getFillTextList() {
        return fillTextList;
    }

    public void setFillTextList(List<String> fillTextList) {
        this.fillTextList = fillTextList;
    }

}

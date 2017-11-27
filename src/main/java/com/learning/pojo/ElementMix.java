package com.learning.pojo;

import java.io.Serializable;

public class ElementMix implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
        private int lid;
        private String pic;
        private String video;
        private String word;
        private int score;
        private int cid;
        private String text;
        private int lotherId;
        private int chooseId;
        private int index;
        private int answerId;
    public int getLotherId() {
            return lotherId;
        }
        public void setLotherId(int lotherId) {
            this.lotherId = lotherId;
        }
        public int getChooseId() {
            return chooseId;
        }
        public void setChooseId(int chooseId) {
            this.chooseId = chooseId;
        }
        public static long getSerialversionuid() {
            return serialVersionUID;
        }
    public int getLid() {
        return lid;
    }
    public void setLid(int lid) {
        this.lid = lid;
    }
    public String getPic() {
        return pic;
    }
    public void setPic(String pic) {
        this.pic = pic;
    }
    public String getVideo() {
        return video;
    }
    public void setVideo(String video) {
        this.video = video;
    }
    public String getWord() {
        return word;
    }
    public void setWord(String word) {
        this.word = word;
    }
    public int getScore() {
        return score;
    }
    public void setScore(int score) {
        this.score = score;
    }
    public int getCid() {
        return cid;
    }
    public void setCid(int cid) {
        this.cid = cid;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
    public int getIndex() {
        return index;
    }
    public void setIndex(int index) {
        this.index = index;
    }
    public int getAnswerId() {
        return answerId;
    }
    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

}

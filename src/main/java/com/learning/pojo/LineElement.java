package com.learning.pojo;

import java.io.Serializable;

import org.springframework.stereotype.Service;
@Service
public class LineElement implements Serializable{
 
   /**
     * 
     */
    private static final long serialVersionUID = 1L;
private String pic;
   private String video;
   private String word;
   private int score;
   private int lid;
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
public int getLid() {
    return lid;
}
public void setLid(int lid) {
    this.lid = lid;
}
    
    
}

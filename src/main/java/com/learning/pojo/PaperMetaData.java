package com.learning.pojo;

import java.io.Serializable;
import java.sql.Timestamp;
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
    private String pname;
    private String pdate;
    private int totalScore;
    private int pid;
}

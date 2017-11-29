package com.learning.util;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;




import sun.security.action.PutAllAction;

import com.sun.javafx.image.IntPixelAccessor;

public class ConstantUtil {
    public static final String URL_PREFIX="/";
    public static final String MAIN_URL="/main";
    public static int STUDENT=0;
    public static int TEACHER=1;
    public static int SUBJECT_LINE=0;
    public static int SUBJECT_CHOOSE=1;
    public static int SUBJECT_FILL=2;
    public static final String UPLOAD="WEB-INF/upload/";
    public static final String UPLOAD_WEB="upload/";
    public static final String IMG_PATH="img/";
    public static final String AUDIO_PATH="audio/";
    public static final String WEBM_POSTFIX=".webm";
    public static final String TIME_STR = "%d分 %d秒";
    public static String formatTime(long ms) {

        int ss = 1000;
        int mi = ss * 60;
        int hh = mi * 60;
        int dd = hh * 24;

        long day = 0;
        long hour = 0;
        long minute = (ms - day * dd - hour * hh) / mi;
        long second = (ms - day * dd - hour * hh - minute * mi) / ss;
        String timeString = new String(ConstantUtil.TIME_STR);
        return String.format(timeString,minute,second);
    }
    public static long getTimeBetween(String startTime,String endTime) {
        Timestamp st1=Timestamp.valueOf(startTime);
        Timestamp st2=Timestamp.valueOf(endTime);
        
      
        return Math.abs(st1.getTime() - st2.getTime());
    }
    public static long getTimeBetween(Timestamp startTime,Timestamp endTime) {
     
        
      
        return Math.abs(startTime.getTime() - endTime.getTime());
    }
    public static int[] randomSeq(int start,int end){
        //生成一个0-end的随机序列
        Random random=new Random(System.currentTimeMillis());
        List<Integer> list1=new ArrayList<>();
     
        
        
        
        
        
        List<int[]> seq= new ArrayList<int[]>();
        int[] a1={0,1,2,3};
        int[] a2={1,0,2,3};
        int[] a3={3,0,1,2};
        int[] a4={0,3,2,1};
        int[] a5={2,1,3,0};
        int[] a6={2,2,0,3};
        seq.add(a1);
        seq.add(a2);
        seq.add(a3);
        seq.add(a4);
        seq.add(a5);
        seq.add(a6);
       int num=random.nextInt(6);
       
        return seq.get(num);
    }
}

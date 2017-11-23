package com.learning.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

public class ConstantUtil {
    public static final String URL_PREFIX="/";
    public static final String MAIN_URL="/main";
    public static int STUDENT=0;
    public static int TEACHER=1;
    public static int SUBJECT_LINE=0;
    public static int SUBJECT_CHOOSE=1;
    public static int SUBJECT_FILL=2;
    public static final String UPLOAD="WEB-INF/upload/";
    public static final String IMG_PATH="img/";
    public static final String AUDIO_PATH="audio/";
    public static Object[] randomSeq(int start,int end){
        //生成一个0-end的随机序列
        Random random=new Random();
        Set<Integer> set=new HashSet<Integer>();
        List<Integer> seq= new ArrayList<Integer>();
        
        do {
            int num=random.nextInt(end)%(end-start+1)+start;
            if(set.contains(num) == false){
                set.add(num);
                seq.add(num);
            }
        } while (seq.size() == 4);
        return seq.toArray();
    }
}

package com.learning.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.learning.pojo.Paper;
import com.learning.pojo.PaperMix;
import com.learning.pojo.PaperMsg;
@Service
public interface PaperService {
    public int insertPaper(PaperMsg paperMsg);
    
    /**
     * 获取学生没有做的卷子数量
     * 
     * */
    public int getStudentNotTodoPaperNums(String uid);
    
    /**
     * 获得学生没有做的卷子的列表
     * */
    public List<Paper> getStudentNotTodoPaperList(String uid);
    /**
     * 
     * 检查学生是否做过某个卷子,做过返回真，没有做过返回false
     * 
     * */
    public boolean testPaperDone(String uid,int pid);
    
    /**
     * 
     * 获得一张卷子的完整信息
     * 
     * */
    public PaperMix getPaperMixDetail(int pid);
    
    
    
}

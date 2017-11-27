package com.learning.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.learning.pojo.Paper;
import com.learning.pojo.PaperMix;
import com.learning.pojo.PaperMsg;
import com.learning.pojo.PaperQueryState;
import com.learning.pojo.User;
import com.learning.pojo.User_paper;
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
    /**
     * 
     * 获得一张做过卷子的完整信息
     * 
     * */
    public PaperMix getDonePaperMix(int check_pid);
    
    
    /**
     * 
     * 保存一张答卷
     * @throws Exception 
     * 
     * */
    public boolean saveTestPaperResult(PaperMix paperMix,String uid) throws Exception;
    
    /**
     * 
     * 计算一个paper出来
     * 
     * */
    public User_paper countPaper(PaperMix paperMix,String uid);
    
    /**
     * 
     * 获得一个带有用户信息的试卷,可以指定特定的用户也可以不指定，主要用于
     * 
     * 
     * */
    public PaperMix getPaperWithUsers(int pid,String uid,List<String> uids );
    
    /**
     * 
     * 获取一个用户的试卷情况,题目都在里面
     * 
     * */
    public User_paper getUserPaper(int pid,String uid); 
    
    /**
     * 
     * 获取做过的试卷列表
     * 学生返回自己的
     * 老师返回做过的"只要做过就行"
     * */
     public List<Paper> getQueryPapers(PaperQueryState paperQueryState,User user);
    
    /**
     * 
     * 获得一个查询用的paperMix
     * 
     * */
    public PaperMix getUserDonePaper(int pid,User user);
    
}

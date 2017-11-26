package com.learning.dao;

import java.util.Map;

import com.learning.pojo.Paper;
import com.learning.pojo.User_paper;


public interface PaperDao {
    public int insertPaper(Paper paper);
    public Paper[] getPapersUserNotDoItYet(String uid);
    public int getPapersNumUserNotDoItYet(String uid);
    public int testPaperDone(String uid,int pid);
    public Paper getSpecPaper(int pid);
    
    
    
    //插入一条 u_s
    public int insertUser_paper(User_paper user_paper);
    
    //获取up
    public User_paper[] getUser_papers(int pid,String uid );
    
    //
    public Paper[] getQueryPapersWithParms(Map<String, Object> map);
    
    
}

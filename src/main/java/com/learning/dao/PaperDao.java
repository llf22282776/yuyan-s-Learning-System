package com.learning.dao;

import java.util.Map;

import com.learning.pojo.Paper;
import com.learning.pojo.User;
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
    
    //获取多条up
    public User_paper[] getUser_papersByPid(int pid);
    
    /**
     * 获得学生没有做过的卷子列表
     * */
    public Paper[] getPapersNoStudentDone();
    
    /**
     * 删除一个学生没有做过的卷子
     * 
     * */
    public int deleteOnePaperStudentNotDone(int pid);
    
    public User[] getUsersMsgByPid(int pid);
}

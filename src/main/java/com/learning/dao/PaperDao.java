package com.learning.dao;

import com.learning.pojo.Paper;

public interface PaperDao {
    public int insertPaper(Paper paper);
    public Paper[] getPapersUserNotDoItYet(String uid);
    public int getPapersNumUserNotDoItYet(String uid);
    public int testPaperDone(String uid,int pid);
    public Paper getSpecPaper(int pid);
}

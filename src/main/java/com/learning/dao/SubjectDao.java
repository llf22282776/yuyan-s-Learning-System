package com.learning.dao;

import com.learning.pojo.Subject;

public interface SubjectDao {
    //1.插入一条subject
    public int insertSubject(Subject subject);
    
    //1 插入一条s-p
    public int insertS_P(int sid,int pid);
    
    //获得一个试卷的所有subject
    public Subject[] getSubjectsByPid(int pid);
}

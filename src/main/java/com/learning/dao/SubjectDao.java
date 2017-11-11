package com.learning.dao;

import com.learning.pojo.Subject;

public interface SubjectDao {
    //1.插入一条subject
    public int insertSubject(Subject subject);
    
    //1 插入一条s-p
    public int insertS_P(int sid,int pid);
}

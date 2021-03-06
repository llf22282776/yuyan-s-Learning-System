package com.learning.dao;

import java.util.List;

import com.learning.pojo.Subject;
import com.learning.pojo.SubjectMix;
import com.learning.pojo.User_subject;
import com.learning.pojo.User_subject_choose;
import com.learning.pojo.User_subject_line;

public interface SubjectDao {
    //1.插入一条subject
    public int insertSubject(Subject subject);
    
    //1 插入一条s-p
    public int insertS_P(int sid,int pid);
    
    //获得一个试卷的所有subject
    public Subject[] getSubjectsByPid(int pid);
    
    //插入一条 u_s
    public int insertUser_subject(User_subject user_subject);
    
    
    //插入一条 u_s_l
    public int insertUser_subject_line(User_subject_line user_subject_line);
    
    //插入一条 u_s_c
    public int insertUser_subject_choose(User_subject_choose user_subject_choose);
    
    //获取 一个用户的u s
    public User_subject[] getUser_subjects(String uid,int pid);
    
    //获取一条 u_s
    public User_subject_line[]  getUser_subject_choose(String uid,int pid,int sid);
    
    
    //获取一条 u_s_l
    public User_subject_choose[]  getUser_subject_line(String uid,int pid,int sid);
    
    //获取多个用户的u s
    public User_subject[] getUser_subjectsBysid_pid(int sid,int pid);
    
    //通过连接查询获取一个subject的某些字段
    public SubjectMix getSubject(String uid,int pid,int sid);
  }

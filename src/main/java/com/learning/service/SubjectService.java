package com.learning.service;

import java.util.List;
import java.util.Vector;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.learning.pojo.PaperMix;
import com.learning.pojo.SubjectFromJs;
import com.learning.pojo.SubjectMix;
import com.learning.pojo.UserPaper;
import com.learning.pojo.UserSubject;
import com.learning.pojo.User_paper;
import com.learning.pojo.User_subject;
import com.learning.pojo.User_subject_choose;
import com.learning.pojo.User_subject_line;
@Service
public interface SubjectService {
    //保存题目里面的文件
    public boolean saveSubjectsFiles(String realPath,SubjectFromJs lineTypeSubject);
 
    
    //保存题目，原子性操作
    public boolean insertSubject(SubjectFromJs subjectFromJs,int type);
    public boolean insertSubjectAlreadyExist(int pid,int sid);
    public boolean saveOneSubject(SubjectMix subject);
    /**
     * 保存连线题并计分数
     * 
     * */
    public boolean saveLineSubject(SubjectMix subject);
    
    
    /**
     * 
     * 保存选择题并计分数
     * 
     * */
    public boolean saveChooseSubject(SubjectMix subject);
    
    /**
     * 计算分数生成对象
     * 
     * */
     
    public List<User_subject_line> countLineSubjet(SubjectMix subject,String uid,int pid);
    
    public List<User_subject_choose> countChooseSubjet(SubjectMix subject,String uid,int pid);
    
    public User_subject countSubject(SubjectMix subject,String uid,int pid); 
   
    public void insertUser_subject_lines(List<User_subject_line> user_subject_lines);
    public void insertUser_subject_chooses(List<User_subject_choose> user_subject_chooses);
    /**
     * 
     * 获取一个用户的连线题情况
     * 
     * */
   public UserSubject getUserSubject_Line(int pid,String uid,int sid);
   /**
    * 
    * 获取一个用户的选择情况
    * 
    * */
    public UserSubject getUserSubject_Choose(int pid,String uid);
    /**
     * 
     * 获取一个用户的题目情况
     * 
     * */
    public UserSubject getUserSubject(int pid,String uid,int sid); 
    
    
    /**
     * 
     * 获取一个用户某个试卷的所有题目情况
     * 
     * */
    public List<UserSubject> getSubjects(int pid,String uid,int sid); 
    
} 

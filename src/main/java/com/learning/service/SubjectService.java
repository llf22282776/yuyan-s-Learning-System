package com.learning.service;

import java.util.Vector;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.learning.pojo.SubjectFromJs;
@Service
public interface SubjectService {
    //保存题目里面的文件
    public boolean saveSubjectsFiles(String realPath,SubjectFromJs lineTypeSubject);
 
    
    //保存题目，原子性操作
    public boolean insertSubject(SubjectFromJs subjectFromJs,int type);
    public boolean insertSubjectAlreadyExist(int pid,int sid);
 
}

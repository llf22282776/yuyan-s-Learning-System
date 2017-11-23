package com.learning.service.imp;

import java.io.File;
import java.util.UUID;
import java.util.Vector;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.learning.dao.ElementDao;
import com.learning.dao.SubjectDao;
import com.learning.pojo.ChooseElement;
import com.learning.pojo.LineElement;
import com.learning.pojo.Subject;
import com.learning.pojo.SubjectFromJs;
import com.learning.service.SubjectService;
import com.learning.util.ConstantUtil;
@Service
public class SubjectServiceImp implements SubjectService{

    private static  Logger LOGGER = LoggerFactory.getLogger(SubjectServiceImp.class);
    @Resource
    private SubjectDao subjectDao;
    @Resource
    private ElementDao elementDao;
    /**
     * 保存连线题传进来的文件
     * 
     * 
     * */
    @Override
    public boolean saveSubjectsFiles(String realPath,SubjectFromJs lineTypeSubject) {
        // TODO Auto-generated method stub
        Vector<String> picfilePaths=new Vector<>();
        Vector<String> audiofilePaths=new Vector<>();
        try {
            for(int i=0;i<lineTypeSubject.getAudioFiles().size();i++){
                MultipartFile picFile=lineTypeSubject.getPicFiles().elementAt(i);
                MultipartFile audioFile=lineTypeSubject.getAudioFiles().elementAt(i);
                String picFname=UUID.randomUUID().toString();
                String audioFname=UUID.randomUUID().toString();
                String picfilePath = realPath+ConstantUtil.UPLOAD+ConstantUtil.IMG_PATH+picFname;
                String audiofilePath = realPath+ConstantUtil.UPLOAD+ConstantUtil.AUDIO_PATH+audioFname;
                
                
                
                System.out.println("pic's file:"+picfilePath+picFile.getOriginalFilename());
                System.out.println("audiofilePath file:"+audiofilePath+audioFile.getOriginalFilename());
                //保存到本地
             
                picFile.transferTo(new File(picfilePath));
                audioFile.transferTo(new File(audiofilePath));
                lineTypeSubject.getPicUrl().add(picFname);//前缀是一样的
                lineTypeSubject.getVideoUrl().add(audioFname);
            }
        } catch (Exception e1) {
           LOGGER.error(e1.getMessage());
           e1.printStackTrace();
           for(String s:picfilePaths){
               //删除文件
               File eFile=new File(s);
               if(eFile.exists())eFile.delete();
               
           }
           for(String s:audiofilePaths){
               //删除文件
               File eFile=new File(s);
               if(eFile.exists())eFile.delete();
               
           }
           return false;
        }
        return true;
    }

    /**
     * 
     * 用于吧题目插入到数据库中的表里面
     * 
     * */
    @Override
    @Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class,timeout=1,isolation=Isolation.DEFAULT) 
    public boolean insertSubject(SubjectFromJs subjectFromJs,int type) {
        // TODO Auto-generated method stub
        //先在subject里面插一条记录
        Subject subject=new Subject();
        subject.setStitle(subjectFromJs.getTitle());
        subject.setStype(type);
        subject.setTotalScore(subjectFromJs.getTotalScore());
        //
        subjectDao.insertSubject(subject);
        int sid=subject.getSid();
        System.out.println("sid:"+sid+" pid:"+subjectFromJs.getPid());
        int num=subjectDao.insertS_P(sid, subjectFromJs.getPid());
        if(num<0)return false;
        //判断类型
        if(type == ConstantUtil.SUBJECT_LINE){
            //生成随机的顺序
            
            Object[] randomNums=ConstantUtil.randomSeq(0, 3);//[0,3]
            for(int i=0;i<subjectFromJs.getAudioFiles().size();i++){
                LineElement line = new LineElement();
                line.setPic(subjectFromJs.getPicUrl().elementAt(i));
                line.setVideo(subjectFromJs.getVideoUrl().elementAt(i));
                line.setScore(subjectFromJs.getScores().elementAt(i));
                line.setWord(subjectFromJs.getWords().elementAt(i));
                elementDao.insertIntoLine(line);
                int lid=line.getLid();
                //插入关联表
                elementDao.insertIntoS_Line(sid, lid,(int)randomNums[i]);
                
            }
        }else if(type == ConstantUtil.SUBJECT_CHOOSE){
            for(int i=0;i<subjectFromJs.getTexts().size();i++){
                ChooseElement cElement = new ChooseElement();
                cElement.setText(subjectFromJs.getTexts().elementAt(i));
                elementDao.insertIntoChoose(cElement);
                int cid=cElement.getCid();
                //插入关联表
                elementDao.insertIntoS_choose(sid, cid,subjectFromJs.getRightIndex());
                
            }
            
            
        }else {
            //其他题型，暂时不做
            return false;
            
            
        }
        //然后在s-line里面插记录
        return true;
    }

 

    @Override
    @Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class,timeout=1,isolation=Isolation.DEFAULT) 
    public boolean insertSubjectAlreadyExist(int pid, int sid) {
        // TODO Auto-generated method stub
        //因为已经存在，所以仅仅关联一下就行
        int num=subjectDao.insertS_P(sid, pid);
        return num>0?true:false;
    }

}

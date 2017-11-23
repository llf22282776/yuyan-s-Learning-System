package com.learning.service.imp;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.learning.dao.ElementDao;
import com.learning.dao.PaperDao;
import com.learning.dao.SubjectDao;
import com.learning.pojo.ChooseElement;
import com.learning.pojo.LineElement;
import com.learning.pojo.Paper;
import com.learning.pojo.PaperMix;
import com.learning.pojo.PaperMsg;
import com.learning.pojo.Subject;
import com.learning.pojo.SubjectMix;
import com.learning.pojo.Subject_line;
import com.learning.service.PaperService;
import com.learning.util.ConstantUtil;

@Service
public class PaperServiceImp implements PaperService {

    @Resource
    private PaperDao paperDao;

    @Resource
    private ElementDao elementDao;
    @Resource
    private SubjectDao subjectDao;
    private static Logger LOGGER = LoggerFactory
            .getLogger(PaperServiceImp.class);

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, timeout = 1, isolation = Isolation.DEFAULT)
    public int insertPaper(PaperMsg paperMsg) {
        // TODO Auto-generated method stub
        Paper paper = new Paper();
        paper.setPname(paperMsg.getTitle());
        paper.setTotalScore(paperMsg.getTotalScore());
        paper.setPdate(Timestamp.valueOf(paperMsg.getDate()));
        paperDao.insertPaper(paper);
        int pid = paper.getPid();
        System.out.println("pid:" + pid);
        return pid;
    }

    @Override
    public int getStudentNotTodoPaperNums(String uid) {
        // TODO Auto-generated method stub
        try {
            return paperDao.getPapersNumUserNotDoItYet(uid);
        } catch (Exception e) {
            // TODO: handle exception
            LOGGER.error(e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Paper> getStudentNotTodoPaperList(String uid) {
        // TODO Auto-generated method stub

        try {
            List<Paper> paperList = new ArrayList<Paper>();
            Paper[] papers = paperDao.getPapersUserNotDoItYet(uid);

            for (Paper p : papers) {
                paperList.add(p);

            }
            return paperList;

        } catch (Exception e) {
            // TODO: handle exception
            LOGGER.error(e.getMessage());
            e.printStackTrace();
            return new ArrayList<Paper>();
        }

    }

    @Override
    public boolean testPaperDone(String uid, int pid) {
        // TODO Auto-generated method stub
        try {
            int num=paperDao.testPaperDone(uid, pid);
            System.out.println("paperNum:"+num);
            return num>0;
        } catch (Exception e) {
            // TODO: handle exception
            LOGGER.error(e.getMessage());
            e.printStackTrace();
            return false;
        }
    
    }

    @Override
    public PaperMix getPaperMixDetail(int pid) {
        // TODO Auto-generated method stub
       //首先，获得卷子信息
       
       try {
        PaperMix paperMix=new PaperMix();
        Paper paper=paperDao.getSpecPaper(pid);
        paperMix.setPid(paper.getPid());
        paperMix.setTitle(paper.getPname());
        paperMix.setTotalScore(paper.getTotalScore());
        Subject[] subjects=subjectDao.getSubjectsByPid(pid);
       //题目都是有顺序的
        for(Subject s:subjects){
            //遍历，抽取元素
            SubjectMix subjectMix=new SubjectMix();
            if(s.getStype() == ConstantUtil.SUBJECT_CHOOSE){
                //选择题
                ChooseElement[] chooseElements= elementDao.getChoosesBySid(s.getSid());
                int answerId=elementDao.getRightChoosenIndex(s.getSid());
                //一个题的全部元素
                subjectMix.setAnswerIndex(answerId);//把答案放进去
                for(ChooseElement c:chooseElements){
                    subjectMix.getTexts().add(c.getText());
                    subjectMix.getEid().add(c.getCid());//吧元素的id放进去
                    
                }
                
            }else if(s.getStype() == ConstantUtil.SUBJECT_LINE){
                LineElement[] lineElements=elementDao.getLinesBySid(s.getSid());
                Subject_line[] sub_lines=elementDao.getLinesSeq(s.getSid());
                for(LineElement l:lineElements){
                    subjectMix.getWords().add(l.getWord());
                    subjectMix.getAudios().add(l.getVideo());
                    subjectMix.getPics().add(l.getPic());
                    subjectMix.getEid().add(l.getLid());
                    
                }
                for(Subject_line sub_line:sub_lines){
                    //吧顺序也放进来
                    subjectMix.getIndexSeq().add(sub_line.getIndex());
                }
                
            }
        
            subjectMix.setSid(s.getSid());
            subjectMix.setTitle(s.getStitle());
            subjectMix.setType(s.getStype());
            paperMix.getSubjects().add(subjectMix);//添加进来
            
        }
           return paperMix;
           
           
    } catch (Exception e) {
        // TODO: handle exception
        LOGGER.error(e.getMessage());
        e.printStackTrace();
        return new PaperMix();
        
    }
        
        
    }

}

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

import com.learning.dao.PaperDao;
import com.learning.dao.SubjectDao;
import com.learning.pojo.Paper;
import com.learning.pojo.PaperMix;
import com.learning.pojo.PaperMsg;
import com.learning.pojo.Subject;
import com.learning.service.PaperService;

@Service
public class PaperServiceImp implements PaperService {

    @Resource
    private PaperDao paperDao;

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
            return paperDao.testPaperDone(uid, pid)>0;
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
        PaperMix paperMix=new PaperMix();
        
       try {
        Paper paper=paperDao.getSpecPaper(pid);
        Subject[] subjects=subjectDao.getSubjectsByPid(pid);
        for(Subject s:){
            
            
            
        }
           
           
           
    } catch (Exception e) {
        // TODO: handle exception
        
        
        
    }
        
        
    }

}

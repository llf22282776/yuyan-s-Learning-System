package com.learning.service.imp;

import java.sql.Timestamp;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.learning.dao.PaperDao;
import com.learning.pojo.Paper;
import com.learning.pojo.PaperMsg;
import com.learning.service.PaperService;
@Service
public class PaperServiceImp implements PaperService{

    @Resource
    private PaperDao paperDao;
    
    private static Logger LOGGER  = LoggerFactory.getLogger(PaperServiceImp.class);
    
    @Override
    @Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class,timeout=1,isolation=Isolation.DEFAULT) 
    public int insertPaper(PaperMsg paperMsg) {
        // TODO Auto-generated method stub
        Paper paper=new Paper();
        paper.setPname(paperMsg.getTitle());
        paper.setTotalScore(paperMsg.getTotalScore());
        paper.setPdate(Timestamp.valueOf(paperMsg.getDate()));
        paperDao.insertPaper(paper);
        int pid=paper.getPid();
        System.out.println("pid:"+pid);
        return pid;
    }

}

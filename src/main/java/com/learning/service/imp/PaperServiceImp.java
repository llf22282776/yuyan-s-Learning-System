package com.learning.service.imp;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.jsoup.helper.StringUtil;
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
import com.learning.pojo.PaperMetaData;
import com.learning.pojo.PaperMix;
import com.learning.pojo.PaperMsg;
import com.learning.pojo.PaperQueryState;
import com.learning.pojo.Subject;
import com.learning.pojo.SubjectMix;
import com.learning.pojo.Subject_line;
import com.learning.pojo.User;
import com.learning.pojo.User_paper;
import com.learning.pojo.User_subject;
import com.learning.pojo.User_subject_choose;
import com.learning.pojo.User_subject_line;
import com.learning.service.PaperService;
import com.learning.service.SubjectService;
import com.learning.util.ConstantUtil;

@Service
public class PaperServiceImp implements PaperService {

    @Resource
    private PaperDao paperDao;

    @Resource
    private ElementDao elementDao;
    @Resource
    private SubjectDao subjectDao;
    @Resource
    private SubjectService subjetServiceImp;
    
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
                    subjectMix.getAudios().add(ConstantUtil.UPLOAD_WEB+ConstantUtil.AUDIO_PATH+l.getVideo());
                    subjectMix.getPics().add(ConstantUtil.UPLOAD_WEB+ConstantUtil.IMG_PATH+l.getPic());
                    subjectMix.getEid().add(l.getLid());
                    
                }
                for(Subject_line sub_line:sub_lines){
                    //吧顺序也放进来
                    subjectMix.getIndexList().add(sub_line.getIndex_());
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

    @Override
    public PaperMix getDonePaperMix(int check_pid) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, timeout = 1, isolation = Isolation.DEFAULT)
    public boolean saveTestPaperResult(PaperMix paperMix,String uid) throws Exception {
        // TODO Auto-generated method stub
        //1.插u_p
        //2.插U-s
        //3.插u-s-l或u-s-c
        int totalScore=0;
        String startTime = null;
        String endTime =null;
        for(int i=0;i<paperMix.getSubjects().size();i++){
            //遍历每一个题，计算分数
            SubjectMix subjectMix=paperMix.getSubjects().get(i);
            if(subjectMix.getType()== ConstantUtil.SUBJECT_LINE){
                //计算然后插入表里面
                List<User_subject_line> user_subject_lines=subjetServiceImp.countLineSubjet(subjectMix, uid,paperMix.getPid());
                subjetServiceImp.insertUser_subject_lines(user_subject_lines);
              
            }else if(subjectMix.getType()== ConstantUtil.SUBJECT_CHOOSE){
                List<User_subject_choose> user_subject_chooses= subjetServiceImp.countChooseSubjet(subjectMix, uid,paperMix.getPid());
                subjetServiceImp.insertUser_subject_chooses(user_subject_chooses);
                
            }
            
           User_subject user_subject= subjetServiceImp.countSubject(subjectMix, uid,paperMix.getPid());
           totalScore+=user_subject.getScore();
             
           if(i == 0){
               startTime = subjectMix.getStartTime();
               
               
           }
           if(i == paperMix.getSubjects().size()-1){
               endTime = subjectMix.getEndTime();
               
           }
           int num= subjectDao.insertUser_subject(user_subject);
           if(num<0){
               throw new Exception("User_subject insert failed");
             
           }
            
        }
        System.out.println("startTime:"+startTime+" "+ "endTime:"+endTime);
        
        paperMix.setTotalScore(totalScore);//总分已经变成用户的分数了
        User_paper user_paper=this.countPaper(paperMix, uid);
        user_paper.setStartTime(Timestamp.valueOf(startTime));
        user_paper.setEndTime(Timestamp.valueOf(endTime));
        int num= paperDao.insertUser_paper(user_paper);
        if(num<0){
            throw new Exception("user_paper insert failed");
         
        }
        return true;
    }

    @Override
    public PaperMix getPaperWithUsers(int pid, String uid, List<String> uids) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public User_paper getUserPaper(int pid, String uid) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public User_paper countPaper(PaperMix paperMix, String uid) {
        // TODO Auto-generated method stub
        //计算这个
        User_paper user_paper=new User_paper();
        user_paper.setPid(paperMix.getPid());
        user_paper.setUid(uid);
        return user_paper;
    }

    @Override
    public List<Paper> getQueryPapers(PaperQueryState paperQueryState, User user) {
        // TODO Auto-generated method stub
        List<Paper> papers=new ArrayList<>();
        Map<String, Object> sMap=new HashMap<String, Object>();
        if(StringUtil.isBlank(paperQueryState.title) == false){
            sMap.put("title",paperQueryState.title );
            
        }
        if(StringUtil.isBlank(paperQueryState.date) == false){
            sMap.put("date",paperQueryState.date );
            
        }
        if(user.getPosition() == ConstantUtil.STUDENT){
            
            sMap.put("studentId", user.getPosition());
            
        }
        Paper[] papers2= paperDao.getQueryPapersWithParms(sMap);
        for(Paper paper:papers2){
            papers.add(paper);
        } 
        return papers;
    }

    @Override
    public PaperMix getUserDonePaper(int pid,User user) {
        PaperMix paperMix=new PaperMix();
       try {
           // TODO Auto-generated method stub
           //1.获取基本的信息
       
           Paper paper=paperDao.getSpecPaper(pid);
           paperMix.setPaperDataIn(paper);
           //2.获取这个卷子的所有u p 
           User_paper[] upPapers= paperDao.getUser_papersByPid(pid);
           paperMix.getPaperMetaData().insertPapers(upPapers);
           //3.获取所有的user相关
           paperMix.setUsers(subjetServiceImp.getUserMixByUp(user,upPapers,paperMix.getPaperMetaData()));
           paperMix.setResult(true);
           return paperMix;
    } catch (Exception e) {
        LOGGER.error(e.getMessage());
        e.printStackTrace();
        paperMix.setResult(false);
        return paperMix;
        // TODO: handle exception
    }
        
    }

}

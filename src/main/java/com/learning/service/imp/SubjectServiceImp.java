package com.learning.service.imp;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.Vector;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Delete;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.learning.dao.ElementDao;
import com.learning.dao.SubjectDao;
import com.learning.dao.UserDao;
import com.learning.pojo.ChooseElement;
import com.learning.pojo.ElementMix;
import com.learning.pojo.LineElement;
import com.learning.pojo.PaperMetaData;
import com.learning.pojo.PaperMix;
import com.learning.pojo.Subject;
import com.learning.pojo.SubjectFromJs;
import com.learning.pojo.SubjectMetaData;
import com.learning.pojo.SubjectMix;
import com.learning.pojo.User;
import com.learning.pojo.UserMix;
import com.learning.pojo.UserPaper;
import com.learning.pojo.UserSubject;
import com.learning.pojo.User_paper;
import com.learning.pojo.User_subject;
import com.learning.pojo.User_subject_choose;
import com.learning.pojo.User_subject_line;
import com.learning.service.SubjectService;
import com.learning.util.ConstantUtil;

@Service
public class SubjectServiceImp implements SubjectService {

    private static Logger LOGGER = LoggerFactory
            .getLogger(SubjectServiceImp.class);
    @Resource
    private SubjectDao subjectDao;
    @Resource
    private ElementDao elementDao;
    @Resource
    private UserDao userDao;

    /**
     * 保存连线题传进来的文件
     * 
     * 
     * */
    @Override
    public boolean saveSubjectsFiles(String realPath,
            SubjectFromJs lineTypeSubject) {
        // TODO Auto-generated method stub
        Vector<String> picfilePaths = new Vector<>();
        Vector<String> audiofilePaths = new Vector<>();
        try {
            for (int i = 0; i < lineTypeSubject.getAudioFiles().size(); i++) {
                MultipartFile picFile = lineTypeSubject.getPicFiles()
                        .elementAt(i);
                System.out.println("pic——Type " + picFile.getContentType());
                System.out
                        .println("pic——Name " + picFile.getOriginalFilename());

                MultipartFile audioFile = lineTypeSubject.getAudioFiles()
                        .elementAt(i);
                String picFname = UUID.randomUUID().toString();
                String audioFname = UUID.randomUUID().toString();
                String picfilePath = realPath + ConstantUtil.UPLOAD
                        + ConstantUtil.IMG_PATH + picFname;
                String audiofilePath = realPath + ConstantUtil.UPLOAD
                        + ConstantUtil.AUDIO_PATH + audioFname;
                System.out.println("audioFile——Type "
                        + audioFile.getContentType());
                System.out.println("audioFile——Name "
                        + audioFile.getOriginalFilename());

                System.out.println("pic's file:" + picfilePath
                        + picFile.getOriginalFilename());
                System.out.println("audiofilePath file:" + audiofilePath
                        + audioFile.getOriginalFilename());
                // 保存到本地

                picFile.transferTo(new File(picfilePath));
                audioFile.transferTo(new File(audiofilePath
                        + ConstantUtil.WEBM_POSTFIX));
                lineTypeSubject.getPicUrl().add(picFname);// 前缀是一样的
                lineTypeSubject.getVideoUrl().add(
                        audioFname + ConstantUtil.WEBM_POSTFIX);
            }
        } catch (Exception e1) {
            LOGGER.error(e1.getMessage());
            e1.printStackTrace();
            for (String s : picfilePaths) {
                // 删除文件
                File eFile = new File(s);
                if (eFile.exists())
                    eFile.delete();

            }
            for (String s : audiofilePaths) {
                // 删除文件
                File eFile = new File(s);
                if (eFile.exists())
                    eFile.delete();

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
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, timeout = 1, isolation = Isolation.DEFAULT)
    public boolean insertSubject(SubjectFromJs subjectFromJs, int type) {
        // TODO Auto-generated method stub
        // 先在subject里面插一条记录
        Subject subject = new Subject();
        subject.setStitle(subjectFromJs.getTitle());
        subject.setStype(type);
        subject.setTotalScore(subjectFromJs.getTotalScore());
        //
        subjectDao.insertSubject(subject);
        int sid = subject.getSid();
        System.out.println("sid:" + sid + " pid:" + subjectFromJs.getPid());
        int num = subjectDao.insertS_P(sid, subjectFromJs.getPid());
        if (num < 0)
            return false;
        // 判断类型
        if (type == ConstantUtil.SUBJECT_LINE) {
            // 生成随机的顺序

            int[] randomNums = ConstantUtil.randomSeq(0, 3);// [0,3]
            System.out.println("randomNums.length:" + randomNums.length);
            for (int i = 0; i < subjectFromJs.getAudioFiles().size(); i++) {
                LineElement line = new LineElement();
                line.setPic(subjectFromJs.getPicUrl().elementAt(i));
                line.setVideo(subjectFromJs.getVideoUrl().elementAt(i));
                line.setScore(subjectFromJs.getScores().elementAt(i));
                line.setWord(subjectFromJs.getWords().elementAt(i));
                elementDao.insertIntoLine(line);
                int lid = line.getLid();
                // 插入关联表
                elementDao.insertIntoS_Line(sid, lid, randomNums[i]);

            }
        } else if (type == ConstantUtil.SUBJECT_CHOOSE) {
            for (int i = 0; i < subjectFromJs.getTexts().size(); i++) {
                ChooseElement cElement = new ChooseElement();
                cElement.setText(subjectFromJs.getTexts().elementAt(i));
                elementDao.insertIntoChoose(cElement);
                int cid = cElement.getCid();
                // 插入关联表
                elementDao.insertIntoS_choose(sid, cid,
                        subjectFromJs.getRightIndex());

            }

        } else {
            // 其他题型，暂时不做
            return false;

        }
        // 然后在s-line里面插记录
        return true;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, timeout = 1, isolation = Isolation.DEFAULT)
    public boolean insertSubjectAlreadyExist(int pid, int sid) {
        // TODO Auto-generated method stub
        // 因为已经存在，所以仅仅关联一下就行
        int num = subjectDao.insertS_P(sid, pid);
        return num > 0 ? true : false;
    }

    @Override
    public boolean saveOneSubject(SubjectMix subject) {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public boolean saveLineSubject(SubjectMix subject) {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public boolean saveChooseSubject(SubjectMix subject) {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public List<User_subject_line> countLineSubjet(SubjectMix subject,
            String uid, int pid) {
        // TODO Auto-generated method stub
        // 生成 user_subject_line的列表
        List<User_subject_line> lines = new ArrayList<User_subject_line>();
        for (int i = 0; i < subject.getEid().size(); i++) {
            int thisLid = subject.getEid().get(i);
            int otherLid = subject.getEid().get(subject.getSeq().get(i));
            User_subject_line user_subject_line = new User_subject_line();

            user_subject_line.setLid(thisLid);
            user_subject_line.setLotherId(otherLid);
            user_subject_line.setSid(subject.getSid());
            user_subject_line.setPid(pid);
            user_subject_line.setUid(uid);
            lines.add(user_subject_line);

        }

        return lines;
    }

    @Override
    public UserSubject getUserSubject_Line(int pid, String uid, int sid) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public UserSubject getUserSubject_Choose(int pid, String uid) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public UserSubject getUserSubject(int pid, String uid, int sid) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<UserSubject> getSubjects(int pid, String uid, int sid) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public User_subject countSubject(SubjectMix subjectMix, String uid, int pid) {
        // TODO Auto-generated method stub
        // 计算需要的东西，
        User_subject user_subject = new User_subject();
        user_subject.setPid(pid);
        user_subject.setScore(0);
        user_subject.setTotalSecond(ConstantUtil.getTimeBetween(
                subjectMix.getStartTime(), subjectMix.getEndTime()));
        user_subject.setUid(uid);
        user_subject.setSid(subjectMix.getSid());
        boolean isWrong = false;
        if (subjectMix.getType() == ConstantUtil.SUBJECT_LINE) {
            // 算连线题的分
            for (int i = 0; i < subjectMix.getSeq().size(); i++) {
                if (subjectMix.getSeq().get(i) == i) {
                    // 相符了有分,累加分数
                    user_subject.setScore(user_subject.getScore()
                            + subjectMix.getScores().get(i));

                } else { 

                    isWrong = true;
                }

            }
            user_subject.setWrong(isWrong);
        } else if (subjectMix.getType() == ConstantUtil.SUBJECT_CHOOSE) {
            if (subjectMix.getChoosenIndex() == subjectMix.getAnswerIndex()) {
                user_subject.setScore(user_subject.getScore() + 2);// 选择题就两分

            } else {
                isWrong = true;
            }

            user_subject.setWrong(isWrong);
        }
        return user_subject;
    }

    @Override
    public List<User_subject_choose> countChooseSubjet(SubjectMix subject,
            String uid, int pid) {
        List<User_subject_choose> list = new ArrayList<User_subject_choose>();

        int chooseId = subject.getChoosenIndex();
        User_subject_choose user_subject_choose = new User_subject_choose();
        user_subject_choose.setSid(subject.getSid());
        user_subject_choose.setChooseId(chooseId);// 这个id只是一个Index,
        user_subject_choose.setPid(pid);
        user_subject_choose.setUid(uid);
        list.add(user_subject_choose);
        return list;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, timeout = 1, isolation = Isolation.DEFAULT)
    public void insertUser_subject_lines(List<User_subject_line> list) {
        // TODO Auto-generated method stub
        // 现在需要调dao层写入
        for (int i = 0; i < list.size(); i++) {
            subjectDao.insertUser_subject_line(list.get(i));

        }

    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, timeout = 1, isolation = Isolation.DEFAULT)
    public void insertUser_subject_chooses(List<User_subject_choose> list) {
        // TODO Auto-generated method stub
        for (int i = 0; i < list.size(); i++) {
            subjectDao.insertUser_subject_choose(list.get(i));

        }
    }

    @Override
    public UserMix getUserMixByUid(String uid) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<UserMix> getUserMixByUp(User user, User_paper[] upList,
            PaperMetaData p) throws Exception {
        List<UserMix> userMixs = new ArrayList<>();
        List<SubjectMetaData> subjectMetaDatas = new ArrayList<>();
        // TODO Auto-generated method stub
  
        boolean subjectMetaDataFinish = false;

        for (User_paper user_paper : upList) {
            // 只可能有一个卷子
            String uid = user_paper.getUid();
            if(ConstantUtil.STUDENT == user.getPosition()){
                if(uid.equals(user.getUid()) ==false )continue;//避免学生也能获取其他人的
                
            }
            int pid = user_paper.getPid();
            UserMix userMix = new UserMix();

            List<SubjectMix> subjectMixs = new ArrayList<>();

            User_subject[] user_subjects = subjectDao
                    .getUser_subjects(uid, pid);
            int totalScore=0;
            for (User_subject user_subject : user_subjects) {
                // sid 也都只出现一次
                int sid = user_subject.getSid();
                
                SubjectMetaData subjectMetaData = new SubjectMetaData();
                if (subjectMetaDataFinish == false) {
                    // 只用做一次就行了
                    User_subject[] user_subjects2 = subjectDao
                            .getUser_subjectsBysid_pid(sid, pid);//横向，取所有的
                    subjectMetaData.countAllTimes(user_subjects2);// 每个用户在这个地方的做题情况
                    subjectMetaDatas.add(subjectMetaData);// 统计一下

                }
                SubjectMix subjectMix = subjectDao.getSubject(uid, pid, sid);// 特定用户在这个卷子上的答题情况
                // 剩下的用户选的和题本身答案在下面
                totalScore+=subjectMix.getScore();
                if (subjectMix.getType() == ConstantUtil.SUBJECT_LINE) {
                    setSubjectMixByU_sAndEle(subjectMix, user_subject,
                            subjectMix.getType());

                } else if (subjectMix.getType() == ConstantUtil.SUBJECT_CHOOSE) {
                    setSubjectMixByU_sAndEle(subjectMix, user_subject,
                            subjectMix.getType());

                }
                subjectMix.setTotalSecond_num(Long.parseLong(subjectMix.getTotalSecond()));
                subjectMix.setTotalSecond(ConstantUtil.formatTime(Long.parseLong(subjectMix.getTotalSecond())));
                
                subjectMixs.add(subjectMix);
            }
            subjectMetaDataFinish = true;//下次循环就不用做了
            //设置userMix的各种信息
            userMix.setSubjects(subjectMixs);
            userMix.setTotalSecond(ConstantUtil.formatTime(ConstantUtil
                    .getTimeBetween(user_paper.getStartTime(),
                            user_paper.getEndTime())));
            userMix.setTotalSecond_num(ConstantUtil
                    .getTimeBetween(user_paper.getStartTime(),
                            user_paper.getEndTime()));
            userMix.setScoreRank(p.getScoreRank(user_paper.getTotalScore()));
            userMix.setTimeRank(p.getTimeRank(ConstantUtil.getTimeBetween(
                    user_paper.getStartTime(), user_paper.getEndTime())));
            userMix.setUid(uid);
            User user2 = userDao.getUserByUid(uid);
            userMix.setUname(user2.getUname());
            userMix.setTotalScore(totalScore);

            userMixs.add(userMix);

        }

        p.setSubjectMetaDatas(subjectMetaDatas);
        return userMixs;
    }

    private void setSubjectMixByU_sAndEle(SubjectMix subjectMix,
            User_subject user_subject, int type) {
        // 在这里根据题型去做
        if (type == ConstantUtil.SUBJECT_LINE) {
            // 1.获取
            String uid = user_subject.getUid();
            int pid = user_subject.getPid();
            int sid = user_subject.getSid();
            ElementMix[] lines = elementDao.getLineElementMixs(uid, pid, sid);

            // 现在要把这个放进去 pics words
            subjectMix.setElementsByType(lines, type);// 这个函数操作完，就已经完成了pic/w/a
                                                      // selectList indexList
                                                      // 的设置

        } else {
            // 1.获取
            String uid = user_subject.getUid();
            int pid = user_subject.getPid();
            int sid = user_subject.getSid();
            ElementMix[] lines = elementDao.getChooseElementMixs(uid, pid, sid);
            // 现在要把这个放进去 pics words
            subjectMix.setElementsByType(lines, type);// 这个函数操作完，就已经完成了pic
                                                      // selectList的设置

        }

    }

}

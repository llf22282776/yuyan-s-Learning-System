package com.learning.dao;


import com.learning.pojo.ChooseElement;
import com.learning.pojo.ElementMix;
import com.learning.pojo.LineElement;
import com.learning.pojo.Subject_line;
import com.learning.pojo.User_subject_choose;
import com.learning.pojo.User_subject_line;

public interface ElementDao {
    public int insertIntoLine(LineElement lineEle);
    public int insertIntoS_Line(int sid,int lid,int index);
    
    public int insertIntoChoose(ChooseElement chooseElement);
    public int insertIntoS_choose(int sid,int cid,int answerId);
    public LineElement[] getLinesBySid(int sid);
    public Subject_line[] getLinesSeq(int sid);//获取连线题的顺序
    public ChooseElement[] getChoosesBySid(int sid);
    public int getRightChoosenIndex(int sid);//获取正确的选择题选项
    
    public User_subject_line[] getUser_Paer_Subjet_lines(String uid,int pid,int sid);
    public User_subject_choose[] getUser_Paer_Subjet_chooses(String uid,int pid,int sid);
    public ElementMix[] getLineElementMixs(String uid,int pid,int sid);
    public ElementMix[] getChooseElementMixs(String uid,int pid,int sid);
    
}

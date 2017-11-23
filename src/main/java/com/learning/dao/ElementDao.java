package com.learning.dao;


import com.learning.pojo.ChooseElement;
import com.learning.pojo.LineElement;
import com.learning.pojo.Subject_line;

public interface ElementDao {
    public int insertIntoLine(LineElement lineEle);
    public int insertIntoS_Line(int sid,int lid,int index);
    
    public int insertIntoChoose(ChooseElement chooseElement);
    public int insertIntoS_choose(int sid,int cid,int answerId);
    public LineElement[] getLinesBySid(int sid);
    public Subject_line[] getLinesSeq(int sid);//获取连线题的顺序
    public ChooseElement[] getChoosesBySid(int sid);
    public int getRightChoosenIndex(int sid);//获取正确的选择题选项
    
    
    
}

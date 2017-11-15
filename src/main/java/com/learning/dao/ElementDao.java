package com.learning.dao;


import com.learning.pojo.ChooseElement;
import com.learning.pojo.LineElement;

public interface ElementDao {
    public int insertIntoLine(LineElement lineEle);
    public int insertIntoS_Line(int sid,int lid);
    
    public int insertIntoChoose(ChooseElement chooseElement);
    public int insertIntoS_choose(int sid,int cid,int answerId);
    public LineElement[] getLinesByBid(int bid);
    public ChooseElement[] getChoosesByBid(int bid);
    
}

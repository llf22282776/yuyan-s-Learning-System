package com.learning.service;

import org.springframework.stereotype.Service;

import com.learning.pojo.PaperMsg;
@Service
public interface PaperService {
    public int insertPaper(PaperMsg paperMsg);
}

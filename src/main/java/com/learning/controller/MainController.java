package com.learning.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class MainController {
    @RequestMapping(value="/", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String welcomeRequest(HttpServletRequest req, HttpServletResponse res){
        
        return "login";

    }
    @RequestMapping(value="/login", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String login(HttpServletRequest req, HttpServletResponse res){
        return "";

    }
}

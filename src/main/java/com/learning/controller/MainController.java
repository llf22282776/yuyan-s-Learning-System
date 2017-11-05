package com.learning.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;









import org.jsoup.helper.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.learning.pojo.CommonRes;
import com.learning.pojo.User;
import com.learning.service.UserService;
import com.learning.util.ConstantUtil;

@Controller
@RequestMapping("/")
public class MainController {
    @Resource
    private UserService userServiceImp;
    
    
    
    @RequestMapping(value="/", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String welcomeRequest(HttpServletRequest req, HttpServletResponse res){
        
        return "login";

    }
    @RequestMapping(value="/login", method = { RequestMethod.POST,
            RequestMethod.GET })
    @ResponseBody
    public JSONObject login(HttpServletRequest req, HttpServletResponse res){
        String userName = req.getParameter("passport");
        String password = req.getParameter("password");
      
        CommonRes commonRes = new CommonRes();
        if (StringUtil.isBlank(userName) || StringUtil.isBlank(password)) {
            commonRes.setSucceed(false);
            commonRes.setDes("账号密码不可以为空");
        } else {
            if (userServiceImp.isUser(userName,password)) {
                // 返回真，然后塞user
                commonRes.setSucceed(true);
                commonRes.setDes("Logined");
                User user = userServiceImp.getUser(userName, password);
                req.getSession().setAttribute("user", user);
            } else {
                commonRes.setSucceed(false);
                commonRes.setDes("账号或密码错误");
            }

        }
        System.out.println("login");
        return JSONObject.parseObject(JSONObject.toJSONString(commonRes));
        
        
       

    }

    @RequestMapping(value="/main", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String main(HttpServletRequest req, HttpServletResponse res){
        User usr=(User) req.getSession().getAttribute("user");
        if(usr.getPosition() == ConstantUtil.STUDENT){
            return "student";//返回学生界面
            
            
        }else {
            return "teacher";//返回老师界面
        }

    }
    @RequestMapping(value="/logOut", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String logOut(HttpServletRequest req, HttpServletResponse res){
        req.getSession().removeAttribute("user");
        return "login";

    }
}

package com.learning.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.helper.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.learning.pojo.CommonRes;
import com.learning.pojo.Paper;
import com.learning.pojo.PaperMix;
import com.learning.pojo.PaperMsg;
import com.learning.pojo.SubjectFromJs;
import com.learning.pojo.User;
import com.learning.service.PaperService;
import com.learning.service.SubjectService;
import com.learning.service.UserService;
import com.learning.util.ConstantUtil;
import com.sun.org.apache.xerces.internal.impl.dtd.models.CMAny;

@Controller
@RequestMapping("/")
public class MainController {
    @Resource
    private UserService userServiceImp;
    @Resource
    private SubjectService subjectServiceImp;

    @Resource
    private PaperService paperServiceImp;

    private static Logger LOGGER = LoggerFactory
            .getLogger(MainController.class);

    @RequestMapping(value = "/", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String welcomeRequest(HttpServletRequest req, HttpServletResponse res) {

        return "login";

    }

    @RequestMapping(value = "/login", method = { RequestMethod.POST,
            RequestMethod.GET })
    @ResponseBody
    public JSONObject login(HttpServletRequest req, HttpServletResponse res) {
        String userName = req.getParameter("passport");
        String password = req.getParameter("password");

        CommonRes commonRes = new CommonRes();
        if (StringUtil.isBlank(userName) || StringUtil.isBlank(password)) {
            commonRes.setSucceed(false);
            commonRes.setDes("账号密码不可以为空");
        } else {
            if (userServiceImp.isUser(userName, password)) {
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

    @RequestMapping(value = "/main", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String main(HttpServletRequest req, HttpServletResponse res) {
        User usr = (User) req.getSession().getAttribute("user");
        System.out.println("userName:" + usr.getUname());
        req.setAttribute("userName", usr.getUname());
        if (usr.getPosition() == ConstantUtil.STUDENT) {
            int num = paperServiceImp.getStudentNotTodoPaperNums(usr.getUid());
            System.out.println("num:" + num);
            req.setAttribute("paperNums", num);
            return "student";// 返回学生界面

        } else {
            return "teacher";// 返回老师界面
        }

    }

    @RequestMapping(value = "/logOut", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String logOut(HttpServletRequest req, HttpServletResponse res) {
        req.getSession().removeAttribute("user");
        return "login";

    }

    @RequestMapping(value = "/subjectUpload", method = { RequestMethod.POST })
    @ResponseBody
    public JSONObject subjectUpload(HttpServletRequest req,
            HttpServletResponse res) {
        // 这里要判断type的值
        int type = Integer.parseInt(req.getParameter("type"));
        int pid = Integer.parseInt(req.getParameter("pid"));
        // 获得对应类型的subjectFromJs
        SubjectFromJs subjectFromJs = getSubjectsFromWeb(req, type, pid);
        CommonRes commonRes = new CommonRes();
        if (type == ConstantUtil.SUBJECT_LINE) {

            // 现在，需要吧图片和声音存到文件里面去,得到一个路径
            String filePath = req.getSession().getServletContext()
                    .getRealPath("/");
            if (subjectServiceImp.saveSubjectsFiles(filePath, subjectFromJs) == false) {
                // 失败了
                commonRes.setDes("文件保存失败！请联系管理员");
                commonRes.setSucceed(false);
                return JSONObject.parseObject(JSONObject
                        .toJSONString(commonRes));
            }
        }

        boolean insertSucceed = true;
        try {
            insertSucceed = subjectServiceImp
                    .insertSubject(subjectFromJs, type);
        } catch (Exception e) {
            // TODO: handle exception
            LOGGER.error(e.getMessage());
            insertSucceed = false;
        }
        if (insertSucceed == false) {
            commonRes.setDes("插入表失败");
            commonRes.setSucceed(false);

        } else {
            commonRes.setDes("");
            commonRes.setSucceed(true);

        }

        return JSONObject.parseObject(JSONObject.toJSONString(commonRes));
    }

    @RequestMapping(value = "/paperUpload", method = { RequestMethod.POST,
            RequestMethod.GET })
    @ResponseBody
    public JSONObject paperUpload(@RequestBody PaperMsg paperMsg,
            HttpServletRequest req, HttpServletResponse res) {
        // 这上传paper的信息
        // 上传试卷
        CommonRes commonRes = new CommonRes();
        System.out.println("title:" + paperMsg.getTitle() + " date:"
                + paperMsg.getDate());
        try {
            int pid = paperServiceImp.insertPaper(paperMsg);
            commonRes.setDes(pid + "");
            commonRes.setSucceed(true);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            LOGGER.error(e.getMessage());
            commonRes.setDes("插入表失败");
            commonRes.setSucceed(false);
        }
        return JSONObject.parseObject(JSONObject.toJSONString(commonRes));

    }

    @RequestMapping(value = "/subjectUploadAlreadyExist", method = {
            RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public JSONObject subjectUploadAlreadyExist(HttpServletRequest req,
            HttpServletResponse res) {
        // 这里上传
        int pid = -1;
        int sid = -1;
        CommonRes commonRes = new CommonRes();

        try {
            pid = Integer.parseInt(req.getParameter("pid"));
            sid = Integer.parseInt(req.getParameter("sid"));
            if (subjectServiceImp.insertSubjectAlreadyExist(pid, sid) == false) {
                commonRes.setDes("插入表失败");
                commonRes.setSucceed(false);

            } else {
                commonRes.setDes("");
                commonRes.setSucceed(true);
            }

        } catch (Exception e) {
            // TODO: handle exception

            commonRes.setDes("插入表失败");
            commonRes.setSucceed(false);
        }

        return JSONObject.parseObject(JSONObject.toJSONString(commonRes));

    }

    @RequestMapping(value = "/insertUser", method = { RequestMethod.POST,
            RequestMethod.GET })
    @ResponseBody
    public JSONObject subjectUploadAlreadyExist(@RequestBody User user,
            HttpServletRequest req, HttpServletResponse res) {
        CommonRes commonRes = new CommonRes();
        boolean isSucceed = false;
        try {
            isSucceed = userServiceImp.insertUser(user);

        } catch (Exception e) {
            // TODO: handle exception
            LOGGER.error(e.getMessage());
            e.printStackTrace();
            isSucceed = false;

        }
        commonRes.setSucceed(isSucceed);
        commonRes.setDes(isSucceed ? "添加成功" : "添加失败");
        return JSONObject.parseObject(JSONObject.toJSONString(commonRes));

    }

    @RequestMapping(value = "/getStudentNodoingPaperNums", method = {
            RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public JSONObject getStudentNodoingPaperNums(HttpServletRequest req,
            HttpServletResponse res) {
        User user = (User) req.getSession().getAttribute("user");
        int num = paperServiceImp.getStudentNotTodoPaperNums(user.getUid());
        CommonRes commonRes = new CommonRes();
        commonRes.setSucceed(true);
        commonRes.setDes(num + "");
        return JSONObject.parseObject(JSONObject.toJSONString(commonRes));

    }

    @RequestMapping(value = "/getStudentNodoingPaperPage", method = {
            RequestMethod.POST, RequestMethod.GET })
    public String getStudentNodoingPaperPage(HttpServletRequest req,
            HttpServletResponse res) {
        // 注意重定向到合适的地方去
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || user.getPosition() == ConstantUtil.TEACHER) {
            // 老师或者没登录
            return "redirect:/"; // 重定向
        } else {
            // 1.先获取一下，未做试卷
            List<Paper> paperList = paperServiceImp
                    .getStudentNotTodoPaperList(user.getUid());

            // 3 返回这个页面
            System.out.println("paperList'size:" + paperList.size());
            req.setAttribute("userName", user.getUname());
            req.setAttribute("paperList", paperList);

            req.setAttribute("length", paperList.size());

            return "paper/paperList";

        }

    }

    @RequestMapping(value = "/paperTestPage", method = { RequestMethod.POST,
            RequestMethod.GET })
    public String paperTestPage(HttpServletRequest req, HttpServletResponse res) {
        // 返回一个网页，这个网页异步请求题目
        // 不是每个请求都要返回网站，如果本身没有session里面没有，pid
        if (testUser(req, ConstantUtil.STUDENT) == false
                || req.getSession().getAttribute("pid") == null)
            return "redirect:/";

        setUsername(req);
        return "paper/paperTestPage";

    }

    @RequestMapping(value = "/getPaperMetaMsg", method = { RequestMethod.POST,
            RequestMethod.GET })
    @ResponseBody
    public JSONObject getPaperMetaMsg(HttpServletRequest req,
            HttpServletResponse res) {

        CommonRes commonRes = new CommonRes();

        try {
            // 1.获取pid
            User usr = (User) req.getSession().getAttribute("user");
            int pid = Integer.parseInt(req.getParameter("pid"));
            if (paperServiceImp.testPaperDone(usr.getUid(), pid) == false) {
                // 没有做过
                req.getSession().setAttribute("pid", pid);
                commonRes.setDes("");
                commonRes.setSucceed(true);
            } else {

                commonRes.setDes("");
                commonRes.setSucceed(false);
            }

        } catch (Exception e) {
            LOGGER.error(e.getMessage());
            e.printStackTrace();
            commonRes.setDes("");
            commonRes.setSucceed(false);
            // TODO: handle exception
        }

        return JSONObject.parseObject(JSONObject.toJSONString(commonRes));

    }

    @RequestMapping(value = "/getTestPaper", method = { RequestMethod.POST,
            RequestMethod.GET })
    @ResponseBody
    public JSONObject getTestPaper(HttpServletRequest req,
            HttpServletResponse res) {

        PaperMix paperMix = null;
        try {
            // 1.获取pid uid

            int pid = (int) req.getSession().getAttribute("pid");
            // 这里组织一下,如果失效了，那么就设置result false
            paperMix = paperServiceImp.getPaperMixDetail(pid);
            if(paperMix.getSubjects().size()>0)paperMix.setResult(true);
            // 移除pid
            req.getSession().removeAttribute("pid");
        } catch (Exception e) {
            paperMix = new PaperMix();
            paperMix.setResult(false);
            LOGGER.error(e.getMessage());
            e.printStackTrace();

            // TODO: handle exception
        }
        return JSONObject.parseObject(JSONObject.toJSONString(paperMix));
    }

    private SubjectFromJs getSubjectsFromWeb(HttpServletRequest req, int type,
            int pid) {
        SubjectFromJs subjectFromJs = new SubjectFromJs();

        subjectFromJs.setTitle(req.getParameter("title"));
        subjectFromJs.setPid(pid);
        subjectFromJs.setTotalScore(Integer.parseInt(req
                .getParameter("totalScore")));

        if (type == ConstantUtil.SUBJECT_LINE) {
            // 连线题 需要获得4个audio和4个pic还有其他的东西

            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
            for (int i = 0; i < 4; i++) {

                subjectFromJs.getPicFiles().add(
                        multipartRequest.getFile("pic" + i));
                subjectFromJs.getAudioFiles().add(
                        multipartRequest.getFile("audio" + i));
                subjectFromJs.getWords().add(
                        multipartRequest.getParameter("word" + i));
                subjectFromJs.getScores().add(
                        Integer.parseInt(multipartRequest.getParameter("score"
                                + i)));
            }
        } else if (type == ConstantUtil.SUBJECT_CHOOSE) {

            for (int i = 0; i < 4; i++) {
                subjectFromJs.getTexts().add(req.getParameter("text" + i));
            }
            // 正确的序号
            subjectFromJs.setRightIndex(Integer.parseInt(req
                    .getParameter("index")));
        }
        return subjectFromJs;
    }

    private boolean testUser(HttpServletRequest req, int postion_required) {
        User usr = (User) req.getSession().getAttribute("user");
        if (usr == null)
            return false;
        else if (usr.getPosition() != postion_required)
            return false;
        return true;

    }

    private void setUsername(HttpServletRequest req) {
        User usr = (User) req.getSession().getAttribute("user");
        req.setAttribute("userName", usr.getUname());

    }
}

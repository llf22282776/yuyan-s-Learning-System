package com.learning.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.learning.pojo.User;
import com.learning.util.ConstantUtil;




public class RedirectionFilter implements Filter{
   
    private static Logger LOGGER = LoggerFactory.getLogger(RedirectionFilter.class);
    public void init(FilterConfig filterConfig) throws ServletException {
        // TODO Auto-generated method stub
        
    }

    public void doFilter(ServletRequest req, ServletResponse res,
            FilterChain chain) throws IOException, ServletException {
        // TODO Auto-generated method stub
        HttpServletRequest request=(HttpServletRequest)(req);
        HttpServletResponse response=(HttpServletResponse)(res);
        String uri=request.getRequestURI();
        //去掉前面的learning
        User user=(User)request.getSession().getAttribute("user");
        System.out.println("before uri:"+uri);
        String rootPrefix=uri.substring(0, uri.indexOf(ConstantUtil.URL_PREFIX, 1));
        uri=uri.substring(uri.indexOf(ConstantUtil.URL_PREFIX, 1));
        System.out.println("after uri:"+uri);
        if(uri.endsWith(".jsp")){
            //不能访问,重定向到根目录
            if(!response.isCommitted())response.sendRedirect(rootPrefix);//根目录
            return ;
            
        }
        if( uri.startsWith("/css") ||
            uri.startsWith("/fonts") ||
            uri.startsWith("/font") ||
            uri.startsWith("/js") || 
            uri.startsWith("/img") ||
            uri.startsWith("/assets") ||
            uri.startsWith("/upload")
                ){
            
            chain.doFilter(req, res);
            
        }else if(user !=null){
            //登录
            if(uri.endsWith("login") || uri.equals("/")){
                //定向到
                if(!response.isCommitted())response.sendRedirect(rootPrefix+ConstantUtil.MAIN_URL);
                return ;
                
            }else {
                chain.doFilter(req, res);
            }
        }else {
            // 未登录
            if(uri.endsWith("login") || uri.equals("/")){
                //这两个不拦截
                chain.doFilter(req, res);
                
                
            }else {
               //其他的都定向的根目录
                if(!response.isCommitted())response.sendRedirect(rootPrefix);//根目录
                return ;
                
            }
            
        }
        
        
    }

    public void destroy() {
        // TODO Auto-generated method stub
        
    }


}

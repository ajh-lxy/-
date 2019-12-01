package com.fh.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
    //登录拦截
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //从session中获取登录信息
        Object userInfo = request.getSession().getAttribute("userInfo");
        //取路径
        String servletPath = request.getServletPath();
        //登录方法不拦截
        if (servletPath.endsWith("login.jhtml")){
            return true;
        }
        //判断是否为空，是否是经过正常途径访问的
        if (!(userInfo ==null)){
            return true;
        }else {
            //跳转登录页面
            response.sendRedirect(request.getContextPath()+"/login.jsp");
            return false;
        }
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}

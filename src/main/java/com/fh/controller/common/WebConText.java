package com.fh.controller.common;

import javax.servlet.http.HttpServletRequest;

public class WebConText {

    public static ThreadLocal<HttpServletRequest> requestThreadLocal=new ThreadLocal<HttpServletRequest>();

    //将当前请求对应的线程为key，request为value，将当前线程图request进行绑定
    public static void serRequest(HttpServletRequest request){
        requestThreadLocal.set(request);
    }
    //已当前线程为key，取对应的value，
    public static HttpServletRequest getRequest(){
        return requestThreadLocal.get();
    }
    //解除与当前线程的绑定
    public static void remove(){
        requestThreadLocal.remove();
    }
}

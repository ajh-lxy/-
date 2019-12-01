package com.fh.controller.common;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class WebConTextFile implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //进行绑定
        WebConText.serRequest((HttpServletRequest) request);
        try{
            //继续执行之后的逻辑，放行
            chain.doFilter(request, response);
        }finally{
            //解除绑定
            WebConText.remove();
        }
    }

    public void destroy() {

    }
}

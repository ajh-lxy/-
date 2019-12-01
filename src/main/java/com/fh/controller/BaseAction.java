/**
 * <pre>项目名称:shop_admin_two
 * 文件名称:BaseAction.java
 * 包名:com.fh.shop.backend.action.log
 * 创建日期:2018年12月26日下午10:02:22
 * Copyright (c) 2018, 3095803056@qq.com .com All Rights Reserved.</pre>
 */
package com.fh.controller;

import com.fh.controller.common.FileInfo;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * <pre>项目名称：shop_admin_two    
 * 类名称：BaseAction    
 * 类描述：    
 * 创建人：安家辉 3095803056@qq.com    
 * 创建时间：2018年12月26日 下午10:02:22    
 * 修改人：安家辉 3095803056@qq.com     
 * 修改时间：2018年12月26日 下午10:02:22    
 * 修改备注：       
 * @version </pre>    
 */
public class BaseAction {

    /**
     * 获取根目录
     * @param request
     * @return
     */
    protected String getRootPath(HttpServletRequest request) {
        String rootPath = request.getServletContext().getRealPath("/");
        return rootPath;
    }

    /**
     * 文件信息[头像]
     * @param photo
     * @return
     * @throws IOException
     */
    protected FileInfo convertFileInfo(@RequestParam MultipartFile photo) throws IOException {
        FileInfo fileInfo = new FileInfo();
        fileInfo.setInputStream(photo.getInputStream());
        fileInfo.setOriginalFilename(photo.getOriginalFilename());
        fileInfo.setSize(photo.getSize());
        return fileInfo;
    }

    /**
     * 多文件[子图]
     * @param childsImage
     * @return
     * @throws IOException
     */
    protected List<FileInfo> converFileInfoList(MultipartFile[] childsImage) throws IOException {
        List<FileInfo> fileInfoList = new ArrayList<FileInfo>();
        for (MultipartFile childsImages : childsImage) {
            if (childsImages.getSize() > 0) {
                fileInfoList.add(convertFileInfo(childsImages));
            }
        }
        return fileInfoList;
    }

    public void outJson(String json, HttpServletResponse response) {
        PrintWriter writer = null;
        try {
            //通过response获取writer
            writer = response.getWriter();
            //将通过writer将json字符串响应给客户端（浏览器）
            writer.write(json);
            //清空
            writer.flush();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //关流
            if (writer != null) {
                writer.close();
                writer = null;
            }
        }
    }

    /**
     * <pre>getIpAddress(获取IP地址)
     * 创建人：安家辉 3095803056@qq.com
     * 创建时间：2018年12月2日 下午6:39:35
     * 修改人：安家辉 3095803056@qq.com
     * 修改时间：2018年12月2日 下午6:39:35
     * 修改备注：
     * @return</pre>
     */
    public static   String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

}

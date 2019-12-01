package com.fh.util;

import com.fh.controller.common.SystemConstants;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

public class FTPUtil extends SystemConstants {

	private static Logger logger = LoggerFactory.getLogger(FTPUtil.class);
    private static String ftpIp = FTP_ID;
    private static String ftpUser= FTP_USER;
    private static String ftpPass = FTP_PASSWORD;
    FTPUtil(String ip,int port,String user,String pwd){
        this.ip = ip;
        this.port = port;
        this.pwd = pwd;
        this.user= user;
    }


    /**
     * 对外暴露的上传文件方法
     * @param fileList
     * @return
     */
    public static boolean  uploadFile(List<File> fileList) throws IOException {
        FTPUtil ftpUtil = new FTPUtil(ftpIp,FTP_PORT,ftpUser,ftpPass);
        logger.info("开始连接FTP服务器");
        //把异常抛给service层，不在此处理
        boolean result = ftpUtil.uploadFile("img",fileList);
        logger.info("开始连接FTP服务器，结束上传，上传结果{}",result);
        return result;
    }

    public static String getFtpIp() {
        return ftpIp;
    }

    public static void setFtpIp(String ftpIp) {
        FTPUtil.ftpIp = ftpIp;
    }

    private boolean uploadFile(String remotePath, List<File> fileList) throws IOException {
        boolean uploaded = true;
        FileInputStream fis = null;
        //连接FTP服务器
        if(connectServer(this.getIp(),this.getUser(),this.getPwd())){
            try {
            	//切换工作路径 ftpserver
                ftpClient.changeWorkingDirectory(remotePath);
                ftpClient.setBufferSize(1024);
                ftpClient.setControlEncoding("UTF-8");
                //设置成二进制格式可以防止乱码
                ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
                //被动模式存储
                ftpClient.enterLocalPassiveMode();
                //遍历文件存储
                for(File fileItem : fileList){
                    //把文件转成文件流
                    fis = new FileInputStream(fileItem);
                    //调用storeFile方法存储
                    ftpClient.storeFile(fileItem.getName(),fis);
                }
            } catch (IOException e) {
                logger.error("上传文件异常",e);
                uploaded = false;

            }
            finally {
                //关闭连接和文件流
                fis.close();
                ftpClient.disconnect();
            }
        }
        return uploaded;
    }

    /**
     * 连接FTP服务器
     * @param ip
     * @param user
     * @param pwd
     * @return
     */
    private boolean connectServer(String ip, String user,String pwd ){
        boolean isSuccess = false;
        ftpClient = new FTPClient();
        try{
            ftpClient.connect(ip);
            isSuccess =  ftpClient.login(user,pwd);
        }catch (IOException e){
            logger.error("FTP服务器连接失败",e);

        }
        return isSuccess;
    }
  private String ip ;
    private int port;
    private String user;
    private String pwd;
    private FTPClient ftpClient ;

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public static String getFtpTp() {
        return ftpIp;
    }

    public static void setFtpTp(String ftpTp) {
        FTPUtil.ftpIp = ftpTp;
    }

    public static String getFtpUser() {
        return ftpUser;
    }

    public static void setFtpUser(String ftpUser) {
        FTPUtil.ftpUser = ftpUser;
    }

    public static String getFtpPass() {
        return ftpPass;
    }

    public static void setFtpPass(String ftpPass) {
        FTPUtil.ftpPass = ftpPass;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public FTPClient getFtpClient() {
        return ftpClient;
    }

    public void setFtpClient(FTPClient ftpClient) {
        this.ftpClient = ftpClient;
    }
}

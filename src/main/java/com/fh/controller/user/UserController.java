package com.fh.controller.user;

import com.aliyun.oss.HttpMethod;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.GeneratePresignedUrlRequest;
import com.fh.controller.BaseAction;
import com.fh.controller.common.ResponseEnum;
import com.fh.controller.common.ServerResponse;
import com.fh.controller.common.SystemConstants;
import com.fh.entity.user.UserInfo;
import com.fh.service.user.IUserService;
import com.fh.util.DateUtils;
import com.fh.util.FileUtil;
import com.fh.util.FtpZhuanYong;
import com.fh.util.OssUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("staUser/")
public class UserController extends BaseAction {

    @Resource(name = "userService")
    private IUserService userService;
    /**
     * 登录
     * @param userInfo
     * @param request
     * @return
     */
    @RequestMapping("login")
    @ResponseBody
    public ServerResponse login(UserInfo userInfo, HttpServletRequest request, HttpServletResponse response){
        UserInfo userMy = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            //验证账号密码验证码不为空
            if(StringUtils.isEmpty(userInfo.getUserName()) || StringUtils.isEmpty(userInfo.getUserPwd()) || StringUtils.isEmpty(userInfo.getImgCode())){
                return ServerResponse.error(ResponseEnum.USERNAME_PWD_IMGCODE_ERROR);
            }
            //验证一下验证码是否正确
            //验证验证码
            String sessionImgCode = (String) request.getSession().getAttribute(SystemConstants.IMGCODE);
            if (!userInfo.getImgCode().equals(sessionImgCode)){
                return ServerResponse.error(ResponseEnum.IMGCODE_ERROR);
            }
            //查询用户信息
            userMy = userService.findUserNameList(userInfo);

            //如果错误时间和当前时间不在同一天则把用户状态设为解放状态
            //如果没有错误时间，证明该用户没错过就不进行错误时间对比了
            if (userMy.getLoginErrorTime()!=null){
                if (!sdf.format(userMy.getLoginErrorTime()).equals(sdf.format(getNextDay(userMy.getLoginErrorTime())))){
                    userMy.setUserStauts(1);
                }
            }
            //判断用户是否被锁定
            if (userMy.getUserStauts()!=1){
                return ServerResponse.error(ResponseEnum.LOGINCOUNT_ERROR);
            }
            //验证用户是否存在
            if (userMy==null){
                return ServerResponse.error(ResponseEnum.USERNAME_ERROR);
            }
            //验证，密码是否正确
            if (!userInfo.getUserPwd().equals(userMy.getUserPwd())){
                //判断登录错误
                pwdError(userMy);
                //修改用户的状态或者错误次数的信息
                userService.updateLogin(userMy);
                return ServerResponse.error(ResponseEnum.PWD_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
        //如果登录成功一次则把错误次数清零,并给上登录时间
        userMy.setTopLoginTime(userMy.getLoginTime());
        UserInfo userInfo1=upLoginErrorLoginTime(userMy);
        //如果上次登录时间与当前时间不再同一天则 把登录次数给成1
        if (userMy.getLoginTime()!=null && userMy.getTopLoginTime()!=null){
            if (!sdf.format(userMy.getLoginTime()).equals(sdf.format(userMy.getTopLoginTime()))){
                userInfo1.setLoginCount(1);
            }
        }
        userService.updateLogin(userInfo1);
        //成功后把信息放入session中
        request.getSession().setAttribute("userInfo",userMy);
        //获取Cookie对象
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie cookie : cookies) {
                //获取Cookie的名字
                String name = cookie.getName();
                if("JSESSIONID".equals(name)){
                    //持久化该Cookie对象
                    cookie.setMaxAge(1809);
                    cookie.setPath(request.getContextPath());
                    //将Cookie对象发送给浏览器
                    response.addCookie(cookie);
                }

            }
        }
        return ServerResponse.success();
    }


    //在当前时间上加一天
    public static Date getNextDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, +1);//+1今天的时间加一天
        date = calendar.getTime();
        return date;
    }

    //密码错误判断
    private UserInfo pwdError(UserInfo userMy) {
        //当密码密码错误时，错误次
        // 数加一
        userMy.setLoginErrorCount(userMy.getLoginErrorCount()+1);
        //判断是否超过三次，超过了则把用户状态修改锁定
        if (userMy.getLoginErrorCount()>=3){
            userMy.setUserStauts(SystemConstants.USER_STATUS);//把用户锁定
        }
        userMy.setLoginErrorTime(DateUtils.getDateNow());
        return userMy;
    }


    //    修改错误次数，登录时间
    private UserInfo upLoginErrorLoginTime(UserInfo userMy) {
        userMy.setLoginErrorTime(userMy.getLoginErrorTime());
        userMy.setUserStauts(userMy.getUserStauts());
        userMy.setLoginErrorCount(0);
        //登陆次数
        if(userMy.getLoginCount()==0){
            userMy.setLoginCount(0+1);

        }else {
            userMy.setLoginCount( userMy.getLoginCount()+1);
        }
        userMy.setLoginTime(DateUtils.getDateNow());//赋值当前时间
        return userMy;
    }

    /**
     * 登录成功后跳转页面
     * @return
     */
    @RequestMapping("findUserIndex")
    public String findUserIndex(){
        return "index";
    }

    @RequestMapping("uploadFile")
    @ResponseBody
    public Map uploadFile(HttpServletRequest req){
        Map map = new HashMap();
        //将reques转换
        MultipartHttpServletRequest request = (MultipartHttpServletRequest)req;
        MultipartFile files = request.getFile("file");
        //如果没有上传图片那就滚回去上传
        if (files.getOriginalFilename()==""){
            map.put("code",500);
            return map;
        }
        //获取绝对路径
        String path = req.getContextPath() + FtpZhuanYong.IMG_PATHs;
        //获取文件名称；
        String fileMultipartFileName =  files.getOriginalFilename();
        //获取文件的后缀
        String substring = fileMultipartFileName.substring(fileMultipartFileName.lastIndexOf("."));
        //拼接名称：uuid防止文件重名；
        String fileName = UUID.randomUUID().toString()+substring;

        //创建file:File  file;
        File file= new File(path);
        //如果文件不存在就创建
        FileUtil.addFile(file);
        File tFile = new File(path,fileName);
        String url=null;
        try {
            //上传本地以及OSS上
            addUpload(files, path, tFile,fileName);
            //获取url的图片名
            String urlName = fileName.substring(fileName.lastIndexOf("\\")+1,fileName.length());
            //获取url
             url ="https://"+SystemConstants.BACKET_NAME+"."+SystemConstants.ENDPOINT+File.separator+SystemConstants.FOLDER+urlName;
            System.out.println(url);

        } catch (IOException e) {
            e.printStackTrace();
            map.put("code",-1);
            return map;

        }
        //上传成功后返回上传成功
        map.put("code",200);
        map.put("fileName",url);
        return map;
    }


    /**
     * 上传到本地以及OSS 删除本地
     * @param files
     * @param path
     * @param tFile
     * @param
     * @throws IOException
     */
    private void addUpload(MultipartFile files, String path, File tFile, String fileNamea) throws IOException {
        files.transferTo(tFile);
        //初始化Ossclient
        OSSClient ossClient =OssUtils.getOSSClient();
        String fileNames = path+fileNamea;
        String [] filess = fileNames.split(",");
        for (String fileName : filess) {
            //找到文件
            File file1 = new File(fileName);
            String md5Key = OssUtils.uploadObject2OSS(ossClient,file1,SystemConstants.BACKET_NAME,SystemConstants.FOLDER);

            System.out.println(md5Key);
            
        }
        tFile.delete();
    }

    public static void main(String[] args) {
        //初始化Ossclient
        OSSClient ossClient =OssUtils.getOSSClient();
        //上传的文件
        String files = "D:\\图片\\c12.jpg";
        String [] file = files.split(",");
        for (String fileName : file) {
//            System.out.println("fileName:"+fileName);
            //找到文件
            File file1 = new File(fileName);
//            System.out.println(file1);
            String md5Key = OssUtils.uploadObject2OSS(ossClient,file1,SystemConstants.BACKET_NAME,SystemConstants.FOLDER);
        }
        System.out.println("gfhgd");
    }


}

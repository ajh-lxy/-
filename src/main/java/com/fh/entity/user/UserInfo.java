package com.fh.entity.user;

import com.fh.util.PageUtil;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class UserInfo extends PageUtil implements Serializable {
    private static final long serialVersionUID = 8104041264138776016L;
    private String id;
    private String userName;//用户名
    private String userPwd;//密码
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date insertTime;//录入时间
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updateTime;//修改时间

    //用户头像
    private String imges;
    //验证码
    private String imgCode;

    //登录次数
    private int loginCount;
    //本次登录时间
    private Date loginTime;
    //上次登录时间
    private Date topLoginTime;
    //登录密码错误次数
    private Integer loginErrorCount;
    //登录密码错误时间
    private Date loginErrorTime;

    //用户状态  1正常  2锁定
    private Integer userStauts;


    //录入时间区间
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date minInsertTime;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date maxInsertTime;

    //修改时间区间
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date minUpdateTime;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date maxUpdateTime;


    public Date getTopLoginTime() {
        return topLoginTime;
    }

    public void setTopLoginTime(Date topLoginTime) {
        this.topLoginTime = topLoginTime;
    }

    public int getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(int loginCount) {
        this.loginCount = loginCount;
    }

    public Date getLoginErrorTime() {
        return loginErrorTime;
    }

    public void setLoginErrorTime(Date loginErrorTime) {
        this.loginErrorTime = loginErrorTime;
    }

    public Date getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Date loginTime) {
        this.loginTime = loginTime;
    }

    public Integer getLoginErrorCount() {
        return loginErrorCount;
    }

    public void setLoginErrorCount(Integer loginErrorCount) {
        this.loginErrorCount = loginErrorCount;
    }

    public Integer getUserStauts() {
        return userStauts;
    }

    public void setUserStauts(Integer userStauts) {
        this.userStauts = userStauts;
    }

    public String getImges() {
        return imges;
    }

    public void setImges(String imges) {
        this.imges = imges;
    }

    public String getImgCode() {
        return imgCode;
    }

    public void setImgCode(String imgCode) {
        this.imgCode = imgCode;
    }





    public Date getMinInsertTime() {
        return minInsertTime;
    }

    public void setMinInsertTime(Date minInsertTime) {
        this.minInsertTime = minInsertTime;
    }

    public Date getMaxInsertTime() {
        return maxInsertTime;
    }

    public void setMaxInsertTime(Date maxInsertTime) {
        this.maxInsertTime = maxInsertTime;
    }

    public Date getMinUpdateTime() {
        return minUpdateTime;
    }

    public void setMinUpdateTime(Date minUpdateTime) {
        this.minUpdateTime = minUpdateTime;
    }

    public Date getMaxUpdateTime() {
        return maxUpdateTime;
    }

    public void setMaxUpdateTime(Date maxUpdateTime) {
        this.maxUpdateTime = maxUpdateTime;
    }

    public Date getInsertTime() {
        return insertTime;
    }

    public void setInsertTime(Date insertTime) {
        this.insertTime = insertTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }
}

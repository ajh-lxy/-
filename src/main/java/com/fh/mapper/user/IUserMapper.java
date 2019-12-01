package com.fh.mapper.user;

import com.fh.entity.user.UserInfo;

public interface IUserMapper {

    /**
     * 登录
     * @param userInfo
     * @return
     */
    UserInfo findUserNameList(UserInfo userInfo);

    /**
     * 修改用户的状态或者错误次数
     * @param userMy
     */
    void updateLogin(UserInfo userMy);

    /**
     * 定时解锁用户的状态
     * @param userInfo
     */
    void updateLoginJob(UserInfo userInfo);
}

package com.fh.service.user;

import com.fh.entity.user.UserInfo;
import com.fh.mapper.user.IUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class IUserServiceImpl implements IUserService {
    @Autowired
    private IUserMapper userMapper;

    /**
     * 登录
     * @param userInfo
     * @return
     */
    public UserInfo findUserNameList(UserInfo userInfo) {
        return userMapper.findUserNameList(userInfo);
    }

    /**
     *修改用户的状态或者错误次数
     * @param userMy
     */
    public void updateLogin(UserInfo userMy) {
        userMapper.updateLogin(userMy);
    }

    /**
     * 定时解锁用户状态
     * @param userInfo
     */
    public void updateLoginJob(UserInfo userInfo) {
        userMapper.updateLoginJob(userInfo);
    }
}

package com.fh.task;

import com.fh.controller.common.SystemConstants;
import com.fh.entity.user.UserInfo;
import com.fh.service.user.IUserService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
//@Service  也可以
public class TaskCool {
    @Resource(name = "userService")
    private IUserService userService;

    /**
     * 测试定时器
     */
    public void testJob() {
        System.out.println("测试定时器,尕尕");
    }


    /**
     * 定时解除用户的锁定状态
     */
    public void updateLoginJob(){
        System.out.println("尕尕");
        UserInfo userInfo = new UserInfo();
        userInfo.setUserStauts(SystemConstants.STATUS_SUCCESS);
        userInfo.setLoginErrorCount(0);
        userService.updateLoginJob(userInfo);

    }

}

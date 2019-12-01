package com.fh.controller.common;

public enum ResponseEnum {
    USERNAME_PWD_IMGCODE_ERROR(100,"账号密码或者验证码不能为空"),
    USERNAME_ERROR(101,"账号不存在"),
    PWD_ERROR(102,"密码错误"),
    IMGCODE_ERROR(103,"验证码错误"),
    ERROR(-1,"失败"),
    LOGINCOUNT_ERROR(105,"你的账号由于连续三次密码错误，已锁定，请好自为之"),
    SUCCESS(200,"成功");
    private int code;
    private String msg;

    public int getCode() {
        return code;
    }
    public String getMsg() {
        return msg;
    }

    /**
     * <pre>创建一个新的实例 ResponseEnum.
     * @param code
     * @param msg</pre>
     */
    private ResponseEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}

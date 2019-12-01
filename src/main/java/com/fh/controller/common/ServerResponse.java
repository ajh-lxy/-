package com.fh.controller.common;

import java.io.Serializable;

public class ServerResponse implements Serializable {
    private static final long serialVersionUID = -1041829807315674141L;
    private int code;
    private String msg;
    private Object data;

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    public Object getData() {
        return data;
    }

    public ServerResponse() {
        super();
    }

    private ServerResponse(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    //成功调
    public static ServerResponse success(){
        return new ServerResponse(ResponseEnum.SUCCESS.getCode(),ResponseEnum.SUCCESS.getMsg(),null);
    }
    //成功带值的调
    public static ServerResponse success(Object data){
        return new ServerResponse(ResponseEnum.SUCCESS.getCode(),ResponseEnum.SUCCESS.getMsg(),data);
    }
    //失败调
    public static ServerResponse error(){
        return new ServerResponse(ResponseEnum.ERROR.getCode(),ResponseEnum.ERROR.getMsg(),null);
    }
    //判断逻辑调
    public static ServerResponse error(ResponseEnum responseEnum){
        return new ServerResponse(responseEnum.getCode(),responseEnum.getMsg(),null);
    }
}

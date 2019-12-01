package com.fh.controller.user;

import com.fh.util.DateUtils;

import java.util.Calendar;
import java.util.Date;

public class Aa {


    public static void main(String[] args) {
        Date dateNow = DateUtils.getDateNow();//新建此时的的系统时间

        System.out.println(dateNow);
        System.out.println(getNextDay(dateNow));// 返回明天的时间

    }

    public static Date getNextDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, +1);//+1今天的时间加一天
        date = calendar.getTime();
        return date;
    }
}

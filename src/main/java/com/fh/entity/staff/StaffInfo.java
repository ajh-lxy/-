package com.fh.entity.staff;

import com.fh.entity.zree.SectionInfo;
import com.fh.util.PageUtil;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class StaffInfo extends PageUtil implements Serializable {
    private static final long serialVersionUID = -3807352121845900088L;
    private String id;
    private String staffName;
    private Integer staffSex;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date insertTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;


//    录入时间区间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minInsertTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxInsertTime;
//修改时间区间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minUpdateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxUpdateTime;


    //头像
    private String imgUrl;
    //老头像
    private String oldImgUrl;
    //部门
    private SectionInfo sectionInfo;

    public SectionInfo getSectionInfo() {
        return sectionInfo;
    }

    public void setSectionInfo(SectionInfo sectionInfo) {
        this.sectionInfo = sectionInfo;
    }

    public String getOldImgUrl() {
        return oldImgUrl;
    }

    public void setOldImgUrl(String oldImgUrl) {
        this.oldImgUrl = oldImgUrl;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public Integer getStaffSex() {
        return staffSex;
    }

    public void setStaffSex(Integer staffSex) {
        this.staffSex = staffSex;
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
}

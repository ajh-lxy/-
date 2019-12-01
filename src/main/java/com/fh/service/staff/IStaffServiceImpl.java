package com.fh.service.staff;

import com.fh.entity.staff.StaffInfo;
import com.fh.mapper.staff.IStaffMapper;
import com.fh.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service("staffService")
public class IStaffServiceImpl implements IStaffService {
    @Autowired
    private IStaffMapper staffMapper;

    /**
     * 获取总条数
     * @param staffInfo
     * @return
     */
    public long getCount(StaffInfo staffInfo) {
        long count = staffMapper.getCount(staffInfo);
        return count;
    }

    /**
     * 查询员工信息
     * @param staffInfo
     * @return
     */
    public List<StaffInfo> querySatffList(StaffInfo staffInfo) {
        List<StaffInfo> staffInfoList = staffMapper.queryStaffList(staffInfo);
        return staffInfoList;
    }

    /**
     * 删除员工
     * @param id
     */
    public void deleteStaff(String id) {
        staffMapper.deleteStaff(id);
    }

    /**
     * 添加员工
     * @param staffInfo
     */
    public void addStaff(StaffInfo staffInfo) {
        staffMapper.addStaff(staffInfo);
    }

    /**
     * 回显
     * @param id
     * @return
     */
    public StaffInfo toUpdateStaff(String id) {

        StaffInfo staffInfo = staffMapper.toUpdateStaff(id);
        return staffInfo;
    }

    /**
     * 修改
     * @param staffInfo
     */

    public void updateStaff(StaffInfo staffInfo) {
        //如果没有上传新的头像那就给上原来的头像
        if(staffInfo.getImgUrl()==null || "".equals(staffInfo.getImgUrl())){
            staffInfo.setImgUrl(staffInfo.getOldImgUrl());
        }
        staffMapper.updateStaff(staffInfo);
    }

    /**
     * 获取所有信息
     * @return
     */
    public List<StaffInfo> queryDataTables() {
        return staffMapper.queryDataTables();
    }
}

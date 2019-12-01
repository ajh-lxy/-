package com.fh.mapper.staff;

import com.fh.entity.staff.StaffInfo;

import java.util.List;

public interface IStaffMapper {
    /**
     * 获取总条数
     * @param staffInfo
     * @return
     */
    long getCount(StaffInfo staffInfo);

    /**
     * 查询员工信息
     * @param staffInfo
     * @return
     */
    List<StaffInfo> queryStaffList(StaffInfo staffInfo);

    /**
     * 删除员工
     * @param id
     */
    void deleteStaff(String id);

    /**
     * 添加员工
     * @param staffInfo
     */
    void addStaff(StaffInfo staffInfo);

    /**
     * 回显
     * @param id
     * @return
     */
    StaffInfo toUpdateStaff(String id);

    /**
     * 修改
     * @param staffInfo
     */
    void updateStaff(StaffInfo staffInfo);

    /**
     * 获取所有信息
     * @return
     */
    List<StaffInfo> queryDataTables();
}

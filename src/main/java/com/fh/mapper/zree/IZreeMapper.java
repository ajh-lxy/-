package com.fh.mapper.zree;

import com.fh.entity.zree.SectionInfo;

import java.util.List;

public interface IZreeMapper {
    /**
     * 查询部门全部数据
     * @return
     */
    List<SectionInfo> findQueryZreeList();

    /**
     * 查询部门名称
     * @param id
     * @return
     */
    List<SectionInfo> queryByIdList(String id);
}

package com.fh.service.zree;

import com.fh.entity.zree.SectionInfo;

import java.util.List;

public interface IZreeService {
    /**
     * 查询部门所有数据
     * @return
     */
    List<SectionInfo> findQueryZreeList();

    /**
     *
     * 查询部门名称
     * @param id
     * @return
     */
    List<SectionInfo> queryByIdList(String id);
}

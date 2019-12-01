package com.fh.service.zree;

import com.fh.entity.zree.SectionInfo;
import com.fh.mapper.zree.IZreeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IZreeServiceImpl implements IZreeService {

    @Autowired
    private IZreeMapper zreeMapper;


    /**
     * 查询部门的所有数据
     * @return
     */
    public List<SectionInfo> findQueryZreeList() {
        List<SectionInfo> queryZreeList = zreeMapper.findQueryZreeList();
        return queryZreeList;
    }

    /**
     * 查询部门名称
     * @param id
     * @return
     */
    @Override
    public List<SectionInfo> queryByIdList(String id) {

        List<SectionInfo> sectionInfoList = zreeMapper.queryByIdList(id);
        return sectionInfoList;
    }
}

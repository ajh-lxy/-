package com.fh.controller.zree;


import com.fh.entity.zree.SectionInfo;
import com.fh.service.zree.IZreeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("zree/")
public class ZreeController {

    @Resource
    private IZreeService zreeService;

    /**
     *查询部门名称
     * @param id
     * @return
     */
    @RequestMapping("queryByidList")
    @ResponseBody
        public Map queryByidList(String id){
            Map map = new HashMap();
            List<SectionInfo> sectionInfoList = zreeService.queryByIdList(id);
            map.put("data",sectionInfoList);
            return map;
    }




    /**
     * zree
     * @return
     */
    @RequestMapping("getTreeList")
    @ResponseBody
    public List<Map<String,Object>> findSectionInfo(){
        //创造调用递归方法需要的参数
        List<SectionInfo> list = null;
        SectionInfo sectionInfo = null;
        List<Map<String,Object>> secList = null;
        return getTreeList(sectionInfo,secList,list);
    }




    /**
     * zree逻辑  递归
     * @param sectionInfo
     * @param listmap
     * @param list
     * @return
     */
    public List<Map<String,Object>> getTreeList(SectionInfo sectionInfo,List<Map<String, Object>> listmap,List<SectionInfo> list) {
        //null
        if (listmap==null || list==null){
            //查询出来所有部门集合放进list集合
            list = zreeService.findQueryZreeList();
            //创建一个模型来存放最后的数据类型
            listmap = new ArrayList<Map<String, Object>>();
            //循环查询出来的全部数据
            for (SectionInfo info : list) {
                //这里用来判断是否是父节点
                //父节点的pId一般来说都是null或者没有数值
                if (info.getpId().equals("0")){
                    //创建一个map来放父节点的值
                    Map<String,Object> map = new HashMap<String, Object>();
                    //text 这个是前台用来展示的名字(key)
                    map.put("id",info.getId());
                    map.put("text",info.getName());
                    //将父节点存入我们刚才创建的的模型
                    listmap.add(map);
                }
            }
            //递归的循环调用
            getTreeList(sectionInfo,listmap,list);
            //查询是否有父节点，如果有父节点就查询父节点的子节点
        }else if (listmap.size()>0 && list.size()>0){
            //依次循环
            for (Map<String, Object> stringObjectMap : listmap) {
                //创建子节点的list  MAP 集合
                List<Map<String,Object>> childlist = new ArrayList<Map<String, Object>>();
                //循环全部数据 找到父节点和子节点
                for (SectionInfo info : list) {

                    //判断这个数据的pId是否与相等，，如果相等就是该父节点的字节点
                    if(stringObjectMap.get("id").equals(info.getpId())){
                        //创建一个Map 来展示子节点
                        Map<String,Object> objectMap = new HashMap<String,Object>();
                        //id值
                        objectMap.put("id",info.getId());
                        //子节点展示的值
                        objectMap.put("text",info.getName());
                        //将子节点的map 放入list集合里
                        childlist.add(objectMap);
                    }

                }
                    stringObjectMap.put("nodes",childlist);

                    //继续循环来得全部父节点和子节点
                    getTreeList(sectionInfo,childlist,list);

            }
        }

        return listmap;
    }




}

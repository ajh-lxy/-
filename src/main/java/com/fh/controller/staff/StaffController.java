package com.fh.controller.staff;

import com.fh.controller.common.SystemConstants;
import com.fh.entity.staff.StaffInfo;
import com.fh.service.staff.IStaffService;
import com.fh.util.FTPUtil;
import com.fh.util.FtpZhuanYong;
import com.google.common.collect.Lists;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("sta/")
public class StaffController {
    @Resource(name = "staffService")
    private IStaffService staffService;


    /**
     * 查询员工信息
     * @return
     */
    @RequestMapping("queryStaffList")
    public String queryStaffList(StaffInfo staffInfo, Integer flag, ModelMap map){
        //获取总条数
        long count = staffService.getCount(staffInfo);
        //设置总条数
        staffInfo.setTotalCount(count);
        //计算分页信息
        staffInfo.calculatePage();
        //获取分页列表
        List<StaffInfo> staffInfoList = staffService.querySatffList(staffInfo);
        map.put("staffInfoList",staffInfoList);
        map.put("page",staffInfo);
        if(flag==null){
            return "staff/staffList";
        }
        return "staff/staffPage";
    }


    /**
     * 调转到data 页面
     */

    @RequestMapping("toQueryDataTables")
    public String toQueryDataTables(){
        return "staff/dataTables";
    }
    /**
     * 获取所有信息
     * @param staffInfo
     * @return
     */
    @RequestMapping("queryDataTables")
    @ResponseBody
    public Map queryDataTables(StaffInfo staffInfo){
        HashMap map = new HashMap();
        //获取总条数
        long count = staffService.getCount(staffInfo);
        //获取所有信息
        List<StaffInfo> staffInfoList = staffService.queryDataTables();

        map.put("draw", UUID.randomUUID().toString());//给本次数据容器一个随机id
        map.put("recordsTotal", count);// 设置总条数
        map.put("recordsFiltered", count);// 设置过滤后的总条数
        map.put("data", staffInfoList);
        return map;
    }




    /**
     * 删除员工
     * @param id
     * @return
     */

    @RequestMapping("deleteStaff")
    @ResponseBody
    public Map deleteStaff(String id){
        HashMap map = new HashMap();
        try {
            staffService.deleteStaff(id);
            map.put("code",200);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 跳转到添加页面
     * @return
     */
    @RequestMapping("toAddStaff")

    public String toAddStaff(){
        return "staff/addStaff";
    }

    /**
     * 添加员工
     * @return
     */
    @RequestMapping("addStaff")
    @ResponseBody
    public void addStaff(StaffInfo staffInfo){
        staffService.addStaff(staffInfo);
    }

    /**
     * 回显
     * @param id
     * @return
     */
    @RequestMapping("toUpdateStaff")
    @ResponseBody
    public Map toUpdateStaff(String id){
        Map map= new HashMap();
        StaffInfo staffInfo = staffService.toUpdateStaff(id);
        map.put("data",staffInfo);
        return map;
    }


    /**
     * 修改
     * @return
     */
    @RequestMapping("updateStaff")
    @ResponseBody
    public void updateStaff(StaffInfo staffInfo){
        staffService.updateStaff(staffInfo);
    }

    /** 上出图片到ftp*/
    @RequestMapping("uploadImg")
    @ResponseBody
    public JSONObject uploadImg(@RequestParam("empImg") MultipartFile img , HttpServletRequest req){
        //获取绝对路径
        String path = req.getContextPath() + FtpZhuanYong.IMG_PATH;

        //获取文件名称；
        String fileMultipartFileName =  img.getOriginalFilename();
        //获取文件的后缀
        String substring = fileMultipartFileName.substring(fileMultipartFileName.lastIndexOf("."));
        //拼接名称：uuid防止文件重名；
        String fileName = UUID.randomUUID().toString()+substring;
        //创建file:File  file;
        File file= new File(path);
        if(!file.exists()){
            //如果没有，就创建文件
            file.mkdirs();
            //修改tomcat上的文件夹权限
            file.setWritable(true);
        }
        File tFile = new File(path,fileName);
        boolean uploadFile = false;
        //将文件上传到
        try {
            img.transferTo(tFile);
            //上传到ftp
            uploadFile = FTPUtil.uploadFile(Lists.<File>newArrayList(tFile));
            //删除本地的文件
            tFile.delete();
        } catch (IOException e) {
            e.printStackTrace();
        }
        /*JSONObject joj = new JSONObject();
        joj.put("data", fileName);*/
        Map<String,String> map = new HashMap<String,String>();
        map.put("data",fileName);
        List<Map<String,String>> list = new ArrayList<Map<String,String>>();
        list.add(map);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("fileName","http://"+FtpZhuanYong.FTP_ID+"/"+fileName);

        return  jsonObject;

    }

}

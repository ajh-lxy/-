 <%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/3/11
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-3.3.1.min.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/My97DatePicker/WdatePicker.js"></script>
 <link  rel="stylesheet" href="<%=request.getContextPath()%>/My97DatePicker/skin/WdatePicker.css"/>
    <%--添加弹框--%>
 <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
 <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-ui"></script>
 <script type="text/javascript" src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/bootstrap.min.js"></script>
 <link href="//cdn.staticfile.org/twitter-bootstrap/3.0.1/css/bootstrap.min.css" rel="stylesheet">
<%--添加验证--%>
 <script type="text/javascript" src="<%=request.getContextPath()%>/js/validate/jquery.validate.min.js"></script>


 <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script src="https://cdn.bootcss.com/bootbox.js/4.4.0/bootbox.js"></script>
 <script src="https://cdn.bootcss.com/angular.js/1.6.9/angular.js"></script>


 <html>
<head>
    <title>员工展示</title>
</head>
<body>

<form class="cmxform" >
    <table>
        <tr>
            <td>员工姓名:</td>
            <td><input type="text" name="staffName"  id="staffName"/></td>
        </tr>
        <tr>
            <td>员工性别:</td>
            <td><input type="radio" value="1" name="staffSex1"/>男<input type="radio" value="2" name="staffSex1"/>女</td>
        </tr>
        <tr>
            <td>录入时间:</td>
            <td><input type="text" id="minInsertTime" onclick="WdatePicker({skin:'YcloudRed'})"/>----<input type="text" id="maxInsertTime" onclick="WdatePicker({skin:'YcloudRed'})"/></td>
        </tr>
        <tr>
            <td>修改时间:</td>
            <td><input type="text" id="minUpdateTime" onclick="WdatePicker({skin:'YcloudRed'})"/>----<input type="text" id="maxUpdateTime" onclick="WdatePicker({skin:'YcloudRed'})"/></td>
        </tr>
        <tr>
            <td><input type="button" class="btn btn-inverse" value="查询" onclick="queryStaffList(1)"></td>
            <td><input type="reset"  class="btn btn-inverse" value="清空条件"/></td>
        </tr>
    </table>
</form>
<div class="box">
    &nbsp;&nbsp;&nbsp; <button type="button" class="btn btn-success"  onclick="addEmpl()">添加</button>
</div>
<%--员工展示div--%>
<div id="staffDivId">
    <jsp:include page="staffPage.jsp"/>
</div>

</body>
<script type="text/javascript">
    function getPageIndex(pageIndex) {
        if (pageIndex>=${page.pageCount}){
            alert("已经最后一页了")
        }else {
            pageIndex++;
            <%--location.href="<%=request.getContextPath()%>/sta/queryStaffList.jhtml?pageIndex="+pageIndex;--%>
            queryStaffList(pageIndex);
        }
    }
    function getPageIndex1(pageIndex) {
        if (pageIndex<=1){
            alert("已经第一页了")
        }else {
            pageIndex--;
            <%--location.href="<%=request.getContextPath()%>/sta/queryStaffList.jhtml?pageIndex="+pageIndex;--%>
            queryStaffList(pageIndex);
        }
    }
    <%--条件分页查询--%>
    function queryStaffList(page) {
        //条件
        var v_staffName = $("#staffName").val();
        var v_staffSex1 = $("input[name='staffSex1']:checked").val();
        var v_minInsertTime = $("#minInsertTime").val();
        var v_maxInsertTime = $("#maxInsertTime").val();
        var v_minUpdateTime = $("#minUpdateTime").val();
        var v_maxUpdateTime = $("#maxUpdateTime").val();
        $.ajax({
           url:"<%=request.getContextPath()%>/sta/queryStaffList.jhtml",
           data:{
               "staffName":v_staffName,
               "staffSex":v_staffSex1,
               "minInsertTime":v_minInsertTime,
               "maxInsertTime":v_maxInsertTime,
               "minUpdateTime":v_minUpdateTime,
               "maxUpdateTime":v_maxUpdateTime,
               "pageIndex":page,
               "flag":1,
           },
           type:"post",
           success:function (result) {
                $("#staffDivId").html(result);
           },
        });
    }
//    当前页
    function turnPage(pageIndex) {
        queryStaffList(pageIndex);
    }
    //删除员工
    function deleteStaff(id) {
        if (confirm("你确认要删除吗？")){
            $.ajax({
                url:"<%=request.getContextPath()%>/sta/deleteStaff.jhtml",
                data:{
                    "id":id
                }  ,
                type:"post",
                success:function (data) {
                    if (data.code==200){
                        alert("删除成功");
                        queryStaffList(1);
                    }
                }
            });
        }
    }

</script>
<script type="text/html" id="addHtml">
    <form  id="signupForm">
        <table>
            <tr>
                <td>员工姓名:<input type="hidden" name="id"/></td>
                <td><input type="text" name="staffName1"/></td>
            </tr>
            <tr>
                <td>员工性别:</td>
                <td><input type="radio" value="1" name="staffSex11"/>男<input type="radio" value="2" name="staffSex11"/>女</td>
            </tr>
        </table>
    </form>
</script>
<script>

    <%--添加弹框--%>
    function  addEmpl() {


        $.validator.setDefaults({
            submitHandler: function() {
                alert("提交事件!");
                submit;
            }
        });

        $().ready(function() {
// 在键盘按下并释放及提交后验证提交表单
            $("#signupForm").validate({
                rules: {    //验证规则

                    staffName1: {
                        required: true,
                        minlength: 2,
                        maxlength:10
                    },
                    staffSex11: {
                        required: true,
                        max:100,
                        digits:true,   //必须输入整数
                        number:true //输入必须是数字
                    },


                    agree: "required"
                },
                messages: {// 错误信息，

                    staffName1: {
                        required: "请输入姓名",
                        minlength: "姓名至少由两个字字符组成",
                        maxlength:"最多十个"
                    },
                    staffSex11: {
                        required: "请输入年龄",
                        max:"年龄不能大于100",
                        digits:"必须为整数",   //必须输入整数
                        number:"请输入正确的数字"
                    },


                }
            });
        });

        bootbox.dialog({
            size: "large",
            title: "添加员工信息",
            message: $("#addHtml").html() ,
            buttons: {
                cancel: {
                    label: "取消", // 自定义按钮名字
                    className: "btn-danger",  // 自定义类名
                    callback: function () {  // 自定义回调函数
                        // console.log("你点击了取消按钮")
                    }
                },
                ok: {
                    label: "保存",
                    className: "btn-danger",
                    callback: function () {
                        var  staffName1=$("[name='staffName1']").val();
                        var  staffSex11=$("[name='staffSex11']:checked").val();
                        $.ajax({
                            url:"<%=request.getContextPath()%>/sta/addStaff.jhtml",
                            type:"post",
                            data:{
                                "staffName":staffName1,"staffSex":staffSex11
                            },
                            datatype: "json",
                            success:function(){
                                queryStaffList(1);
                            } ,
                            error:function(){

                            }
                        })
                    }
                },

            }
        })
    }
    //修改
    function  toUpdateStaff(id) {
        bootbox.dialog({
            size: "large",
            title: "修改员工信息",
            message: $("#addHtml").html() ,
            buttons: {
                cancel: {
                    label: "取消", // 自定义按钮名字
                    className: "btn-danger",  // 自定义类名
                    callback: function () {  // 自定义回调函数
                        // console.log("你点击了取消按钮")
                    }
                },

                ok: {
                    label: "保存",
                    className: "btn-danger",
                    callback: function () {
                        var  v_id=$("[name='id']").val();
                        var  v_staffName=$("[name='staffName1']").val();
                        var  v_staffSex1=$("input[name='staffSex11']:checked").val();
                        $.ajax({
                            url:"<%=request.getContextPath()%>/sta/updateStaff.jhtml",
                            type:"post",
                            data:{
                                "staffName":v_staffName,
                                "staffSex":v_staffSex1,
                                "id":v_id
                            },
                            datatype: "json",
                            success:function(res){
                                queryStaffList(1);
                            } ,
                            error:function(){

                            }
                        })
                    }
                },

            }
        })
        /**
         * 回现
         */
        $.ajax({
            url:"<%=request.getContextPath()%>/sta/toUpdateStaff.jhtml",
            type:"post",
            data:{
                "id":id
            },
            success:function (res) {
                var stsffInfo = res.data;
                $("[name='id']").val(stsffInfo.id)
                $("[name='staffName1']").val(stsffInfo.staffName)
                $("input[name=staffSex11][value="+stsffInfo.staffSex+"]").attr("checked",true);
            },
        });
    }
</script>
<script>

</script>
<style>
    .error{
        color:red;
    }
</style>
 </html>

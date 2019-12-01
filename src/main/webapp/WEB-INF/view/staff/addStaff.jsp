<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/3/11
  Time: 19:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-3.3.1.min.js"></script>
<%--添加验证--%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/validate/jquery.validate.min.js"></script>
<html>
<head>
    <title>添加员工</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/sta/addStaff.jhtml" id="signupForm">
    <table>
        <tr>
            <td>员工姓名:</td>
            <td><input type="text" name="staffName"/></td>
        </tr>
        <tr>
            <td>员工性别:</td>
            <td><input type="radio" value="1" name="staffSex"/>男<input type="radio" value="2" name="staffSex"/>女</td>
        </tr>
        <tr>
            <td><input type="submit" value="保存"/></td>
            <td><input type="reset" value="清空"/></td>
        </tr>
    </table>
</form>
</body>

<script>

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

                staffName: {
                    required: true,
                    minlength: 2,
                    maxlength:10
                },
                staffSex1: {
                    required: true,
                    max:100,
                    digits:true,   //必须输入整数
                    number:true //输入必须是数字
                },


                agree: "required"
            },
            messages: {// 错误信息，

                staffName: {
                    required: "请输入姓名",
                    minlength: "姓名至少由两个字字符组成",
                    maxlength:"最多十个"
                },
                staffSex1: {
                    required: "请输入年龄",
                    max:"年龄不能大于100",
                    digits:"必须为整数",   //必须输入整数
                    number:"请输入正确的数字"
                },


            }
        });
    });
</script>
<style>
    .error{
        color:red;
    }
</style>
</html>

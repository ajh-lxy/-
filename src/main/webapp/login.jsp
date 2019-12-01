<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/3/10
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-cookie-master/src/jquery.cookie.js"></script>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap/css/bootstrap.css">

<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap/css/bootstrap-treeview.css">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="<%=request.getContextPath()%>/js/bootstrap/jss/bootstrap.js"></script>
<html>
<head>
    <title>登录</title>
</head>
<body style="background:url(html/yemian/c16.jpg)">


<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <ul class="nav nav-tabs">
                <li class="active">
                    <a href="<%=request.getContextPath()%>/login.jsp">首页<%=request.getContextPath()%></a>
                </li>
                <li class="active">
                    <a href="<%=request.getContextPath()%>/content.jsp">详细信息</a>
                </li>
                <li class="dropdown pull-right">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle"><font
                            color="red">没有账号?点这里！！！</font><strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="<%=request.getContextPath()%>/user/toAddUser.jhtml">注册</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-4 column">
        </div>
        <div class="col-md-4 column">
            <form class="form-horizontal" role="form">
                <div class="form-group">
                    &nbsp;&nbsp;&nbsp;<span id="loginWarn"></span>
                    <label for="userName" class="col-sm-2 control-label"><font style="color: red">用户名:</font></label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="userName"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="userPassword" class="col-sm-2 control-label"><font style="color: red">密码:</font></label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="userPassword"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="checkCode" class="col-sm-2 control-label"><font style="color: red">验证码:</font></label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="checkCode"/>
                    </div>
                    &nbsp;&nbsp;&nbsp;&nbsp;<img alt="这是验证码" src="<%=request.getContextPath()%>/imgCode" id="img">
                    <a href="javascript:img()"><font color="red">刷新</font></a><br>

                </div>
            </form>
            <div>
                <label><font style="color: red"> 记住账号密码?</font>&nbsp;&nbsp;<input type="checkbox" id="rmbMe"/></label>
                <button type="button" class="btn btn-default btn-block btn-primary" onclick="userLogin()">登录</button>
            </div>

        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function(){
// 记住我取值
        if ($.cookie("rmbMe") == "true") {
            $("#rmbMe").attr("checked", true);
            $("#userName").val($.cookie("userName"));
            $("#userPassword").val($.cookie("userPassword"));
        }
    });

    // 记住用户名，默认不记住
    var checkFlg = false;
    // 记住用户名
    $("#rmbMe").click(function(){
        if (checkFlg) {
            $("#rmbMe").attr("checked", true);
        } else {
            $("#rmbMe").attr("checked", false);
        }
        checkFlg = !checkFlg;
        alert(checkFlg)

    });

    // 保存用户名
    function setCookie() {
        if (checkFlg) {
            /* 账号 */
            var userName = $("#userName").val();
            /* 密码 */
            var userPassword = $("#userPassword").val();
            $.cookie("rmbMe", "true", { expires: 7 }); // 记住我勾选
            $.cookie("userName", userName, { expires: 7 }); // 存储一个带7天期限的 cookie
            $.cookie("userPassword", userPassword, { expires: 7 }); // 存储一个带7天期限的 cookie
        } else {
            $.cookie("rmbMe", "false", { expires: -1 }); // 删除 cookie
            $.cookie("userName", '', { expires: -1 });
            $.cookie("userPassword", '', { expires: -1 });
        }
    }


</script>

<script type="text/javascript">

    //刷新图片
    function img() {
        var t = new Date().getTime();
        document.getElementById("img").src = "<%=request.getContextPath()%>/imgCode?" + t;
    }

    /* 用户登录 */
    function userLogin() {
        setCookie();
        /* 账号 */
        var v_userName = $("#userName").val();
        /* 密码 */
        var v_useruserPassword = $("#userPassword").val();
        /*验证码*/
        var v_checkCode = $("#checkCode").val();
        $.ajax({
            url: "<%=request.getContextPath()%>/staUser/login.jhtml",
            data: {
                "userName": v_userName,
                "userPwd": v_useruserPassword,
                "imgCode": v_checkCode
            },
            type: "POST",
            success: function (data) {
                if (data.code == 200) {
                    $("#checkCode").val("");

                    location.href = "<%=request.getContextPath()%>/staUser/findUserIndex.jhtml";
                } else {

                    alert(data.msg)
                    // $("#loginWarn").html("<font color='red'>" + data.msg + "</font>");
                    location.href = "<%=request.getContextPath()%>/login.jsp";
                }
            },

        });
    }
</script>
</html>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.fh.entity.user.UserInfo" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/3/11
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-3.3.1.min.js"></script>
<html>
<head>
    <title>首页</title>
</head>
<script type="text/javascript">
    $(function(){
        now = new Date(),hour = now.getHours()
        if(hour < 6){$("#userinfo").html("凌晨好");}
        else if (hour < 9){$("#userinfo").html("早上好");}
        else if (hour < 12){$("#userinfo").html("上午好");}
        else if (hour < 14){$("#userinfo").html("中午好");}
        else if (hour < 17){$("#userinfo").html("下午好");}
        else if (hour < 19){$("#userinfo").html("傍晚好");}
        else if (hour < 22){$("#userinfo").html("晚上好");}
        else {$("#userinfo").html("夜里好");}
    });

</script>
<body>
<div>
    <% UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");%>
    <%SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");%>
    <b><%=userInfo.getUserName()%></b><b id="userinfo">早上好</b><b>，欢迎你使用员工管理系统。</b><i>你今天登录<b><%=userInfo.getLoginCount()%></b>了次,您上次登录的时间：<%=sdf.format(userInfo.getTopLoginTime())%></i>
</div>

<input type="button" value="查询员工列表" onclick="queryPageList()"/>
<input type="button" value="data Tables" onclick="queryDataTables()"/>
</body>
<script>
    function queryPageList() {
        location.href="<%=request.getContextPath()%>/sta/queryStaffList.jhtml";
    }
    function queryDataTables() {
        location.href="<%=request.getContextPath()%>/sta/toQueryDataTables.jhtml";
    }
</script>
</html>

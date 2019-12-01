<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/3/11
  Time: 19:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改员工</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/sta/updateStaff.jhtml">
    <table>
        <tr>
            <td>员工姓名:<input type="hidden" name="id" value="${staffInfo.id}"/></td>
            <td><input type="text" name="staffName" value="${staffInfo.staffName}"/></td>
        </tr>
        <tr>
            <td>员工性别:</td>
            <td><input type="radio" value="1" name="staffSex" ${staffInfo.staffSex=='1'?"checked":""}/>男<input type="radio" value="2" name="staffSex" ${staffInfo.staffSex=='2'?"checked":""}/>女</td>
        </tr>
        <tr>
            <td><input type="submit" value="保存"/></td>
            <td><input type="reset" value="清空"/></td>
        </tr>
    </table>
</form>
</body>
</html>

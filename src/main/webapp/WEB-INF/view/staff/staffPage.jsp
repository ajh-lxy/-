<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<c:if test="${!empty staffInfoList}">
<div class="container-fluid" style="margin-right: 12px;">
    <div class="row-fluid">
        <div class="span12">
            <table class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th>员工编号</th>
                    <th>员工名</th>
                    <th>员工性别</th>
                    <th>录入时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${staffInfoList}" var="staffInfoList">
                        <tr>
                            <td>${staffInfoList.id}</td>
                            <td>${staffInfoList.staffName}</td>
                            <td>${staffInfoList.staffSex=='1'?"男":"女"}</td>
                            <td><f:formatDate value="${staffInfoList.insertTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><f:formatDate value="${staffInfoList.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>
                                <%--<a href="javascript:deleteStaff('${staffInfoList.id}')">删除员工</a>--%>
                                <%--<a href="javascript:toUpdateStaff('${staffInfoList.id}')">修改员工</a>--%>
                                <button type="button" class="btn btn-danger"  onclick="deleteStaff('${staffInfoList.id}')">删除员工</button>
                                <button type="button" class="btn btn-info"  onclick="toUpdateStaff('${staffInfoList.id}')">修改员工</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div>
                    <%--<jsp:include page="/WEB-INF/common/ajaxpage.jsp"></jsp:include>--%>
                <ul class="pagination">
                    <li><a href="javascript:getPageIndex1('${page.pageIndex}')" >&laquo;</a></li>
                    <li><a >{当前为第${page.pageIndex}/${page.pageCount}页|共${page.totalCount}条}</a></li>

                    <li><a href="javascript:getPageIndex('${page.pageIndex}')">&raquo;</a></li>
                </ul>
            </div>
        </div>

    </div>
</div>

</c:if>
<c:if test="${empty staffInfoList}">
    <h2 align="center"><font color="red">对不起！没有相关的数据呦！！！</font></h2>
</c:if>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>分类列表</title>
	<link rel="stylesheet" type="text/css" href="adminjsps/admin/css/category/list.css">
	<link rel="stylesheet" type="text/css" href="css/css.css">
  </head>
  
  <body>
    <h2 style="text-align: center;">分类列表</h2>
	<table align="center" border="1" cellpadding="0" cellspacing="0">
		<c:if test="${sessionScope.admin.adminIdentity eq 'manager'}">
			<caption class="captionAddOneLevel">
				<a href="adminjsps/admin/category/add.jsp">添加一级分类</a>
			</caption>
		</c:if>
		<tr class="trTitle">
			<th>分类名称</th>
			<th>描述</th>
			<c:if test="${sessionScope.admin.adminIdentity eq 'manager'}">
				<th>操作</th>
			</c:if>
		</tr>
		<c:forEach items="${parents}" var="parent">
			<tr class="trOneLevel">
				<td width="200px;">${parent.cName}</td>
				<td>${parent.desc}</td>
				<c:if test="${sessionScope.admin.adminIdentity eq 'manager'}">
					<td width="200px;">
						<a href="adminCategory/addChildPre?pId=${parent.cId}">添加二级分类</a>
						<a href="adminCategory/editParentPre?cId=${parent.cId}">修改</a>
						<a onclick="return confirm('您是否真要删除该一级分类？')"
						href="adminCategory/deleteParent?cId=${parent.cId}">删除</a>
					</td>
				</c:if>
			</tr>
			<c:forEach items="${parent.children}" var="child">
				<tr class="trTwoLevel">
					<td>${child.cName}</td>
					<td>${child.desc}</td>
					<c:if test="${sessionScope.admin.adminIdentity eq 'manager'}">
						<td width="200px;" align="right">
							<a href="adminCategory/editChildPre?cId=${child.cId}">修改</a>
							<a onclick="return confirm('您是否真要删除该二级分类？')"
							href="adminCategory/deleteChild?cId=${child.cId}">删除</a>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>
</body>
</html>
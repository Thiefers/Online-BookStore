<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分类菜单栏</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		var categoryHtml = "";
		// 库存管理
		<c:if test="${op eq 'inventory'}">
			// alert("${op}");
			<c:forEach items="${parents}" var="parent">
				categoryHtml += "<ul style='list-style: none;' class='nav nav-list'>";
				categoryHtml += "<li>";
				categoryHtml += "<a href='#${parent.cId}' class='nav-header collapsed' data-toggle='collapse' style='text-decoration: none;'>${parent.cName}</a>";
				categoryHtml += "<ul id='${parent.cId}' class='nav nav-list collapse'>";
				<c:forEach items="${parent.children}" var="child">
					categoryHtml += "<li class='second-li ${child.pId}' role='presentation'><a target='inventoryBody' href='adminBook/findByCategory?choice=inventory&cId=${child.cId}'>${child.cName}</a></li>";
				</c:forEach>
				categoryHtml += "</ul>";
				categoryHtml += "</li>";
				categoryHtml += "</ul>";
			</c:forEach>
		</c:if>
		// 图书管理
		<c:if test="${empty op}">
			<c:forEach items="${parents}" var="parent">
				categoryHtml += "<ul style='list-style: none;' class='nav nav-list'>";
				categoryHtml += "<li>";
				categoryHtml += "<a href='#${parent.cId}' class='nav-header collapsed' data-toggle='collapse' style='text-decoration: none;'>${parent.cName}</a>";
				categoryHtml += "<ul id='${parent.cId}' class='nav nav-list collapse'>";
				<c:forEach items="${parent.children}" var="child">
					categoryHtml += "<li class='second-li ${child.pId}' role='presentation'><a target='bookBody' href='adminBook/findByCategory?choice=book&cId=${child.cId}'>${child.cName}</a></li>";
				</c:forEach>
				categoryHtml += "</ul>";
				categoryHtml += "</li>";
				categoryHtml += "</ul>";
			</c:forEach>
		</c:if>
		$("#parentDiv").html(categoryHtml);
	});
</script>
<style type="text/css">
	.second-li{
		padding-left: 10px;
	}
</style>
</head>
<body>
	<div id="parentDiv">
		<!--
		拿到一级分类
		遍历一级分类，给parentLi的id
			拿到二级分类，遍历
		-->
	</div>
</body>
</html>
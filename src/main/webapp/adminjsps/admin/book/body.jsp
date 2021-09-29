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
    <title>Book_Body</title>
    <link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
	<script src="jquery/jquery-3.5.1.min.js"></script>
	<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<style type="text/css">
		a:hover{text-decoration: none;}
	</style>
</head>
<body>
	<h1 align="center">图书管理</h1>
	<p align="center">
		<c:if test="${sessionScope.admin.adminIdentity eq 'manager'}">
			<a href="adminBook/addPre" style="margin: 20px; font-size: 20px;">
				<button class="btn btn-info btn-lg">
					<span style="color: #000;">添加图书</span>
				</button>
			</a>
		</c:if>
		<a href="adminjsps/admin/book/gj.jsp" style="margin: 20px; font-size: 20px;">
			<button class="btn btn-info btn-lg">
				<span style="color: #000;">高级搜索</span>
			</button>
		</a>
	</p>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<base href="<%=basePath%>" target="body">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>top</title>
    <link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
	<script src="jquery/jquery-3.5.1.min.js"></script>
	<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<style type="text/css">
		body {font-size: 10pt;}
		a:hover{text-decoration: none;}
		/* a:active{text-decoration: none;}
		a:visited{text-decoration: none;} */
		a:link {text-decoration: none;}
	</style>
  </head>
  
  <body style="background: rgb(78,78,78);color: #fff;">
	<h1 style="text-align: center; line-height: 30px;">融创书城后台管理</h1>
	<div style="line-height: 10px;">
		<c:if test="${empty sessionScope.admin}">
			<a target="_top" href="adminjsps/login.jsp">
				<button class="btn btn-sm btn-primary">
					<span>登录</span>
				</button>
			</a>
		</c:if>
		<c:if test="${not empty sessionScope.admin}">
			<c:if test="${sessionScope.admin.adminIdentity eq 'ceo'}">
				&nbsp;<span>BOSS：${sessionScope.admin.adminName}</span>
			</c:if>
			<c:if test="${sessionScope.admin.adminIdentity eq 'manager'}">
				&nbsp;<span>管理员：${sessionScope.admin.adminName }</span>
			</c:if>

			<a target="_top" href="adminjsps/login.jsp">
				<button class="btn btn-danger btn-xs">
					<span style="color: white;">退出</span>
				</button>
			</a>

			<span style="padding-left: 50px;">
				<a href="adminCategory/findAll">
					<button class="btn btn-success btn-xs">
						<span style="color: white;">分类管理</span>
					</button>
				</a>
				<a href="adminjsps/admin/book/main.jsp">
					<button class="btn btn-success btn-xs">
						<span style="color: white;">图书管理</span>
					</button>
				</a>
				<a href="adminOrder/findAll">
					<button class="btn btn-success btn-xs">
						<span style="color: white;">订单管理</span>
					</button>
				</a>
				<a href="adminjsps/admin/charts/order.jsp" target="body">
					<button class="btn btn-success btn-xs">
						<span style="color: white;">订单统计</span>
					</button>
				</a>
				<a href="adminjsps/admin/book/inventoryMain.jsp" target="body">
					<button class="btn btn-success btn-xs">
						<span style="color: white;">库存/上架/下架管理</span>
					</button>
				</a>
			</span>
		</c:if>
	</div>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息板</title>
<style type="text/css">
body {
	font-size: 10pt;
	color: #404040;
	font-family: SimSun;
}
.divBody {
	margin-left: 15%;
}
.divTitle {
	text-align: left;
	width: 900px;
	height: 25px;
	line-height: 25px;
	background-color: #efeae5;
	border: 5px solid #efeae5;
}
.divContent {
	width: 900px;
	height: 230px;
	border: 5px solid #efeae5;
	margin-right: 20px;
	margin-bottom: 20px;
}
.spanTitle {
	margin-top: 10px;
	margin-left: 10px;
	height: 25px;
	font-weight: 900;
}
a {
	text-decoration: none;
}
a:visited {
	color: #018BD3;
}
a:hover {
	color: #FF6600;
	text-decoration: underline;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${code eq 'success'}">
			<%--如果code是成功，它显示对号图片 --%>
			<c:set var="img" value="images/duihao.jpg"/>
			<c:set var="title" value="成功"/>
		</c:when>
		<c:when test="${code eq 'error'}">
			<%--如果code是失败，它显示错号图片 --%>
			<c:set var="img" value="images/cuohao.png"/>
			<c:set var="title" value="失败"/>
		</c:when>
	</c:choose>
	<div class="divBody">
		<div class="divTitle">
			<span class="spanTitle">${title}</span>
		</div>
		<div class="divContent">
			<div style="margin: 20px;">
				<img style="float: left; margin-right: 30px;" src="${img}" width="150"/>
				<span style="font-size: 30px; color: #c30; font-weight: 900;">${msg}</span>
				<br/><br/><br/><br/>
				<c:if test="${empty sessionScope.sessionUser }">
					<span style="margin-left: 50px;">
						<a href="jsps/user/login.jsp" target="_null">登录</a>
					</span>
				</c:if>
				<span style="margin-left: 50px;">
					<a href="index.jsp" target="_null">主页</a>
				</span>
				<c:if test="${status eq 4}">
					<span style="margin-left: 50px;">
						<a href="order/loadOrderByOid?oId=${oId}&evaluate=1" target="body">前往评价</a>
<%-- 						<a href="jsps/order/evaluate.jsp?oId=${oId}" target="body">前往评价</a> --%>
					</span>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>
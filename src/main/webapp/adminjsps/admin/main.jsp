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
    <title>融创后台</title>
	<link rel="stylesheet" type="text/css" href="adminjsps/admin/css/main.css">
  </head>
  <body>
	<table class="table" align="center" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" height="100px;">
				<iframe frameborder="0" src="adminjsps/admin/top.jsp" name="top"></iframe>
			</td>
		</tr>
		<tr>
			<td height="521px">
				<iframe frameborder="0" src="adminjsps/admin/body.jsp" name="body"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>

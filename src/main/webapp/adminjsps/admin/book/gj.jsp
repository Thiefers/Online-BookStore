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
    <title>boo_gj.jsp</title>
	<style type="text/css">
		table {
			color: #404040;
			font-size: 10pt;
		}
	</style>
</head>

<body>
	<form action="adminBook/findByCombination" method="get">
		<table align="center">
			<tr>
				<td>书名：</td>
				<td><input type="text" name="bName" /></td>
			</tr>
			<tr>
				<td>作者：</td>
				<td><input type="text" name="author" /></td>
			</tr>
			<tr>
				<td>出版社：</td>
				<td><input type="text" name="press" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="submit" value="搜　　索" />
					<input type="reset" value="重新填写" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
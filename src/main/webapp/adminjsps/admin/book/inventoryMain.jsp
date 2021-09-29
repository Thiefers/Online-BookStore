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
    <title>book_inventory_main.jsp</title>
	<link rel="stylesheet" type="text/css" href="adminjsps/admin/css/book/main.css">
  </head>
  <body>
	<table class="table" align="center" width="100%" height="100%"
		border="0">
		<tr style="height: 520px;">
			<td align="center" width="200px;">
				<iframe frameborder="0" src="adminBook/findAllCategory?op=inventory" name="left"></iframe>
			</td>
			<td>
				<iframe frameborder="0" src="adminjsps/admin/book/inventoryBody.jsp" name="inventoryBody"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
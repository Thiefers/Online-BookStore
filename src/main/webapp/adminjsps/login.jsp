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
    <title>管理员登录页面</title>
    <link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
	<script type="text/javascript" src="jquery/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function checkForm() {
			if(!$("#adminName").val()) {
				alert("管理员名称不能为空！");
				return false;
			}
			if(!$("#adminPwd").val()) {
				alert("管理员密码不能为空！");
				return false;
			}
			return true;
		}
	</script>
  </head>
  
  <body>
	<h1 align="center">管理员登录页面</h1>
	<hr />
	<p align="center" style="font-weight: 900; color: red">${msg}</p>
	<form action="admin/login" method="post" onsubmit="return checkForm()">
		<table align="center" class="table table-bordered" style="width: 330px;">
			<tr>
				<td align="right"><b>管理员账户：</b></td>
				<td>
					<input class="form-control" type="text" name="adminName" id="adminName" />
				</td>
			</tr>
			<tr>
				<td align="right"><b>密码：</b></td>
				<td>
					<input class="form-control" type="password" name="adminPwd" id="adminPwd" />
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input class="btn btn-primary" type="submit" value="进入后台" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

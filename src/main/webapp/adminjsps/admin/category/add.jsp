<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加分类</title>
<script type="text/javascript" src="jquery/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	function checkForm() {
		if (!$("#cName").val()) {
			alert("分类名不能为空！");
			return false;
		}
		if (!$("#desc").val()) {
			alert("分类描述不能为空！");
			return false;
		}
		return true;
	}
</script>
<style type="text/css">
body {
	background: rgb(254, 238, 189);
}
</style>
</head>

<body>
	<h3>添加1级分类</h3>
	<h1></h1>
	<p style="font-weight: 900; color: red">${msg }</p>
	<form action="adminCategory/addParent" method="post" onsubmit="return checkForm()">
		分类名称：<input type="text" name="cName" id="cName" /><br />
		分类描述：<textarea rows="5" cols="50" name="desc" id="desc"></textarea><br />
		<input type="submit" value="添加一级分类" />
		<input type="button" value="返回" onclick="history.go(-1)" />
	</form>
</body>
</html>

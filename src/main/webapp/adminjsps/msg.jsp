<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>错误提示页</title>
  </head>
	<style type="text/css">
		body {background: rgb(254,238,189);}
	</style>
  <body>
	<h2>${msg}</h2>
	<input type="button" value="返回" onclick="history.go(-1)" />
</body>
</html>

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
    <title>body</title>
  </head>
  <body style="margin: 0px;background: url(images/welcome.jpg);background-size: 100% 100%;background-repeat: no-repeat;">
    <!-- <img src="images/welcome.png" width="100%" height="100%"/> -->
    
    <div style="height: 500px;">
	    <h1 align="center">多读书，多看报，少吃零食多睡觉</h1>
    </div>
  </body>
</html>
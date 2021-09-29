<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线书城</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 轮播图 -->
	<div class="container-fluid">
		<div class="row">
			<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
					<li data-target="#carousel-example-generic" data-slide-to="1"></li>
					<li data-target="#carousel-example-generic" data-slide-to="2"></li>
				</ol>
				<div class="carousel-inner" role="listbox">
					<div class="item active">
						<img src="images/banner01.jpg" alt="it"
							style="width: 100%; height: 380px;">
					</div>
					<div class="item">
						<img src="images/banner02.jpg" alt="is"
							style="width: 100%; height: 380px;">
					</div>
					<div class="item">
						<img src="images/banner03.jpg" alt="gone"
							style="width: 100%; height: 380px;">
					</div>
				</div>
				<a class="left carousel-control" href="#carousel-example-generic"
					role="button" data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#carousel-example-generic"
					role="button" data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</div>
	<!-- 轮播图 -->
	<!-- 巨幕 -->
	<div class="container-fluid">
		<div class="row">
			<div class="jumbotron col-sm-12">
			  <h3>欢迎来到，融创书城</h1>
			  <p>遨游于书海，去享受此刻，去追寻内心的平和</p>
			</div>
		</div>
	</div>
	<!-- 巨幕 -->
</body>
</html>
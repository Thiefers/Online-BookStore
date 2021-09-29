<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 导航条 -->
<nav class="navbar navbar-default navbar-static-top">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">
				<span class="glyphicon glyphicon-book" aria-hidden="true"></span>
				BookStore
			</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active">
					<a href="index.jsp">
						<span class="glyphicon glyphicon-list" aria-hidden="true"></span> 首页 
						<span class="sr-only">(current)</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span class="glyphicon glyphicon-earphone" aria-hidden="true"></span> 联系我们
					</a>
				</li>
			</ul>
			<form class="navbar-form navbar-left" action="book/findByBName" method="get" target="body">
		        <div class="form-group">
		          <input name="bName" type="text" class="form-control" placeholder="Book Search By Name">
		        </div>
				<button type="submit" class="btn btn-primary btn-sm">Search</button>
				<a href="jsps/gj.jsp" target="body" class="btn btn-default btn-sm">高级搜索</a>
			</form>
			<ul class="nav navbar-nav navbar-right">
				<c:choose>
					<c:when test="${empty sessionScope.sessionUser }">
						<li><a href="jsps/user/login.jsp">登录</a></li>
						<li><a href="jsps/user/regist.jsp">注册</a></li>
					</c:when>
					<c:otherwise>
						<li class="dropdown">
				          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户：${sessionScope.sessionUser.loginName } <span class="caret"></span></a>
				          <ul class="dropdown-menu">
				            <li><a href="jsps/user/pwd.jsp" target="body">修改密码</a></li>
				            <li role="separator" class="divider"></li>
				            <li><a href="order/myOrders" target="body">我的订单</a></li>
				            <li><a href="cartItem/myCart" target="body">购物车</a></li>
				            <li role="separator" class="divider"></li>
				            <li><a href="user/quit">Quit</a></li>
				          </ul>
				        </li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</nav>
<!-- 导航条 -->
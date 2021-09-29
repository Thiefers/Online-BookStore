<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="jsps/css/user/regist.css">
<script type="text/javascript" src="jsps/js/user/regist.js"></script>
</head>
<body>
	<!-- header引入 -->
	<%@ include file="../header.jsp" %>

	<!-- 注册页面内容 -->
	<div class="container-fluid">
		<div class="row thumbnail">
			<div class="col-sm-12">
				<h1 class="text-center" style="margin-bottom: 30px">用户注册</h1>
			</div>
			<div class="col-sm-offset-2 col-sm-9">
				<form action="user/regist" method="post" id="registForm" class="form-horizontal caption">
					<div class="form-group">
						<label for="loginName" class="col-sm-3 control-label">用户名</label>
						<div class="col-sm-4">
							<input type="text" class="form-control inputClass" id="loginName"
								name="loginName" placeholder="用户名" value="${user.loginName}">
						</div>
						<label for="loginName" class="col-sm-4 control-label errorClass"
							id="loginNameError" style="text-align: left;">${errors.loginName}</label>
					</div>
					<div class="form-group">
						<label for="loginPwd" class="col-sm-3 control-label">密码</label>
						<div class="col-sm-4">
							<input type="password" class="form-control inputClass" id="loginPwd"
								name="loginPwd" placeholder="密码" value="${user.loginPwd}">
						</div>
						<label for="loginPwd" class="col-sm-4 control-label errorClass"
							id="loginPwdError" style="text-align: left;">${errors.loginPwd}</label>
					</div>
					<div class="form-group">
						<label for="reLoginPwd" class="col-sm-3 control-label">确认密码</label>
						<div class="col-sm-4">
							<input type="password" class="form-control inputClass" id="reLoginPwd"
								name="reLoginPwd" placeholder="确认密码" value="${user.reLoginPwd}">
						</div>
						<label for="reLoginPwd" class="col-sm-4 control-label errorClass"
							id="reLoginPwdError" style="text-align: left;">${errors.reLoginPwd}</label>
					</div>
					<div class="form-group">
						<label for="email" class="col-sm-3 control-label">邮箱</label>
						<div class="col-sm-4">
							<input type="email" class="form-control inputClass" id="email" name="email"
								placeholder="邮箱" value="${user.email}">
						</div>
						<label for="email" class="col-sm-4 control-label errorClass"
							id="emailError" style="text-align: left;">${errors.email}</label>
					</div>
					<div class="form-group">
						<label for="verifyCode" class="col-sm-3 control-label">验证码</label>
						<div class="col-sm-4">
							<input type="text" class="form-control inputClass" id="verifyCode"
								name="verifyCode" placeholder="验证码" value="${user.verifyCode}">
						</div>
						<label for="verifyCode" class="col-sm-4 control-label errorClass"
							id="verifyCodeError" style="text-align: left;">${errors.verifyCode}</label>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-2">
							<img id="imgVerifyCode" class="img-thumbnail" alt="验证码无法显示"
								src="verifyCode/getVerifyCode"
								style="width: 128px; height: 50px;">
						</div>
						<div class="col-sm-2" style="margin-top: 28px; width: 84px;">
							<a href="javascript:newVerifyCode()">换一张</a>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-3">
							<input type="button" class="btn btn-success btn-block" id="registBtn" value="注册"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 注册页面内容 END -->
	<!-- footer引入 -->
	<%@ include file="/jsps/footer.jsp" %>
</body>
</html>
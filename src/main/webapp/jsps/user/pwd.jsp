<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="jsps/css/user/pwd.css">
<script type="text/javascript" src="jsps/js/user/pwd.js"></script>
<script type="text/javascript">
	$(function() {/*Map<String(Cookie名称),Cookie(Cookie本身)>*/
		// 获取cookie中的用户名
		var loginName = window.decodeURI("${cookie.loginName.value}");
		if("${requestScope.user.loginName}") {
			loginName = "${requestScope.user.loginName}";
		}
		$("#loginName").val(loginName);
	});
</script>
</head>
<body>
	<!-- content -->
	<div class="container-fluid">
		<div class="row thumbnail">
			<div class="col-sm-12">
				<h1 class="text-center" style="margin-bottom: 30px">信息修改</h1>
			</div>
			<div class="col-sm-offset-2 col-sm-9">
				<form action="user/updatePassword" method="post" id="changePwdForm" class="form-horizontal caption">
		        	<div class="form-group">
						<label class="col-sm-offset-3 col-sm-2 control-label errorClass" id="msg" style="text-align: left;padding-left: 16px;">${msg}</label>
					</div>
					<div class="form-group">
						<label for="loginPwd" class="col-sm-3 control-label">原密码</label>
						<div class="col-sm-4">
							<input type="password" class="form-control inputClass" id="loginPwd"
								name="loginPwd" value="${user.loginPwd}">
						</div>
						<label for="loginPwd" id="loginPwdError" class="col-sm-4 control-label errorClass" style="text-align: left;">${errors.loginPwd}</label>
					</div>
					<div class="form-group">
						<label for="newLoginPwd" class="col-sm-3 control-label">新密码</label>
						<div class="col-sm-4">
							<input type="password" class="form-control inputClass" id="newLoginPwd"
								name="newLoginPwd" value="${user.newLoginPwd}">
						</div>
						<label for="newLoginPwd" id="newLoginPwdError" class="col-sm-4 control-label errorClass" style="text-align: left;">${errors.newLoginPwd}</label>
					</div>
					<div class="form-group">
						<label for="reLoginPwd" class="col-sm-3 control-label">确认密码</label>
						<div class="col-sm-4">
							<input type="password" class="form-control inputClass" id="reLoginPwd"
								name="reLoginPwd" value="${user.reLoginPwd}">
						</div>
						<label for="reLoginPwd" id="reLoginPwdError" class="col-sm-4 control-label errorClass" style="text-align: left;">${errors.reLoginPwd}</label>
					</div>
					<div class="form-group">
						<label for="verifyCode" class="col-sm-3 control-label">验证码</label>
						<div class="col-sm-4">
							<input type="text" class="form-control inputClass" id="verifyCode" name="verifyCode" value="${user.verifyCode}">
						</div>
						<label for="verifyCode" id="verifyCodeError" class="col-sm-4 control-label errorClass" style="text-align: left;">${errors.verifyCode}</label>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-2">
							<img id="imgVerifyCode" class="img-thumbnail" alt="图片无法显示"
								src="verifyCode/getVerifyCode" style="width: 128px; height: 50px;">
						</div>
						<div class="col-sm-2" style="margin-top: 28px; width: 84px;">
							<a href="javascript:newVerifyCode()">换一张</a>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-3">
							<input type="button" class="btn btn-success btn-block" id="updatePwdBtn" value="提交"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- content end -->
</body>
</html>
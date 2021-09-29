$(function() {
	// 把控错误信息的显示
	$(".errorClass").each(function() {
		showError($(this));
	});
	// 输入框得到焦点后隐藏错误信息
	$(".inputClass").focus(function() {
		var labelId = $(this).attr("id") + "Error";// 通过输入框找到对应的label的id
		$("#" + labelId).text("");// 把label的内容清空！
		showError($("#" + labelId));// 隐藏没有信息的label
	});
	// 输入框失去焦点后进行信息校验
	$(".inputClass").blur(function() {
		var id = $(this).attr("id");// 获取当前输入框的id
		var funName = "validate" + id.substring(0, 1).toUpperCase() + id.substring(1) + "()";// 得到对应的校验函数名
		eval(funName);// 执行函数调用
	});
	// 表单提交时进行信息检验
	$("#updatePwdBtn").click(function(){
		var bool = true;// 表示校验通过
		if (!validateLoginPwd()) {
			bool = false;
		}
		if (!validateNewLoginPwd()) {
			bool = false;
		}
		if (!validateReLoginPwd()) {
			bool = false;
		}
		if (!validateVerifyCode()) {
			bool = false;
		}
		if(bool){
			$("#changePwdForm").submit();
		}
	});
});
// 原密码验证
function validateLoginPwd() {
	var id = "loginPwd";
	var value = $("#" + id).val();

	if (!value) {
		$("#" + id + "Error").text("密码不能为空");
		showError($("#" + id + "Error"));
		return false;
	}

	if (value.length < 3 || value.length > 20) {
		$("#" + id + "Error").text("密码长度必须在3 ~ 20之间");
		showError($("#" + id + "Error"));
		return false;
	}

	return true;
}

// 新密码校验
function validateNewLoginPwd() {
	var id = "newLoginPwd";
	var value = $("#" + id).val();

	if (!value) {
		$("#" + id + "Error").text("新密码不能为空");
		showError($("#" + id + "Error"));
		return false;
	}

	if (value.length < 3 || value.length > 20) {
		$("#" + id + "Error").text("新密码长度必须在3 ~ 20之间");
		showError($("#" + id + "Error"));
		return false;
	}

	return true;
}
//确认密码校验
function validateReLoginPwd() {
	var id = "reLoginPwd";
	var value = $("#" + id).val();

	if (!value) {
		$("#" + id + "Error").text("确认密码不能为空");
		showError($("#" + id + "Error"));
		return false;
	}

	if (value != $("#newLoginPwd").val()) {
		$("#" + id + "Error").text("两次输入不一致");
		showError($("#" + id + "Error"));
		return false;
	}

	return true;
}
//验证码校验
function validateVerifyCode() {
	var id = "verifyCode";
	var value = $("#" + id).val();
	if (!value) {
		$("#" + id + "Error").text("验证码不能为空");
		showError($("#" + id + "Error"));
		return false;
	}
	if (value.length != 4) {
		$("#" + id + "Error").text("错误的验证码");
		showError($("#" + id + "Error"));
		return false;
	}

	$.ajax({
		url : "/ssm-bookshop/user/ajaxValidateVerifyCode",
		data : {
			verifyCode : value
		},
		type : "POST",
		dataType : "json",
		async : false,
		cache : false,
		success : function(result) {
			if (!result) {
				$("#" + id + "Error").text("验证码错误");
				showError($("#" + id + "Error"));
				return false;
			}
		}
	});
	return true;
}
// 错误信息展示,无就不展示
function showError(ele) {
	var text = ele.text();
	if (!text) {
		ele.css("display", "none");
	} else {
		ele.css("display", "");
	}
}
//更换验证码
function newVerifyCode() {
	$("#imgVerifyCode").attr("src","verifyCode/getVerifyCode?a=" + new Date().getTime());
}
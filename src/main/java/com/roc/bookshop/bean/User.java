package com.roc.bookshop.bean;

/**
 * 用户模块
 */
public class User {
	private String uId;// 主键

	private String loginName;// 登录名

	private String loginPwd;// 密码

	private String email;// 邮箱

	private Boolean status;// 状态，true表示已激活，false表示未激活

	private String activationCode;// 激活码，唯一值，每个用户的激活码都不同

	// 追加
	// 注册表单
	private String reLoginPwd;// 确认密码
	private String verifyCode;// 验证码
	// 修改密码表单
	private String newLoginPwd;// 新密码

	public String getUId() {
		return uId;
	}

	public void setUId(String uId) {
		this.uId = uId == null ? null : uId.trim();
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName == null ? null : loginName.trim();
	}

	public String getLoginPwd() {
		return loginPwd;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd == null ? null : loginPwd.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public Boolean isStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getActivationCode() {
		return activationCode;
	}

	public void setActivationCode(String activationCode) {
		this.activationCode = activationCode == null ? null : activationCode.trim();
	}

	public String getReLoginPwd() {
		return reLoginPwd;
	}

	public void setReLoginPwd(String reLoginPwd) {
		this.reLoginPwd = reLoginPwd;
	}

	public String getVerifyCode() {
		return verifyCode;
	}

	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}

	public String getNewLoginPwd() {
		return newLoginPwd;
	}

	public void setNewLoginPwd(String newLoginPwd) {
		this.newLoginPwd = newLoginPwd;
	}

	@Override
	public String toString() {
		return "User [uId=" + uId + ", loginName=" + loginName + ", loginPwd=" + loginPwd + ", email=" + email
				+ ", status=" + status + ", activationCode=" + activationCode + ", reLoginPwd=" + reLoginPwd
				+ ", verifyCode=" + verifyCode + ", newLoginPwd=" + newLoginPwd + "]";
	}

}
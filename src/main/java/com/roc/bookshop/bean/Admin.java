package com.roc.bookshop.bean;

public class Admin {
	private String adminId;// 主键

	private String adminName;// 管理员的登录名

	private String adminPwd;// 管理员的登录密码

	private String adminIdentity;// 管理员身份

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId == null ? null : adminId.trim();
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName == null ? null : adminName.trim();
	}

	public String getAdminPwd() {
		return adminPwd;
	}

	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd == null ? null : adminPwd.trim();
	}

	public String getAdminIdentity() {
		return adminIdentity;
	}

	public void setAdminIdentity(String adminIdentity) {
		this.adminIdentity = adminIdentity == null ? null : adminIdentity.trim();
	}

	@Override
	public String toString() {
		return "Admin [adminId=" + adminId + ", adminName=" + adminName + ", adminPwd=" + adminPwd + ", adminIdentity="
				+ adminIdentity + "]";
	}

}
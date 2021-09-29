package com.roc.bookshop.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.roc.bookshop.bean.User;

@Repository
public interface UserMapper {
	// 检验用户名是否注册
	public String ajaxValidateLoginName(@Param("login_name")String login_name);

	// 检验Email是否注册
	public String ajaxValidateEmail(@Param("email")String email);

	// 添加用户
	public void add(User user);

	// 通过激活码检查用户
	public User findUserByActivationCode(String activationCode);

	// 修改用户状态
	public void updateStatus(@Param("status")boolean status, @Param("uId")String uId);

	// 按用户名和密码查询
	public User findUserByLoginNameAndPassword(User user);

	// 按uId和loginPwd查询
	public User findUserByUIdAndLoginPwd(@Param("uId")String uId, @Param("loginPwd")String loginPwd);

	// 修改密码
	public void updatePassword(@Param("loginPwd")String loginPwd, @Param("uId")String uId);
}
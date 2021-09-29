package com.roc.bookshop.service;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roc.bookshop.bean.Mail;
import com.roc.bookshop.bean.User;
import com.roc.bookshop.dao.UserMapper;
import com.roc.bookshop.exception.UserException;
import com.roc.bookshop.utils.CommonUtils;
import com.roc.bookshop.utils.MailUtils;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;

	// 检验用户名是否注册
	public boolean ajaxValidateLoginName(String loginName) {
		// System.out.println(userMapper.ajaxValidateLoginName(loginName));
		System.out.println("service:" + userMapper.ajaxValidateLoginName(loginName));
		System.out.println("service:" + userMapper.ajaxValidateLoginName(loginName) != null);
		return userMapper.ajaxValidateLoginName(loginName) != null;
	};

	// 检验Email是否注册
	public boolean ajaxValidateEmail(String email) {
		return userMapper.ajaxValidateEmail(email) != null;
	}

	// 注册功能
	public void regist(User user) {
		// 数据补齐
		user.setUId(CommonUtils.uuid());
		user.setStatus(false);
		user.setActivationCode(CommonUtils.uuid() + CommonUtils.uuid());
		// 插入数据库
		try {
			userMapper.add(user);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		// TODO 发邮件
		// 加载配置文件
		Properties prop = new Properties();
		try {
			prop.load(this.getClass().getClassLoader().getResourceAsStream("email_template.properties"));
		} catch (IOException e) {
			// e.printStackTrace();
			throw new RuntimeException(e);
		}
		// 登录邮件服务器，获取session
		String host = prop.getProperty("host");// 服务器主机名
		String name = prop.getProperty("username");// 登录名
		String pass = prop.getProperty("password");// 密码
		Session session = MailUtils.createSession(host, name, pass);
		// 创建Mail对象
		String from = prop.getProperty("from");
		String to = user.getEmail();
		String subject = prop.getProperty("subject");
		String content = MessageFormat.format(prop.getProperty("content"), user.getActivationCode());
		Mail mail = new Mail(from, to, subject, content);
		// 发送邮件
		try {
			MailUtils.send(session, mail);
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	// 激活功能
	public void activation(String activationCode) throws UserException {
		User user = userMapper.findUserByActivationCode(activationCode);
		System.out.println("userService: " + user);
		if (user == null) {
			throw new UserException("无效的激活码!");
		}
		if (user.isStatus()) {
			throw new UserException("您已经激活账户，请勿重复操作！");
		}
		userMapper.updateStatus(true, user.getUId());// 修改状态
	}

	// 登录功能
	public User login(User user) {
		return userMapper.findUserByLoginNameAndPassword(user);
	}

	// 修改密码
	public void updatePassword(String uId, String newPwd, String oldPwd) throws UserException {
		User user = userMapper.findUserByUIdAndLoginPwd(uId, oldPwd);
		// 原密码校验
		if (user == null) {
			throw new UserException("原密码错误！");
		}
		// 修改密码
		userMapper.updatePassword(newPwd, uId);
	}
}
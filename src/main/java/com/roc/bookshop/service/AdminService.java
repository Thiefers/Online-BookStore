package com.roc.bookshop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roc.bookshop.bean.Admin;
import com.roc.bookshop.dao.AdminMapper;

@Service
public class AdminService {
	@Autowired
	private AdminMapper adminMapper;

	// 登录功能
	public Admin login(Admin admin) {
		return adminMapper.findByNameAndPwd(admin.getAdminName(), admin.getAdminPwd());
	}
}
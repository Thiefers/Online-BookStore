package com.roc.bookshop.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.roc.bookshop.bean.Admin;
import com.roc.bookshop.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("/login")
	public String login(Admin admin,HttpServletRequest request) {
		System.out.println(admin);
		Admin loginAdmin = adminService.login(admin);
		if (loginAdmin == null) {
			request.setAttribute("msg", "用户名或密码错误");
			return "adminjsps/login";
		}
		request.getSession().setAttribute("admin", loginAdmin);
		return "redirect:/adminjsps/admin/index.jsp";
	}
}
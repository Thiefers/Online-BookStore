package com.roc.bookshop.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.roc.bookshop.bean.Admin;

@Repository
public interface AdminMapper {
	// 通过管理员登录名和登录密码查询
	public Admin findByNameAndPwd(@Param("adminName") String adminName, @Param("adminPwd") String adminPwd);
}
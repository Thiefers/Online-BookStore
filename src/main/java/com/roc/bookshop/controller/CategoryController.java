package com.roc.bookshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.roc.bookshop.bean.Category;
import com.roc.bookshop.service.CategoryService;

/**
 * 分类控制层
 * @author 14036
 *
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping("/findAll")
	@ResponseBody
	public List<Category> findAll(HttpServletRequest request) {
		List<Category> parents = categoryService.findAll();
		request.setAttribute("parents", parents);
		return parents;
	}
}
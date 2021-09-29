package com.roc.bookshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.roc.bookshop.bean.Category;
import com.roc.bookshop.service.BookService;
import com.roc.bookshop.service.CategoryService;
import com.roc.bookshop.utils.CommonUtils;

@Controller
@RequestMapping("/adminCategory")
public class AdminCategoryController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BookService bookService;

	// 查询所有分类
	@RequestMapping("/findAll")
	public String findAll(HttpServletRequest request) {
		request.setAttribute("parents", categoryService.findAll());
		return "adminjsps/admin/category/list";
	}

	// 添加一级分类
	@RequestMapping("/addParent")
	public String addParent(Category category, HttpServletRequest request) {
		category.setcId(CommonUtils.uuid());
		categoryService.add(category);
		return findAll(request);
	}

	// 添加二级分类前准备
	@RequestMapping("/addChildPre")
	public String addChildPre(HttpServletRequest request) {
		String pId = request.getParameter("pId");
		List<Category> parents = categoryService.findParents();
		request.setAttribute("pId", pId);
		request.setAttribute("parents", parents);
		return "adminjsps/admin/category/add2";
	}

	// 添加二级分类
	@RequestMapping("/addChild")
	public String addChild(Category category, HttpServletRequest request) {
		category.setcId(CommonUtils.uuid());
		category.setpId(request.getParameter("pId"));
		categoryService.add(category);
		return findAll(request);
	}

	// 修改一级分类前准备
	@RequestMapping("/editParentPre")
	public String editParentPre(String cId, HttpServletRequest request) {
		Category parent = categoryService.load(cId);
		request.setAttribute("parent", parent);
		return "adminjsps/admin/category/edit";
	}

	// 修改一级分类
	@RequestMapping("/editParent")
	public String editParent(Category category, HttpServletRequest request) {
		categoryService.edit(category);
		return findAll(request);
	}

	// 修改二级分类前准备
	@RequestMapping("/editChildPre")
	public String editChildPre(String cId, HttpServletRequest request) {
		Category child = categoryService.load(cId);
		request.setAttribute("child", child);
		request.setAttribute("parents", categoryService.findParents());
		return "adminjsps/admin/category/edit2";
	}

	// 修改二级分类
	@RequestMapping("/editChild")
	public String editChild(Category category, HttpServletRequest request) {
		categoryService.edit(category);
		return findAll(request);
	}

	// 删除一级分类
	@RequestMapping("/deleteParent")
	public String deleteParent(String cId, HttpServletRequest request) {
		List<Category> childrens = categoryService.findChildrenByPid(cId);
		if (childrens.size() > 0) {
			request.setAttribute("msg", "该分类下还有子分类，不能删除！");
			return "adminjsps/msg";
		} else {
			categoryService.delete(cId);
			return findAll(request);
		}
	}
	
	// 删除二级分类
	@RequestMapping("/deleteChild")
	public String deleteChild(String cId, HttpServletRequest request) {
		Integer bookCount = bookService.findBookCountByCategory(cId);
		if (bookCount > 0) {
			request.setAttribute("msg", "该分类下还有图书，不能删除！");
			return "adminjsps/msg";
		} else {
			categoryService.delete(cId);
			return findAll(request);
		}
	}
}
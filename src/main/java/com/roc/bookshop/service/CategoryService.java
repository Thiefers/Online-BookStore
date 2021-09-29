package com.roc.bookshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roc.bookshop.bean.Category;
import com.roc.bookshop.dao.CategoryMapper;

/**
 * 分类业务层
 * @author 14036
 *
 */
@Service
public class CategoryService {
	
	@Autowired
	private CategoryMapper categoryMapper;
	
	public List<Category> findAll(){
		List<Category> parents = categoryMapper.selectAllParentCategory();
		for (Category parent : parents) {
			List<Category> childrens = categoryMapper.selectAllChildrenCategoryByParentId(parent.getcId());
			parent.setChildren(childrens);
		}
		return parents;
	}

	// 添加分类
	public void add(Category category) {
		/*@SuppressWarnings("unused")
		String pId = null;
		if (category.getpId() != null) {
			pId = category.getpId();
		}*/
		categoryMapper.add(category);
	}

	// 获取所有父分类
	public List<Category> findParents(){
		return categoryMapper.selectAllParentCategory();
	}

	// 加载分类
	public Category load(String cId) {
		return categoryMapper.load(cId);
	}

	// 修改分类
	public void edit(Category category) {
		categoryMapper.edit(category);
	}

	// 获取某个父类下的子类
	public List<Category> findChildrenByPid(String pId) {
		return categoryMapper.selectAllChildrenCategoryByParentId(pId);
	}

	// 删除分类
	public void delete(String cId) {
		categoryMapper.delete(cId);
	}
}
package com.roc.bookshop.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.roc.bookshop.bean.Category;

/**
 * 分类持久层
 * 
 * @author 14036
 *
 */
@Repository
public interface CategoryMapper {
	// 查找所有父分类
	public List<Category> selectAllParentCategory();

	// 通过父分类id查找子分类
	public List<Category> selectAllChildrenCategoryByParentId(String pId);

	// 添加分类
	public void add(Category category);

	// 加载分类
	public Category load(String cId);

	// 修改分类
	public void edit(Category category);

	// 删除分类
	public void delete(String cId);
}
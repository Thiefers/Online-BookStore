package com.roc.bookshop.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.BookVo;

@Repository
public interface BookMapper {
	// 图书总记录数
	public int selectBookCount(BookVo bookVo);
	// 得到beanList，即当前页记录
	public List<Book> selectBookFromTo(BookVo bookVo);
	// 根据bId查询图书
	public Book selectBookByBid(String bId);
	// 返回当前分类下图书个数
	public Integer findBookCountByCategory(String cId);
	// 添加图书
	public void add(Book book);
	// 修改图书
	public void edit(Book book);
	// 删除图书
	public void delete(String bId);
	// 修改图书库存
	public void updateInventory(Book book);
	// 修改图书销售状态
	public void updateSaleStatus(Book book);
}
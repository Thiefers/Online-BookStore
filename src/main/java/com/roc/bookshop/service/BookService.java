package com.roc.bookshop.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.BookVo;
import com.roc.bookshop.dao.BookMapper;
import com.roc.bookshop.pager.PageBean;
import com.roc.bookshop.pager.PageConstants;

/**
 * 图书业务层
 * 
 * @author 14036
 *
 */
@Service
public class BookService {

	@Autowired
	private BookMapper bookMapper;
	private int pageSize = PageConstants.BOOK_PAGE_SIZE;// 每页记录数
	List<Book> beanList = new ArrayList<Book>();

	public PageBean<Book> findByCriteria(int pageCode, Book book) {
		// 封装查询条件
		BookVo bookVo = new BookVo();
		bookVo.setFrom((pageCode - 1) * pageSize);
		bookVo.setTo(pageSize);
		bookVo.setBook(book);
		// 查询总记录数
		int totalRecord = bookMapper.selectBookCount(bookVo);
		// 查询指定书籍
		beanList = bookMapper.selectBookFromTo(bookVo);
		PageBean<Book> pageBean = new PageBean<Book>();
		pageBean.setBeanList(beanList);
		pageBean.setPageCode(pageCode);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRecord(totalRecord);
		return pageBean;
	}

	// 根据bId查询图书
	public Book selectBookByBid(String bId) {
		return bookMapper.selectBookByBid(bId);
	}

	// 返回当前分类下图书个数
	public Integer findBookCountByCategory(String cId) {
		return bookMapper.findBookCountByCategory(cId);
	}

	// 添加图书
	public void add(Book book) {
		book.setPublishTime(book.getPublishTime().substring(0,10));
//		System.out.println(book.getPublishTime());
		book.setPrintTime(book.getPrintTime().substring(0,10));
//		System.out.println(book.getPrintTime());
		bookMapper.add(book);
	}

	// 修改图书
	public void edit(Book book) {
		bookMapper.edit(book);
	}

	// 删除图书
	public void delete(String bId) {
		bookMapper.delete(bId);
	}

	// 修改图书库存（增加库存）
	public void updateInventory(Book book) {
		Book selectBook = bookMapper.selectBookByBid(book.getbId());
		book.setInventory(book.getInventory()+selectBook.getInventory());
		bookMapper.updateInventory(book);
	}

	// 修改图书销售状态
	public void updateSaleStatus(Book book) {
		book.setOnSale(!book.getOnSale());
		bookMapper.updateSaleStatus(book);
	}
}
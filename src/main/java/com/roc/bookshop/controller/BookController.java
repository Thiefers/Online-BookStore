package com.roc.bookshop.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.pager.PageBean;
import com.roc.bookshop.service.BookService;

/**
 * 图书控制层
 * 
 * @author 14036
 *
 */
@Controller
@RequestMapping("/book")
public class BookController {

	@Autowired
	private BookService bookService;

	// 获取当前页码
	private int getPageCode(HttpServletRequest request) {
		int pageCode = 1;
		String param = request.getParameter("pageCode");
		if (param != null && !param.trim().isEmpty()) {
			try {
				pageCode = Integer.parseInt(param);
			} catch (RuntimeException e) {
			}
		}
		return pageCode;
	}

	// 截取url，页面中的分页导航中需要使用它做为超链接的目标！
	/*
	 * http://localhost:8080/bookstore/book/findByCategory?cid=xxx&pc=3
	 * /bookstore/book/findByCategory + cid=xxx&pc=3
	 */
	private String getUrl(HttpServletRequest request) {
		String url = request.getRequestURI() + "?" + request.getQueryString();
		/*
		 * 如果url中存在pc参数，截取掉，如果不存在那就不用截取。
		 */
		int index = url.lastIndexOf("&pageCode=");
		if (index != -1) {
			url = url.substring(0, index);
		}
		return url;
	}

	public String findByMethod(Book book, HttpServletRequest request) {
		book.setOnSale(true);
		/*
		 * 1. 得到PageCode：如果页面传递，使用页面的，如果没传，PageCode=1
		 */
		int pageCode = getPageCode(request);
		/*
		 * 2. 得到url
		 */
		String url = getUrl(request);
		/*
		 * 3. 获取查询条件，本方法就是cid，即分类的id
		 */
		// String cId = request.getParameter("cId");
		/*
		 * 4. 使用pageCode和cId调用service#findByCategory得到PageBean
		 */
		// Book book = getDecoder(request, cId);
		PageBean<Book> pb = bookService.findByCriteria(pageCode, book);
		/*
		 * 5. 给PageBean设置url，保存PageBean，转发到/jsps/book/list.jsp
		 */
		pb.setUrl(url);
		// 按图书id查，调到详情页
		if (book.getbId() != null) {
			request.setAttribute("book", pb.getBeanList().get(0));
			return "jsps/book/desc";
		} else {
			request.setAttribute("pb", pb);
			return "jsps/book/list";
		}
	}

	// 按分类
	@RequestMapping("/findByCategory")
	public String findByCategory(HttpServletRequest request) throws UnsupportedEncodingException {
		return findByMethod(getDecoder(request, "cId"), request);
	}

	// 按图书ID
	@RequestMapping("/load")
	public String load(HttpServletRequest request) throws UnsupportedEncodingException {
		return findByMethod(getDecoder(request, "bId"), request);
	}

	// 按作者
	@RequestMapping("/findByAuthor")
	public String findByAuthor(HttpServletRequest request) throws UnsupportedEncodingException {
		return findByMethod(getDecoder(request, "author"), request);
	}

	// 按出版社
	@RequestMapping("/findByPress")
	public String findByPress(HttpServletRequest request) throws UnsupportedEncodingException {
		return findByMethod(getDecoder(request, "press"), request);
	}

	// 按图书名字
	@RequestMapping("/findByBName")
	public String findByBName(HttpServletRequest request) throws UnsupportedEncodingException {
		return findByMethod(getDecoder(request, "bName"), request);
	}

	// 组合查询
	@RequestMapping("/findByCombination")
	public String findByCombination(Book book, HttpServletRequest request) {
		return findByMethod(book, request);
	}

	private Book getDecoder(HttpServletRequest req, String neededParam) throws UnsupportedEncodingException {
		Book book = new Book();
		String url = getUrl(req);
		String decode = URLDecoder.decode(url.substring(url.lastIndexOf("=") + 1), "UTF-8");
		switch (neededParam) {
		case "press":
			book.setPress(decode);
			break;
		case "author":
			book.setAuthor(decode);
			break;
		case "cId":
			book.setcId(decode);
			break;
		case "bName":
			book.setbName(decode);
			break;
		case "bId":
			book.setbId(decode);
			break;
		}
		return book;
	}

	@Test
	public void testDecode() throws UnsupportedEncodingException {
		String url = "?cid=A你好";
		String decode = URLDecoder.decode(url.substring(url.lastIndexOf("=") + 1), "UTF-8");
		System.out.println(decode);
	}
}
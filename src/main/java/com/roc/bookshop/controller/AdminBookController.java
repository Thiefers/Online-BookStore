package com.roc.bookshop.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.Category;
import com.roc.bookshop.pager.PageBean;
import com.roc.bookshop.service.BookService;
import com.roc.bookshop.service.CategoryService;
import com.roc.bookshop.utils.CommonUtils;

@Controller
@RequestMapping("/adminBook")
public class AdminBookController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BookService bookService;

	// 查询所有图书分类，用于分级菜单栏
	@RequestMapping("/findAllCategory")
	public String findAllCategory(HttpServletRequest request) {
		List<Category> parents = categoryService.findAll();
		String op = request.getParameter("op");
		System.out.println(op);
		if ("inventory".equals(op)) {
			request.setAttribute("op", op);
		}
		request.setAttribute("parents", parents);
		return "adminjsps/admin/book/left";
	}

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
	private String getUrl(HttpServletRequest request) {
		String url = request.getRequestURI() + "?" + request.getQueryString();
		int index = url.lastIndexOf("&pageCode=");
		if (index != -1) {
			url = url.substring(0, index);
		}
		return url;
	}

	public String findByMethod(Book book, HttpServletRequest request) {
		/*
		 * 1. 得到PageCode：如果页面传递，使用页面的，如果没传，PageCode=1
		 */
		int pageCode = getPageCode(request);
		/*
		 * 2. 得到url
		 */
		String url = getUrl(request);
		/*
		 * 3. 使用pageCode和cId调用service#findByCategory得到PageBean
		 */
		PageBean<Book> pb = bookService.findByCriteria(pageCode, book);
		/*
		 * 4. 给PageBean设置url，保存PageBean，转发到/jsps/book/list.jsp
		 */
		pb.setUrl(url);
		// 按图书id查，调到详情页
		if (book.getbId() != null) {
			request.setAttribute("book", pb.getBeanList().get(0));
			return "adminjsps/admin/book/desc";
		} else {
			request.setAttribute("pb", pb);
			String choice = request.getParameter("choice");
			if ("inventory".equals(choice)) {
				return "adminjsps/admin/book/inventoryBody";
			}
			return "adminjsps/admin/book/list";
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
		// 获取bid，得到Book对象，保存之
		String bId = request.getParameter("bId");
		Book book = bookService.selectBookByBid(bId);
		request.setAttribute("book", book);
		// 2. 获取所有一级分类，保存之
		request.setAttribute("parents", categoryService.findParents());
		// 3. 获取当前图书所属的一级分类下所有2级分类
		String pId = categoryService.load(book.getcId()).getpId();
		request.setAttribute("children", categoryService.findChildrenByPid(pId));
		request.setAttribute("pId", pId);
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

	// 添加图书：第一步(拿到一级分类)
	@RequestMapping("/addPre")
	public String addPre(HttpServletRequest request) {
		List<Category> parents = categoryService.findParents();
		request.setAttribute("parents", parents);
		return "adminjsps/admin/book/add";
	}

	// 添加图书：第二步(拿到二级分类)
	@RequestMapping("/ajaxFindChildren")
	@ResponseBody
	public List<Category> ajaxFindChildren(String pId) {
		List<Category> children = categoryService.findChildrenByPid(pId);
		return children;
	}

	// 添加图书：第三步（获取表单数据并封装成BOOK，插入）
	@RequestMapping("/addBook")
	public String addBook(Book book, MultipartFile imageWW, MultipartFile imageBB, HttpServletRequest request)
			throws IllegalStateException, IOException {
		String imageWName = imageWW.getOriginalFilename();
		String imageBName = imageBB.getOriginalFilename();
//		String realPath = request.getServletContext().getRealPath("/book_img");
		String realPath = "F:/Java-wrokspace-for-project/ssm/ssm-bookshop/src/main/webapp/book_img";
		System.out.println(realPath);
		book.setbId(CommonUtils.uuid());
		if (imageWW != null && imageWName != null && imageWName.length() > 0) {
			imageWName = CommonUtils.uuid() + "_w" + imageWName.substring(imageWName.lastIndexOf("."));
			imageWW.transferTo(new File(realPath + "/" + imageWName));
			book.setImageW("book_img/" + imageWName);
		}
		if (imageBB != null && imageBName != null && imageBName.length() > 0) {
			imageBName = CommonUtils.uuid() + "_b" + imageBName.substring(imageBName.lastIndexOf("."));
			imageBB.transferTo(new File(realPath + "/" + imageBName));
			book.setImageB("book_img/" + imageBName);
		}
		bookService.add(book);
		System.out.println(book);
		request.setAttribute("msg", "添加图书成功！");
		return "adminjsps/msg";
	}

	// 修改图书
	@RequestMapping("/edit")
	public String edit(Book book, HttpServletRequest request) {
		bookService.edit(book);
		request.setAttribute("msg", "修改图书成功！");
		return "adminjsps/msg";
	}

	// 删除图书
	@RequestMapping("/delete")
	public String delete(String bId, HttpServletRequest request) {
		Book book = bookService.selectBookByBid(bId);
		String savePath = request.getServletContext().getRealPath("/");
		new File(savePath, book.getImageW()).delete();
		new File(savePath, book.getImageB()).delete();
		bookService.delete(bId);
		request.setAttribute("msg", "删除图书成功！");
		return "adminjsps/msg";
	}

	// 修改图书库存（增加库存）
	@RequestMapping("/ajaxUpdateInventory")
	@ResponseBody
	public Book ajaxUpdateInventory(Book book) {
		bookService.updateInventory(book);
		return book;
	}

	// 修改图书销售状态
	@RequestMapping("/ajaxChangeSaleStatus")
	@ResponseBody
	public Book ajaxChangeSaleStatus(Book book) {
		bookService.updateSaleStatus(book);
		return book;
	}
}
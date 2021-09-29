package com.roc.bookshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.CartItem;
import com.roc.bookshop.bean.User;
import com.roc.bookshop.service.BookService;
import com.roc.bookshop.service.CartItemService;

@Controller
@RequestMapping("/cartItem")
public class CartItemController {

	@Autowired
	private CartItemService cartItemService;
	@Autowired
	private BookService bookService;

	// 我的购物车
	@RequestMapping("/myCart")
	public String myCart(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("sessionUser");
		String uId = user.getUId();
		List<CartItem> myCart = cartItemService.myCart(uId);
		request.setAttribute("cartItemList", myCart);
		return "jsps/cart/list";
	}

	// 添加购物车条目
	@RequestMapping("/add")
	public String add(HttpServletRequest request) {
		// 表单有bId，quantity
		CartItem cartItem = new CartItem();
		User user = (User) request.getSession().getAttribute("sessionUser");
		Book book = bookService.selectBookByBid(request.getParameter("bId"));
		cartItem.setQuantity(Integer.valueOf(request.getParameter("quantity")));
		cartItem.setBook(book);
		cartItem.setUser(user);
		cartItemService.add(cartItem);
		return myCart(request);
	}

	// 批量删除
	@RequestMapping("/batchDelete")
	public String batchDelete(String cartItemIds, HttpServletRequest request) {
		cartItemService.batchDelete(cartItemIds);
		return myCart(request);
	}

	// 修改指定条目的数量
	@RequestMapping("/updateQuantity")
	@ResponseBody
	public CartItem updateQuantity(HttpServletRequest request) {
		String cartitemId = request.getParameter("cartitemId");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		CartItem cartItem = cartItemService.updateQuantity(cartitemId, quantity);
		return cartItem;
	}

	// 加载多个CartItem
	@RequestMapping("/loadCartItems")
	public String loadCartItems(String cartItemIds, HttpServletRequest request) {
		List<CartItem> cartItems = cartItemService.loadCartItems(cartItemIds);
		double total = Double.parseDouble(request.getParameter("total"));
		request.setAttribute("cartItems", cartItems);
		request.setAttribute("total", total);
		request.setAttribute("cartItemIds", cartItemIds);
		return "jsps/cart/showItem";
	}
}
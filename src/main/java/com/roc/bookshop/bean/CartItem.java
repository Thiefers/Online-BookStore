package com.roc.bookshop.bean;

import java.math.BigDecimal;

public class CartItem {
	private String cartitemId;// 主键

	private Integer quantity;// 数量

	// private String bId;
	private Book book;// 条目对应的图书

	// private String uId;
	private User user;// 所属用户

	private Integer orderBy;

	@SuppressWarnings("unused")
	private double subtotal;
	// 小计
	public double getSubtotal() {
		BigDecimal b1 = new BigDecimal(book.getCurrPrice() + "");
		BigDecimal b2 = new BigDecimal(quantity + "");
		BigDecimal b3 = b1.multiply(b2);
		return b3.doubleValue();
	}

	public String getCartitemId() {
		return cartitemId;
	}

	public void setCartitemId(String cartitemId) {
		this.cartitemId = cartitemId == null ? null : cartitemId.trim();
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	// public String getbId() {
	// return bId;
	// }
	// public void setbId(String bId) {
	// this.bId = bId == null ? null : bId.trim();
	// }

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}
	// public String getuId() {
	// return uId;
	// }
	// public void setuId(String uId) {
	// this.uId = uId == null ? null : uId.trim();
	// }

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(Integer orderBy) {
		this.orderBy = orderBy;
	}

	@Override
	public String toString() {
		return "CartItem [cartitemId=" + cartitemId + ", quantity=" + quantity + ", book=" + book + ", user=" + user
				+ ", orderBy=" + orderBy + "]";
	}
	
}
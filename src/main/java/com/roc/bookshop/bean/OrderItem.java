package com.roc.bookshop.bean;

public class OrderItem {
	private String orderItemId;// 主键

	private Integer quantity;// 数量

	private double subTotal;// 小计

	private Book book;// 关联的Book

	private Order order;// 所属的订单
	// private String bId;
	// private String bName;
	// private BigDecimal currPrice;
	// private String imageB;
	// private String oId;

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public String getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(String orderItemId) {
		this.orderItemId = orderItemId == null ? null : orderItemId.trim();
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public double getSubTotal() {
		return subTotal;
	}

	public void setSubTotal(double subTotal) {
		this.subTotal = subTotal;
	}

	@Override
	public String toString() {
		return "OrderItem [orderItemId=" + orderItemId + ", quantity=" + quantity + ", subTotal=" + subTotal + ", book="
				+ book + ", order=" + order + "]";
	}

	// public String getbId() {
	// return bId;
	// }
	// public void setbId(String bId) {
	// this.bId = bId == null ? null : bId.trim();
	// }
	// public String getbName() {
	// return bName;
	// }
	// public void setbName(String bName) {
	// this.bName = bName == null ? null : bName.trim();
	// }
	// public BigDecimal getCurrPrice() {
	// return currPrice;
	// }
	// public void setCurrPrice(BigDecimal currPrice) {
	// this.currPrice = currPrice;
	// }
	// public String getImageB() {
	// return imageB;
	// }
	// public void setImageB(String imageB) {
	// this.imageB = imageB == null ? null : imageB.trim();
	// }
	// public String getoId() {
	// return oId;
	// }
	// public void setoId(String oId) {
	// this.oId = oId == null ? null : oId.trim();
	// }
}
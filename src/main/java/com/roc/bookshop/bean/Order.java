package com.roc.bookshop.bean;

import java.util.List;

public class Order {
	// 主键
	private String oId;
	// 下单时间
	private String orderTime;
	// 总计
	private double total;
	// 订单状态：1未付款，2已付款未收货，3已发货未确认收货，4确认收货交易成功，5已取消（只有未付款才能取消）
	private Integer status;
	// 收货地址
	private String address;
	// 订单的所有者
	private String uId;
	private User owner;
	// 评价
	private String evaluate;

	private List<OrderItem> orderItems;

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public String getoId() {
		return oId;
	}

	public void setoId(String oId) {
		this.oId = oId == null ? null : oId.trim();
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime == null ? null : orderTime.trim();
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address == null ? null : address.trim();
	}

	public String getuId() {
		return uId;
	}

	public void setuId(String uId) {
		this.uId = uId == null ? null : uId.trim();
	}

	public List<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	public String getEvaluate() {
		return evaluate;
	}

	public void setEvaluate(String evaluate) {
		this.evaluate = evaluate;
	}

	@Override
	public String toString() {
		return "Order [oId=" + oId + ", orderTime=" + orderTime + ", total=" + total + ", status=" + status
				+ ", address=" + address + ", uId=" + uId + ", owner=" + owner + ", evaluate=" + evaluate
				+ ", orderItems=" + orderItems + "]";
	}

}
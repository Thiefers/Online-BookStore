package com.roc.bookshop.dao;

import java.util.List;

import com.roc.bookshop.bean.OrderItem;

public interface OrderItemMapper {

	// 为指定的Order根据订单ID查条目OrderItem
	List<OrderItem> selectOrderItemByOrderId(String oId);

	// 添加生成的订单中的订单条目
	void add(OrderItem orderItem);
}
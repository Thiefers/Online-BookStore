package com.roc.bookshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.roc.bookshop.bean.Order;
import com.roc.bookshop.bean.OrderVo;

public interface OrderMapper {
	// 通过订单查询类查找订单（uId/status）
	List<Order> selectOrderByOrderVo(OrderVo orderVo);

	// 通过订单查询类查找订单（from，to）
	int selectOrderCountByOrderVo(OrderVo orderVo);

	// 添加生成的订单
	void add(Order order);

	// 加载订单
	Order loadByOid(String oId);

	// 查询订单状态
	Integer findStatusByOid(String oId);

	// 修改订单状态
	void updateStatusByOid(@Param("status") Integer status, @Param("oId") String oId);

	// 查找所有
	List<Order> findAll(OrderVo orderVo);

	// 取得所有订单记录
	int getTotal();

	// 取得dataList,图表用
	List<Map<String, Object>> getCharts();

	// 取得所有成功交易的订单
	List<Order> getOrdersFromStatusOf4();

	// 添加评价
	void evaluate(@Param("oId")String oId, @Param("evaluate")String evaluate);
}
package com.roc.bookshop.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.Order;
import com.roc.bookshop.bean.OrderItem;
import com.roc.bookshop.dao.BookMapper;
import com.roc.bookshop.pager.PageBean;
import com.roc.bookshop.service.OrderService;

@Controller
@RequestMapping("/adminOrder")
public class AdminOrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private BookMapper bookMapper;

	// 获取当前页码
	private int getPageCode(HttpServletRequest request) {
		int pageCode = 1;
		String param = request.getParameter("pageCode");
		if (param != null && !param.trim().isEmpty()) {
			pageCode = Integer.parseInt(param);
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

	// 查询所有
	@RequestMapping("/findAll")
	public String findAll(HttpServletRequest request) {
		int pageCode = getPageCode(request);
		String url = getUrl(request);
		PageBean<Order> pb = orderService.findAll(pageCode);
		pb.setUrl(url);
		request.setAttribute("pb", pb);
		return "adminjsps/admin/order/list";
	}

	// 按状态查
	@RequestMapping("/findByStatus")
	public String findByStatus(HttpServletRequest request) {
		Integer status = Integer.parseInt(request.getParameter("status"));
		int pageCode = getPageCode(request);
		String url = getUrl(request);
		PageBean<Order> pb = orderService.findByStatus(status, pageCode);
		pb.setUrl(url);
		request.setAttribute("pb", pb);
		return "adminjsps/admin/order/list";
	}

	// 查看订单详细信息
	@RequestMapping("/load")
	public String loadOrderByOid(HttpServletRequest request) {
		String oId = request.getParameter("oId");
		Order order = orderService.loadOrderByOid(oId);
		request.setAttribute("order", order);
		String btn = request.getParameter("btn");// 声明用户点击哪个超链接来访问本方法
		request.setAttribute("btn", btn);
		return "adminjsps/admin/order/desc";
	}

	// 取消订单
	@RequestMapping("/cancel")
	public String cancel(HttpServletRequest request) {
		// 获取要修改的订单ID
		String oId = request.getParameter("oId");
		// 校验订单状态
		Integer status = orderService.findStatusByOid(oId);
		if (status != 1) {
			request.setAttribute("code", "error");
			request.setAttribute("msg", "订单状态不对，取消失败！");
			return "adminjsps/msg";
		}
		// 订单状态对了再去修改
		orderService.updateStatusByOid(5, oId);// 5取消订单
		// 重新恢复库存
		Order order = orderService.loadOrderByOid(oId);
		List<OrderItem> orderItems = order.getOrderItems();
		Book book = null;
		for (OrderItem orderItem : orderItems) {
			book = orderItem.getBook();
			book.setInventory(book.getInventory() + orderItem.getQuantity());
			bookMapper.updateInventory(book);
		}
		request.setAttribute("code", "success");
		request.setAttribute("msg", "您的订单已取消！！！");
		return "adminjsps/msg";
	}

	// 发货
	@RequestMapping("/deliver")
	public String deliver(HttpServletRequest request) {
		// 获取要修改的订单ID
		String oId = request.getParameter("oId");
		// 校验订单状态
		Integer status = orderService.findStatusByOid(oId);
		if (status != 2) {
			request.setAttribute("code", "error");
			request.setAttribute("msg", "订单状态不对，不能发货！");
			return "adminjsps/msg";
		}
		// 订单状态对了再去修改
		orderService.updateStatusByOid(3, oId);// 5取消订单
		request.setAttribute("code", "success");
		request.setAttribute("msg", "订单已发货！请及时查看物流信息！");
		return "adminjsps/msg";
	}

	// 获取订单统计图表数据
	@RequestMapping("/getCharts")
	@ResponseBody
	public Map<String, Object> getCharts(HttpServletRequest request) {
		orderService.getChartsOfTop5Sale();
		Map<String, Object> map = orderService.getCharts();
		return map;
	}

	// 获取销量柱状图表
	@RequestMapping("/getChartsOfTop5Sale")
	@ResponseBody
	public Map<String, Object> getChartsOfTop5Sale(HttpServletRequest request) {
		Map<String, Object> map = orderService.getChartsOfTop5Sale();
		return map;
	}
}
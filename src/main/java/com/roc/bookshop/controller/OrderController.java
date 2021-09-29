package com.roc.bookshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.CartItem;
import com.roc.bookshop.bean.Order;
import com.roc.bookshop.bean.OrderItem;
import com.roc.bookshop.bean.User;
import com.roc.bookshop.dao.BookMapper;
import com.roc.bookshop.pager.PageBean;
import com.roc.bookshop.service.CartItemService;
import com.roc.bookshop.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private CartItemService cartItemService;
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
		/*
		 * 如果url中存在pc参数，截取掉，如果不存在那就不用截取。
		 */
		int index = url.lastIndexOf("&pageCode=");
		if (index != -1) {
			url = url.substring(0, index);
		}
		return url;
	}

	// 我的订单
	@RequestMapping("/myOrders")
	public String myOrders(HttpServletRequest request) {
		int pageCode = getPageCode(request);
		String url = getUrl(request);
		User user = (User) request.getSession().getAttribute("sessionUser");
		PageBean<Order> pb = orderService.myOrders(user.getUId(), pageCode);
		pb.setUrl(url);
		request.setAttribute("pb", pb);
		return "jsps/order/list";
	}

	// 生成订单
	@RequestMapping("/createOrder")
	public String createOrder(HttpServletRequest request) {
		// 获取所有购物车条目的id，查询得到相应的购物车条目信息
		String cartItemIds = request.getParameter("cartItemIds");
		List<CartItem> cartItems = cartItemService.loadCartItems(cartItemIds);
		// 生成订单
		String address = request.getParameter("address");// 收货地址
		User owner = (User) request.getSession().getAttribute("sessionUser");// 订单所有者
		Order order = orderService.createOrder(cartItems, address, owner);// 添加完毕后的order
		// 删除购物车条目
		cartItemService.batchDelete(cartItemIds);
		// 订单生成后从库存中减去相应数量
		Book book = null;
		for (CartItem cartItem : cartItems) {
			book = cartItem.getBook();
			book.setInventory(book.getInventory() - cartItem.getQuantity());
			bookMapper.updateInventory(book);
		}
		// 保存订单，转发到ordersucc.jsp
		request.setAttribute("order", order);
		/*
		 * ("code", "success"); ("msg", "下单成功!");
		 */
		return "jsps/order/orderSuccess";
	}

	// 加载订单
	@RequestMapping("/loadOrderByOid")
	public String loadOrderByOid(HttpServletRequest request) {
		String evaluate = request.getParameter("evaluate");
		String oId = request.getParameter("oId");
		Order order = orderService.loadOrderByOid(oId);
		request.setAttribute("order", order);
		String btn = request.getParameter("btn");// 声明用户点击哪个超链接来访问本方法
		request.setAttribute("btn", btn);
		if ("1".equals(evaluate)) {
			return "jsps/order/evaluate";
		} else {
			return "jsps/order/desc";
		}
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
			return "jsps/msg";
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
		return "jsps/msg";
	}

	// 确认收货
	@RequestMapping("confirm")
	public String confirm(HttpServletRequest request) {
		// 获取要修改的订单ID
		String oId = request.getParameter("oId");
		// 校验订单状态
		Integer status = orderService.findStatusByOid(oId);
		if (status != 3) {
			request.setAttribute("code", "error");
			request.setAttribute("msg", "订单状态不对，无法收货！");
			return "jsps/msg";
		}
		// 订单状态对了再去修改
		orderService.updateStatusByOid(4, oId);// 4交易成功
		request.setAttribute("code", "success");
		request.setAttribute("msg", "交易完成！");
		request.setAttribute("status", 4);
		request.setAttribute("oId", oId);
		return "jsps/msg";
	}

	// 支付前准备（跳转到支付页面）
	@RequestMapping("/paymentPre")
	public String paymentPre(HttpServletRequest request) {
		request.setAttribute("order", orderService.loadOrderByOid(request.getParameter("oId")));
		return "jsps/order/pay";
	}

	// 支付
	@RequestMapping("/payment")
	public String payment(HttpServletRequest request) {
		String oId = request.getParameter("oId");// 订单编号
		orderService.updateStatusByOid(2, oId);
		request.setAttribute("code", "success");
		request.setAttribute("msg", "支付成功！");
		return "jsps/msg";
	}

	// 评价订单
	@RequestMapping("/evaluate")
	public String evaluate(Order order, HttpServletRequest request) {
		orderService.evaluate(order.getoId(), order.getEvaluate());
		request.setAttribute("code", "success");
		request.setAttribute("msg", "评价完成，祝您阅读愉快！");
		return "jsps/msg";
	}
}
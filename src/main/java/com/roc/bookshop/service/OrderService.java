package com.roc.bookshop.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.CartItem;
import com.roc.bookshop.bean.Order;
import com.roc.bookshop.bean.OrderItem;
import com.roc.bookshop.bean.OrderVo;
import com.roc.bookshop.bean.User;
import com.roc.bookshop.dao.BookMapper;
import com.roc.bookshop.dao.OrderItemMapper;
import com.roc.bookshop.dao.OrderMapper;
import com.roc.bookshop.pager.PageBean;
import com.roc.bookshop.pager.PageConstants;
import com.roc.bookshop.utils.CommonUtils;

@Service
public class OrderService {
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private OrderItemMapper orderItemMapper;
	@Autowired
	private BookMapper bookMapper;
	// 订单分页条
	private int pageSize = PageConstants.ORDER_PAGE_SIZE;

	// 我的订单
	public PageBean<Order> myOrders(String uId, int pageCode) {
		OrderVo orderVo = new OrderVo();
		orderVo.setuId(uId);
		orderVo.setFrom((pageCode - 1) * pageSize);
		orderVo.setTo(pageSize);
		List<Order> orderList = orderMapper.selectOrderByOrderVo(orderVo);
		for (Order order : orderList) {
			List<OrderItem> orderItemList = orderItemMapper.selectOrderItemByOrderId(order.getoId());
			for (OrderItem orderItem : orderItemList) {
				Book book = bookMapper.selectBookByBid(orderItem.getBook().getbId());
				orderItem.setBook(book);
			}
			order.setOrderItems(orderItemList);
		}
		int totalRecord = orderMapper.selectOrderCountByOrderVo(orderVo);
		PageBean<Order> pb = new PageBean<Order>();
		pb.setBeanList(orderList);
		pb.setPageCode(pageCode);
		pb.setPageSize(pageSize);
		pb.setTotalRecord(totalRecord);
		return pb;
	}

	// 生成订单
	public Order createOrder(List<CartItem> cartItems, String address, User owner) {
		// 创建order
		Order order = new Order();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		order.setoId(CommonUtils.uuid());// 主键
		order.setOrderTime(date);// 下单时间
		order.setAddress(address);// 收货地址
		order.setOwner(owner);// 订单所有者
		order.setStatus(1);// 订单状态，1未付款
		BigDecimal total = new BigDecimal("0");// 精度问题，需要借助BigDecimal
		for (CartItem cartItem : cartItems) {
			total = total.add(new BigDecimal(cartItem.getSubtotal() + ""));
		}
		order.setTotal(total.doubleValue());// 总计价格
		orderMapper.add(order);
		// 创建List<OrderItem>，一个CartItem对应一个OrderItem
		List<OrderItem> orderItems = new ArrayList<OrderItem>();
		for (CartItem cartItem : cartItems) {
			OrderItem orderItem = new OrderItem();
			orderItem.setOrderItemId(CommonUtils.uuid());// 主键
			orderItem.setQuantity(cartItem.getQuantity());// 数量
			orderItem.setSubTotal(cartItem.getSubtotal());// 小计
			orderItem.setBook(cartItem.getBook());// 图书
			orderItem.setOrder(order);// 所属订单
			orderItemMapper.add(orderItem);// 插入订单条目
			orderItems.add(orderItem);
		}
		order.setOrderItems(orderItems);
		// 添加完毕后返回order
		return order;
	}

	// 加载订单
	public Order loadOrderByOid(String oId) {
		Order order = orderMapper.loadByOid(oId);
		List<OrderItem> orderItems = orderItemMapper.selectOrderItemByOrderId(oId);
		for (OrderItem orderItem : orderItems) {
			Book book = bookMapper.selectBookByBid(orderItem.getBook().getbId());
			orderItem.setBook(book);
		}
		order.setOrderItems(orderItems);
		return order;
	}

	// 查询订单状态
	public Integer findStatusByOid(String oId) {
		return orderMapper.findStatusByOid(oId);
	}

	// 修改订单状态
	public void updateStatusByOid(Integer status, String oId) {
		orderMapper.updateStatusByOid(status, oId);
	}

	// 查询所有
	public PageBean<Order> findAll(int pageCode) {
		OrderVo orderVo = new OrderVo();
		orderVo.setFrom((pageCode - 1) * pageSize);
		orderVo.setTo(pageSize);
		List<Order> orderList = orderMapper.findAll(orderVo);
		for (Order order : orderList) {
			List<OrderItem> orderItemList = orderItemMapper.selectOrderItemByOrderId(order.getoId());
			for (OrderItem orderItem : orderItemList) {
				Book book = bookMapper.selectBookByBid(orderItem.getBook().getbId());
				orderItem.setBook(book);
			}
			order.setOrderItems(orderItemList);
		}
		int totalRecord = orderMapper.selectOrderCountByOrderVo(orderVo);
		PageBean<Order> pb = new PageBean<Order>();
		pb.setBeanList(orderList);
		pb.setPageCode(pageCode);
		pb.setPageSize(pageSize);
		pb.setTotalRecord(totalRecord);
		return pb;
	}

	// 按状态查
	public PageBean<Order> findByStatus(Integer status, int pageCode) {
		OrderVo orderVo = new OrderVo();
		orderVo.setStatus(status);
		orderVo.setFrom((pageCode - 1) * pageSize);
		orderVo.setTo(pageSize);
		List<Order> orderList = orderMapper.selectOrderByOrderVo(orderVo);
		for (Order order : orderList) {
			List<OrderItem> orderItemList = orderItemMapper.selectOrderItemByOrderId(order.getoId());
			for (OrderItem orderItem : orderItemList) {
				Book book = bookMapper.selectBookByBid(orderItem.getBook().getbId());
				orderItem.setBook(book);
			}
			order.setOrderItems(orderItemList);
		}
		int totalRecord = orderMapper.selectOrderCountByOrderVo(orderVo);
		PageBean<Order> pb = new PageBean<Order>();
		pb.setBeanList(orderList);
		pb.setPageCode(pageCode);
		pb.setPageSize(pageSize);
		pb.setTotalRecord(totalRecord);
		return pb;
	}

	// 获取订单统计图表数据
	public Map<String, Object> getCharts() {
		// 取得total
		int total = orderMapper.getTotal();
		// 取得dataList
		List<Map<String, Object>> selectDataList = orderMapper.getCharts();
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> map : selectDataList) {
			Map<String, Object> map2 = new HashMap<String,Object>();
			map2.put("value", map.get("value"));
			Integer status = (Integer) map.get("name");
			if (status == 1) {
				map2.put("name", "未付款");
			} else if (status == 2) {
				map2.put("name", "已付款");
			} else if (status == 3) {
				map2.put("name", "已发货");
			} else if (status == 4) {
				map2.put("name", "交易成功");
			} else if (status == 5) {
				map2.put("name", "已取消");
			}
			dataList.add(map2);
		}
		// 将total和dataList保存到map中
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total",total);
		map.put("dataList",dataList);
		// 返回map
		return map;
	}

	// 获取销量前五/十
	public Map<String, Object> getChartsOfTop5Sale() {
		List<Order> successOrders = orderMapper.getOrdersFromStatusOf4();
		Map<String, Object> map = new HashMap<String, Object>();
		for (Order order : successOrders) {
			System.out.println("order: " + order);
			List<OrderItem> orderItems = orderItemMapper.selectOrderItemByOrderId(order.getoId());
			for (OrderItem orderItem : orderItems) {
				System.out.println("orderItemBook: " + orderItem.getBook().getbName());
				Integer quantity = orderItem.getQuantity();
				if (map.get(orderItem.getBook().getbId()) != null) {
					Integer _quantity = (Integer) map.get(orderItem.getBook().getbId());
					map.put(orderItem.getBook().getbId(), quantity + _quantity);
				} else {
					map.put(orderItem.getBook().getbId(), quantity);
				}
			}
		}
		Map<String, Object> map2 = new HashMap<String, Object>();
		for (Entry<String, Object> entry : map.entrySet()) {
            System.out.println("key = " + entry.getKey() + ", value = " + entry.getValue());
            Book book = bookMapper.selectBookByBid(entry.getKey());
            map2.put(book.getbName(), entry.getValue());
        }
		return map2;
	}

	// 评价
	public void evaluate(String oId, String evaluate) {
		orderMapper.evaluate(oId, evaluate);
	}
}
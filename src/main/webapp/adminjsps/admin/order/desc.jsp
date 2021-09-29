<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>订单详细</title>
	<link rel="stylesheet" type="text/css" href="adminjsps/admin/css/order/desc.css">
</head>
<body>
	<div class="divOrder">
		<span>订单号：${oder.oId} <c:choose>
				<c:when test="${order.status eq 1}">(等待付款)</c:when>
				<c:when test="${order.status eq 2}">(准备发货)</c:when>
				<c:when test="${order.status eq 3}">(等待确认)</c:when>
				<c:when test="${order.status eq 4}">(交易成功)</c:when>
				<c:when test="${order.status eq 5}">(已取消)</c:when>
			</c:choose> 下单时间：${order.orderTime}
		</span>
	</div>
	<div class="divRow">
		<div class="divContent">
			<dl>
				<dt>收货人信息</dt>
				<dd>${order.address}</dd>
			</dl>
		</div>
		<div class="divContent">
			<dl>
				<dt>商品清单</dt>
				<dd>
					<table cellpadding="0" cellspacing="0">
						<tr>
							<th class="tt">商品名称</th>
							<th class="tt" align="left">单价</th>
							<th class="tt" align="left">数量</th>
							<th class="tt" align="left">小计</th>
						</tr>
						<c:forEach items="${order.orderItems}" var="orderItem">
							<tr style="padding-top: 20px; padding-bottom: 20px;">
								<td class="td" width="400px">
									<div class="bookname">
										<img align="middle" width="70" src="${orderItem.book.imageB}" />
										${orderItem.book.bName}
									</div>
								</td>
								<td class="td">
									<span>&yen;${orderItem.book.currPrice}</span>
								</td>
								<td class="td"><span>${orderItem.quantity}</span></td>
								<td class="td"><span>&yen;${orderItem.subTotal}</span></td>
							</tr>
						</c:forEach>
					</table>
				</dd>
			</dl>
		</div>
		<div class="divBtn">
			<span class="spanTotal">合 计：</span> <span class="price_t">&yen;${order.total}</span><br />
			<c:if test="${order.status eq 2 and btn eq 'deliver'}">
				<a id="deliver" href="adminOrder/deliver?oId=${order.oId}">发货</a>
			</c:if>
			<c:if test="${order.status eq 1 and btn eq 'cancel'}">
				<a id="cancel" href="adminOrder/cancel?oId=${order.oId}">取消</a>
			</c:if>
		</div>
		<c:if test="${not empty order.evaluate}">
			<b>评价</b><br/>
			<p>${order.evaluate}</p>
		</c:if>
	</div>
</body>
</html>
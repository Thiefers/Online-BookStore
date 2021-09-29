<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详细</title>
<link rel="stylesheet" type="text/css" href="jsps/css/order/desc.css">
</head>
<body>
	<div class="divOrder">
		<span>订单号：${order.oId} <c:choose>
				<c:when test="${order.status eq 1}">(等待付款)</c:when>
				<c:when test="${order.status eq 2}">(准备发货)</c:when>
				<c:when test="${order.status eq 3}">(等待确认)</c:when>
				<c:when test="${order.status eq 4}">(交易成功)</c:when>
				<c:when test="${order.status eq 5}">(已取消)</c:when>
			</c:choose> 下单时间：${order.orderTime}
		</span>
	</div>
	<div class="divContent">
		<div class="div2">
			<dl>
				<dt>收货人信息</dt>
				<dd>${order.address}</dd>
			</dl>
		</div>
		<div class="div2">
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
						<c:forEach items="${order.orderItems}" var="item">
							<tr style="padding-top: 20px; padding-bottom: 20px;">
								<td class="td" width="400px">
									<div class="bookname">
										<img align="middle" width="70" src="${item.book.imageB}" />
										<a href="book/load?bId=${item.book.bId}">${item.book.bName}</a>
									</div>
								</td>
								<td class="td"><span>&yen;${item.book.currPrice}</span></td>
								<td class="td"><span>${item.quantity}</span></td>
								<td class="td"><span>&yen;${item.subTotal}</span></td>
							</tr>
						</c:forEach>
					</table>
				</dd>
			</dl>
		</div>
		<div style="margin: 10px 10px 10px 550px;">
			<span style="font-weight: 900; font-size: 15px;">合计金额：</span>
			<span class="price_t">&yen;${order.total}</span><br />
			<c:if test="${order.status eq 1}">
				<a href="order/paymentPre?oId=${order.oId}" class="pay"></a><br />
			</c:if>
			<c:if test="${order.status eq 1 and btn eq 'cancel'}">
				<a id="cancel" href="order/cancel?oId=${order.oId}">取消订单</a><br />
			</c:if>
			<c:if test="${order.status eq 3 and btn eq 'confirm'}">
				<a id="confirm" href="order/confirm?oId=${order.oId}">确认收货</a><br />
			</c:if>
		</div>
		<c:if test="${not empty order.evaluate}">
			<b>评价</b><br/>
			<p>${order.evaluate}</p>
		</c:if>
	</div>
</body>
</html>
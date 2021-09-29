<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单列表</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="jsps/css/order/list.css" />
</head>
<body>
	<div class="divMain">
		<div class="divTitle">
			<span style="margin-left: 150px; margin-right: 280px;">商品信息</span>
			<span style="margin-left: 40px; margin-right: 38px;">金额</span>
			<span style="margin-left: 50px; margin-right: 40px;">订单状态</span>
			<span style="margin-left: 50px; margin-right: 50px;">操作</span>
		</div>
		<br />
		<table align="center" border="0" width="100%" cellpadding="0" cellspacing="0">
			<c:forEach items="${pb.beanList}" var="order">
				<tr class="tt">
					<td width="330px">订单号：
						<a href="order/loadOrderByOid?oId=${order.oId}">${order.oId}</a>
					</td>
					<td width="200px">
						下单时间：${order.orderTime}
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr style="padding-top: 10px; padding-bottom: 10px;">
					<td colspan="2">
						<c:forEach items="${order.orderItems}" var="orderItem">
							<a class="link2" href="book/load?bId=${orderItem.book.bId}">
								<img border="0" width="70" src="${orderItem.book.imageB}" />
							</a>
						</c:forEach>
					</td>
					<td width="115px">
						<span class="price_t">&yen;${order.total}</span>
					</td>
					<td width="142px">
						<c:choose>
							<c:when test="${order.status eq 1}">(等待付款)</c:when>
							<c:when test="${order.status eq 2}">(准备发货)</c:when>
							<c:when test="${order.status eq 3}">(等待确认)</c:when>
							<c:when test="${order.status eq 4}">(交易成功)</c:when>
							<c:when test="${order.status eq 5}">(已取消)</c:when>
						</c:choose>
					</td>
					<td>
						<a href="order/loadOrderByOid?oId=${order.oId}">查看</a><br />
						<c:if test="${order.status eq 4 and empty order.evaluate}">
							<a href="order/loadOrderByOid?oId=${order.oId}&evaluate=1" target="body">填写评价</a>
							<br/>
						</c:if>
						<c:if test="${order.status eq 1}">
							<a href="order/paymentPre?oId=${order.oId}">支付</a>
							<br />
							<a href="order/loadOrderByOid?oId=${order.oId}&btn=cancel">取消</a>
							<br />
						</c:if>
						<c:if test="${order.status eq 3}">
							<a href="order/loadOrderByOid?oId=${order.oId}&btn=confirm">确认收货</a>
							<br />
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<br />
		<%@include file="/jsps/pager/pager_bs.jsp"%>
	</div>
</body>
</html>
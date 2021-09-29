<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OrderSuccess</title>
<link rel="stylesheet" type="text/css" href="jsps/css/order/orderSuccess.css">
</head>
<body>
	<div class="div1">
		<span class="span1">订单已生成</span>
	</div>
	<div class="div2">
		<img src="images/duihao.jpg" class="img" />
		<dl>
			<dt>订单编号</dt>
			<dd>${order.oId}</dd>
			<dt>合计金额</dt>
			<dd>
				<span class="price_t">&yen;${order.total}</span>
			</dd>
			<dt>收货地址</dt>
			<dd>${order.address}</dd>
		</dl>
		<span>融创书城感谢您的支持，祝您购物愉快！</span>
		<a href="order/paymentPre?oId=${order.oId}" id="linkPay">支付</a>
	</div>
</body>
</html>
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
<title>结算</title>
<link rel="stylesheet" type="text/css" href="jsps/css/cart/showItem.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="js/round.js"></script>
<style type="text/css">
#addr {
	width: 500px;
	height: 32px;
	border: 1px solid #7f9db9;
	padding-left: 10px;
	line-height: 32px;
}
</style>
</head>
<body>
	<form id="form1" action="order/createOrder" method="post">
		<input type="hidden" name="cartItemIds" value="${cartItemIds}" />
		<table width="95%" align="center" cellpadding="0" cellspacing="0">
			<tr bgcolor="#efeae5">
				<td width="400px" colspan="5">
					<span style="font-weight: 900;">生成订单</span>
				</td>
			</tr>
			<tr align="center">
				<td width="10%">&nbsp;</td>
				<td width="50%">图书名称</td>
				<td>单价</td>
				<td>数量</td>
				<td>小计</td>
			</tr>
			<c:forEach items="${cartItems}" var="cartItem">
				<tr align="center">
					<td align="right">
						<a class="linkImage" href="book/load?bId=${cartItem.book.bId}">
							<img border="0" width="54" align="top" src="${cartItem.book.imageB}" />
						</a>
					</td>
					<td align="left">
						<a href="book/load?bId=${cartItem.book.bId}">
							<span>${cartItem.book.bName}</span>
						</a>
					</td>
					<td>&yen;${cartItem.book.currPrice}</td>
					<td>${cartItem.quantity}</td>
					<td>
						<span class="price_n">&yen;
							<span class="subtotal">${cartItem.subtotal}</span>
						</span>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="6" align="right">
					<span>总计：</span>
					<span class="price_t">&yen;
						<span id="total">${total}</span>
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="5" bgcolor="#efeae5">
					<span style="font-weight: 900">收货地址</span>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<input id="addr" type="text" name="address" value="广州市 番禺区 小谷围街道 广州大学城 GDPU 张小虎" />
				</td>
			</tr>
			<tr>
				<td style="border-top-width: 4px;" colspan="5" align="right">
					<a id="linkSubmit" href="javascript:$('#form1').submit();">提交订单</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
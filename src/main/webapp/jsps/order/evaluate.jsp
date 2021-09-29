<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
	<script src="jquery/jquery-3.5.1.min.js"></script>
	<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="jsps/css/order/desc.css">
	<title>evaluate</title>
	<script type="text/javascript">
		$(function(){
			$("#evaluateBtn").click(function(){
				var txt = $("#evaluateText").val();
				if (txt) {
					$("#evaluateForm").submit();
				} else {
					alert("评价内容不可为空！");
				}
			});
		})
	</script>
</head>
<body>
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
		</div>
		<!-- 评价表单 -->
		<form action="order/evaluate" id="evaluateForm">
			<input type="hidden" name="oId" value="${order.oId}"/>
			<b>评价：</b><input type="text" id="evaluateText" name="evaluate" style="width: 600px;"/>
			<input type="button" id="evaluateBtn" class="btn btn-primary btn-xs" value="提交"/>
		</form>
		<!-- 评价表单 -->
	</div>
</body>
</html>
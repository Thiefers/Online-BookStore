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
<title>购物车</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="jsps/css/cart/list.css?a=<%=System.currentTimeMillis()%>">
<script type="text/javascript" src="js/round.js"></script>
<script type="text/javascript" src="jsps/js/cart/list.js?a=<%=System.currentTimeMillis()%>"></script>
</head>
<body>
	<c:choose>
		<c:when test="${empty cartItemList}">
			<table width="95%" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td align="right"><img align="top" src="images/icon_empty.png" />
					</td>
					<td><span class="spanEmpty">您的购物车中暂时没有商品</span></td>
				</tr>
			</table>
		</c:when>
		<c:otherwise>
			<table width="95%" align="center" cellpadding="0" cellspacing="0">
				<tr align="center" bgcolor="#efeae5">
					<td align="left" width="50px">
						<input type="checkbox" id="selectAll" checked /><label for="selectAll">全选</label>
					</td>
					<td colspan="2">商品名称</td>
					<td>单价</td>
					<td>数量</td>
					<td>小计</td>
					<td>操作</td>
				</tr>
				<tbody id="cartitemBody">
					<c:forEach items="${cartItemList}" var="cartItem">
						<tr align="center">
							<!-- 独自复选框 -->
							<td align="left">
								<input value="${cartItem.cartitemId}" type="checkbox" name="checkboxBtn" checked="checked" />
							</td>
							<!-- 商品名称：图片加书名 -->
							<td align="left" width="70px">
								<a class="linkImage" href="book/load?bId=${cartItem.book.bId}">
									<img border="0" width="54" align="top" src="${cartItem.book.imageB}" />
								</a>
							</td>
							<td align="left" width="400px">
								<a href="book/load?bId=${cartItem.book.bId}">
									<span>${cartItem.book.bName}</span>
								</a>
							</td>
							<!-- 单价 -->
							<td>
								<span>&yen; <span class="currPrice">${cartItem.book.currPrice}</span></span>
							</td>
							<!-- 数量 -->
							<td>
								<a class="jian" id="${cartItem.cartitemId}Jian"></a>
								<input class="quantity" readonly="readonly" id="${cartItem.cartitemId}Quantity" type="text" value="${cartItem.quantity}" />
								<a class="jia" id="${cartItem.cartitemId}Jia"></a>
							</td>
							<!-- 小计 -->
							<td width="100px">
								<span class="price_n">&yen;<span class="subTotal" id="${cartItem.cartitemId}Subtotal">${cartItem.subtotal}</span></span>
							</td>
							<!-- 操作 -->
							<td>
								<a href="cartItem/batchDelete?cartItemIds=${cartItem.cartitemId}">删除</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tr>
					<td colspan="4" class="tdBatchDelete">
						<a href="javascript:batchDelete();">批量删除</a>
					</td>
					<td colspan="3" align="right" class="tdTotal">
						<span>总计：</span><span class="price_t">&yen;<span id="total"></span></span>
					</td>
				</tr>
				<tr>
					<td colspan="7" align="right">
						<a href="javascript:jiesuan();" id="jiesuan" class="jiesuan"></a>
					</td>
				</tr>
			</table>
			<form id="jieSuanForm" action="cartItem/loadCartItems" method="post">
				<input type="hidden" name="cartItemIds" id="cartItemIds"/>
				<input type="hidden" name="total" id="hiddenTotal"/>
			</form>
		</c:otherwise>
	</c:choose>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书详细</title>
<script src="jquery/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="jsps/css/book/desc.css">
<script src="jsps/js/book/desc.js"></script>
<script type="text/javascript">
	$(function(){
		
	});

	function checkInventory(){
		var inventory = ${book.inventory};
		var buyCnt = $("#cnt").val();
		if(buyCnt > inventory){
			alert("数量超出范围~");
			return;
		} else if(buyCnt <= 0) {
			alert("数量低于范围~");
		} else {
			$('#form1').submit();
		}
	}
</script>
</head>
<body>
	<div class="divBookName">${book.bName}</div>
	<div>
		<img align="top" src="${book.imageW}"
			class="img_image_w" />
		<div class="divBookDesc">
			<ul>
				<li>商品编号：${book.bId}</li>
				<li>融创价：<span class="price_n">&yen;${book.currPrice}</span></li>
				<li>定价：<span class="spanPrice">&yen;${book.price}</span> 折扣：<span
					style="color: #c30;">${book.discount}</span>折
				</li>
			</ul>
			<hr class="hr1" />
			<table>
				<tr>
					<td colspan="3">作者：${book.author} 著</td>
				</tr>
				<tr>
					<td colspan="3">出版社：${book.press}</td>
				</tr>
				<tr>
					<td colspan="3">出版时间：${book.publishTime}</td>
				</tr>
				<tr>
					<td>版次：${book.edition}</td>
					<td>页数：${book.pageNum}</td>
					<td>字数：${book.wordNum}</td>
				</tr>
				<tr>
					<td width="180">印刷时间：${book.printTime}</td>
					<td>开本：${book.bookSize}开</td>
					<td>纸张：${book.paper}</td>
				</tr>
				<tr>
					<td>库存：${book.inventory}</td>
				</tr>
			</table>
			<div class="divForm">
				<form id="form1" action="cartItem/add" method="post">
					<input type="hidden" name="bId" value="${book.bId}" />
					我要买：<input id="cnt" style="width: 40px; text-align: center;" type="text" name="quantity" value="1" />件
				</form>
<!-- 				<a id="btn" href="javascript:$('#form1').submit();"></a> -->
				<a id="btn" href="javascript:checkInventory();"></a>
			</div>
		</div>
	</div>
</body>
</html>
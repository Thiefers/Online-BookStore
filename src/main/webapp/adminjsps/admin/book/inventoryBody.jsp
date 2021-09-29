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
		<title>Book_Inventory_Body</title>
		<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
		<script src="jquery/jquery-3.5.1.min.js"></script>
		<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="css/css.css">
		<script type="text/javascript">
			/* 点击修改库存按钮事件 */
			function changeInventory(bId) {
				changeInventoryBtn(true);//暂时禁用添加库存按钮
				var tdID = $("#"+bId+"Td").attr("id");
				var inventory = $("#"+bId+"Inventory").text();
				$("#"+tdID).empty();
				var html = "";
				html += "<b>库存: </b>";
				html += "<form id='"+bId+"changeInventoryForm' class='changeInventoryForm' style='display:inline-block;'>";
				html += "<input id='inventoryText' type='text' placeholder='余:"+inventory+"' style='width: 48px;'/> ";
				html += "<button id='"+bId+"checkInventoryBtn' onclick='checkInventory(\""+bId+"\")' type='button' class='btn btn-success btn-xs checkInventoryBtn'>";
				html += "<span class='glyphicon glyphicon-ok' style='padding-bottom: 3px;'></span>";
				html += "</button>";
				html += "</form>";
				$("#"+tdID).html(html);
			}
			/* 修改按钮状态 */
			function changeInventoryBtn(status){
				$("button").attr("disabled",status);
			}
			function checkInventory(bId){
				var inventory = $("#inventoryText").val();
				if (!inventory || inventory < 0) {
					alert("输入非法，最少请输入“0”");
					return false;
				}
				$.ajax({
					async : true,
					cache : false,
					url : "/ssm-bookshop/adminBook/ajaxUpdateInventory",
					data : {
						bId : bId,
						inventory : inventory
					},
					type : "POST",
					dataType : "json",
					success : function(result){
						/* console.log(result.bId);
						console.log(result.inventory); */
						var bId = result.bId;
						var tdID = $("#"+bId+"Td").attr("id");
						var inventory = result.inventory;
						$("#"+tdID).empty();
						var html = "";
						html += "<b>库存: </b>";
						if (inventory < 1) {
							html += "<span id='"+bId+"Inventory'><font color='red'>售罄</font></span> ";
						} else {
							html += "<span id='"+bId+"Inventory'>"+inventory+"</span> ";
						}
						html += "<button id='"+bId+"ChangeInventoryBtn' onclick='changeInventory(\""+bId+"\")' type='button' class='btn btn-info btn-xs changeInventoryBtn'>";
						html += "<span class='glyphicon glyphicon-plus' style='padding-bottom: 3px;'></span>";
						html += "</button>";
						$("#"+tdID).html(html);
						changeInventoryBtn(false);
					}
				})
			}
			
			/* 修改图书销售状态 */
			function changeSale(bookId,saleStatus){
				$.ajax({
					async : true,
					cache : false,
					url : "/ssm-bookshop/adminBook/ajaxChangeSaleStatus",
					data : {
						bId : bookId,
						onSale : saleStatus
					},
					type : "POST",
					dateType : "json",
					success : function(result){
						var resBookId = result.bId;
						var resSaleStatus = result.onSale;
						if (resSaleStatus) {
							var statusColor = "blue";
							var statusText = "在售";
							var operateText = "下架";
							var buttonClass = "btn-danger";
						} else {
							var statusColor = "red";
							var statusText = "待售";
							var operateText = "上架";
							var buttonClass = "btn-info";
						}
						$("#"+resBookId).empty();
						var html = "";
						html += "<span>";
						html += "<font color="+statusColor+">"+statusText+"</font> ";
						html += '<a href="javascript:changeSale(\''+resBookId+'\',\''+resSaleStatus+'\');">';
						html += "<button class='btn "+buttonClass+" btn-xs'>";
						html += operateText;
						html += "</button>";
						html += "</a>";
						html += "</span>";
						$("#"+resBookId).html(html);
					}
				});
			}
		</script>
	</head>
	<body>
		<c:if test="${empty pb}">
			<h1 align="center">图书库存/上架/下架管理</h1>
		</c:if>
		<c:if test="${not empty pb }">
			<!-- inventory list begin -->
			<table class="table"><!--  table-bordered table-hover-->
				<c:forEach items="${pb.beanList}" var="book">
					<tr style="background-color: #efeae5;">
						<td>
							<a href="adminBook/load?bId=${book.bId}">
								<button class="btn btn-primary btn-xs">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								</button>
							</a>
							<b>图书号：</b>
							<a href="adminBook/load?bId=${book.bId}">${book.bId}&nbsp;</a>
						</td>
						<td width="260px" id="${book.bId}Td">
							<b>库存:</b>
							<c:if test="${book.inventory lt 1}">
								<span id="${book.bId}Inventory"><font color="red">售罄</font></span>
							</c:if>
							<c:if test="${book.inventory gt 0}">
								<span id="${book.bId}Inventory">${book.inventory}</span>
							</c:if>
							<button id="${book.bId}ChangeInventoryBtn" onclick="changeInventory('${book.bId}')" type="button" class="btn btn-info btn-xs changeInventoryBtn">
								<span class="glyphicon glyphicon-plus" style="padding-bottom: 3px;"></span>
							</button>
						</td>
						<td id="${book.bId}">
							<c:if test="${book.onSale}">
									<span>
										<font color="blue">在售</font>
										<a href="javascript:changeSale('${book.bId}','${book.onSale}');">
											<button class="btn btn-danger btn-xs">
												下架
											</button>
										</a>
									</span>
							</c:if>
							<c:if test="${not book.onSale}">
									<span>
										<font color="red">待售</font>
										<a href="javascript:changeSale('${book.bId}','${book.onSale}');">
											<button class="btn btn-info btn-xs">
												上架
											</button>
										</a>
									</span>
							</c:if>
						</td>
					</tr>
					<tr style="padding-top: 10px; padding-bottom: 10px;">
						<td colspan="3">
							<img border="0" width="70" src="${book.imageB}" />
							<span>${book.bName} | ${book.author} | ${book.press}</span>
						</td>
					</tr>
				</c:forEach>
			</table>
			<!-- inventory list end -->

			<!-- navigation begin -->
			<%@ include file="/jsps/pager/pager_bs.jsp"%>
			<!-- navigation end -->
		</c:if>
	</body>
</html>
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
	<title>图书详细</title>
	<link rel="stylesheet" type="text/css" href="adminjsps/admin/css/book/desc.css?a=<%=System.currentTimeMillis()%>">
	<!-- <link rel="stylesheet" type="text/css" href="jquery/bootstrap-datetimepicker.min.css"> -->
	<script type="text/javascript" src="jquery/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<!-- <script type="text/javascript" src="jquery/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker.zh-CN.js"></script> -->
	
	<script type="text/javascript" src="adminjsps/admin/js/book/desc.js?a=<%=System.currentTimeMillis()%>"></script>
	
	<script type="text/javascript">
		$(function() {
			$("#box").prop("checked", false);
			$("#formDiv").css("display", "none");
			$("#show").css("display", "");
	
			// 操作和显示切换
			$("#box").click(function() {
				if ($(this).prop("checked")) {
					$("#show").css("display", "none");
					$("#formDiv").css("display", "");
				} else {
					$("#formDiv").css("display", "none");
					$("#show").css("display", "");
				}
			});
			/* $("#publishTime").click(function(){
				$("#publishTime").datetimepicker({
					minView: "month",
		            language:  'zh-CN',
		            format: 'yyyy-mm-dd',
		            autoclose: true,
		            todayBtn: true,
		            pickerPosition: "top-right"
				});
			});
			$("#printTime").click(function(){
				$("#printTime").datetimepicker({
					minView: "month",
		            language:  'zh-CN',
		            format: 'yyyy-mm-dd',
		            autoclose: true,
		            todayBtn: true,
		            pickerPosition: "top-right"
				});
			}); */
		});
	
		function loadChildren() {
			/*
			1. 获取pId
			2. 发出异步请求，功能之：
			  3. 得到一个数组
			  4. 获取cId元素(<select>)，把内部的<option>全部删除
			  5. 添加一个头（<option>请选择2级分类</option>）
			  6. 循环数组，把数组中每个对象转换成一个<option>添加到cId中
			 */
			// 1. 获取pId
			var pId = $("#pId").val();
			// 2. 发送异步请求
			$.ajax({
				async : true,
				cache : false,
				url : "/ssm-bookshop/adminBook/ajaxFindChildren",
				data : {
					pId : pId
				},
				type : "POST",
				dataType : "json",
				success : function(arr) {
					// 3. 得到cId，删除它的内容
					$("#cId").empty();//删除元素的子元素
					$("#cId").append($("<option>====请选择2级分类====</option>"));//4.添加头
					// 5. 循环遍历数组，把每个对象转换成<option>添加到cId中
					for (var i = 0; i < arr.length; i++) {
						var option = $("<option>").val(arr[i].cId).text(arr[i].cName);
						$("#cId").append(option);
					}
				}
			});
		}
	
		/*
		 * 点击编辑按钮时执行本函数
		 */
		function editForm() {
			// 对内容进行校验，通过校验后再提交修改
			var bName = $("#bName").val();
			var currPrice = $("#currPrice").val();
			var inventory = $("#inventory").val();
			var price = $("#price").val();
			var discount = $("#discount").val();
			var author = $("#author").val();
			var press = $("#press").val();
			var publishTime = $("#publishTime").val();
			var edition = $("#edition").val();
			var pageNum = $("#pageNum").val();
			var wordNum = $("#wordNum").val();
			var printTime = $("#printTime").val();
			var bookSize = $("#bookSize").val();
			var paper = $("#paper").val();
			if(!bName || !currPrice || !price || !inventory || !discount || !author || !press || !publishTime || !edition || !pageNum || !wordNum || !printTime || !bookSize || !paper) {
				alert("书名/当前价/定价/库存/折扣/作者/出版社/出版时间/版次/页数/字数/印刷时间/开本/纸张不能为空！");
				return false;
			}
			if(isNaN(currPrice) || isNaN(price) || isNaN(discount)) {
				alert("当前价/定价/折扣必须是合法小数！");
				return false;
			}
			if(currPrice<=0 || inventory<=0 || price<=0 || discount<=0 || edition<=0 || pageNum<=0 || wordNum<=0 || bookSize<=0){
				alert("当前价/库存/定价/折扣/版次/页数/字数/开本不合法,请重新检查输入~");
				return false;
			}
			$("#form").attr("action","adminBook/edit");
			$("#form").submit();
		}
		/*
		 * 点击删除按钮时执行本函数
		 */
		function deleteForm() {
			$("#form").attr("action","adminBook/delete");
			$("#form").submit();
		}
	</script>
</head>

<body>
	<c:if test="${sessionScope.admin.adminIdentity eq 'manager'}">
		<input type="checkbox" id="box">
		<label for="box">编辑或删除</label>
	</c:if>
	<br /><br />
	<!-- 展示 -->
	<div id="show">
		<div class="sm">${book.bName }</div>
		<img align="top" src="${book.imageW }" class="tp" />
		<div id="book" style="float: left;">
			<ul>
				<li>商品编号：${book.bId }</li>
				<li>
					当前价：<span class="price_n">&yen;${book.currPrice }</span>
					库存：<span>${book.inventory}</span>
				</li>
				<li>定价：<span style="text-decoration: line-through;">&yen;${book.price }</span>
					折扣：<span style="color: #c30;">${book.discount }</span>折
				</li>
			</ul>
			<hr style="margin-left: 50px; height: 1px; color: #dcdcdc" />
			<table class="tab">
				<tr>
					<td colspan="3">作者：${book.author }著</td>
				</tr>
				<tr>
					<td colspan="3">出版社：${book.press }<!-- </a> -->
					</td>
				</tr>
				<tr>
					<td colspan="3">出版时间：${book.publishTime }</td>
				</tr>
				<tr>
					<td>版次：${book.edition }</td>
					<td>页数：${book.pageNum }</td>
					<td>字数：${book.wordNum }</td>
				</tr>
				<tr>
					<td width="180">印刷时间：${book.printTime }</td>
					<td>开本：${book.bookSize }开</td>
					<td>纸张：${book.paper }</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 编辑 -->
	<div id='formDiv'>
		<div class="sm">&nbsp;</div>
		<form method="post" id="form">
			<input type="hidden" name="bId" value="${book.bId }" />
			<img align="top" src="${book.imageW }" class="tp" />
			<div style="float: left;">
				<ul>
					<li>商品编号：${book.bId }</li>
					<li>
						书名： <input id="bName" type="text" name="bName" value="${book.bName }" style="width: 500px;" />
					</li>
					<li>
						当前价：<input id="currPrice" type="text" name="currPrice" value="${book.currPrice}" style="width: 50px;" />
						库存：<input id="inventory" type="text" name="inventory" value="${book.inventory}" style="width: 50px;" />
					</li>
					<li>
						定价： <input id="price" type="text" name="price" value="${book.price }" style="width: 50px;" /> 
						折扣：<input id="discount" type="text" name="discount" value="${book.discount }" style="width: 30px;" />折
					</li>
				</ul>
				<hr style="margin-left: 50px; height: 1px; color: #dcdcdc" />
				<table class="tab">
					<tr>
						<td colspan="3">
							作者： <input id="author" type="text" name="author" value="${book.author }" style="width: 150px;" />
						</td>
					</tr>
					<tr>
						<td colspan="3">
							出版社： <input id="press" type="text" name="press" value="${book.press }" style="width: 200px;" />
						</td>
					</tr>
					<tr>
						<td colspan="3">
							出版时间：<input id="publishTime" type="text" name="publishTime" value="${book.publishTime }" style="width: 170px;" />
						</td>
					</tr>
					<tr>
						<td>
							版次： <input id="edition" type="text" name="edition" value="${book.edition }" style="width: 40px;" />
						</td>
						<td>
							页数： <input id="pageNum" type="text" name="pageNum" value="${book.pageNum }" style="width: 50px;" />
						</td>
						<td>
							字数： <input id="wordNum" type="text" name="wordNum" value="${book.wordNum }" style="width: 80px;" />
						</td>
					</tr>
					<tr>
						<td width="250px">
							印刷时间：<input id="printTime" type="text" name="printTime" value="${book.printTime }" style="width: 170px;" />
						</td>
						<td width="250px">
							开本： <input id="bookSize" type="text" name="bookSize" value="${book.bookSize }" style="width: 30px;" />
						</td>
						<td>
							纸张： <input id="paper" type="text" name="paper" value="${book.paper }" style="width: 80px;" />
						</td>
					</tr>
					<tr>
						<td>
							一级分类：
							<select name="pId" id="pId" onchange="loadChildren()">
								<option value="">==请选择1级分类==</option>
								<c:forEach items="${parents }" var="parent">
									<option value="${parent.cId }" <c:if test="${pId eq parent.cId }">selected="selected"</c:if>>${parent.cName }</option>
								</c:forEach>
							</select>
						</td>
						<td>
							二级分类：
							<select name="cId" id="cId">
								<option value="">==请选择2级分类==</option>
								<c:forEach items="${children }" var="child">
									<option value="${child.cId }" <c:if test="${book.cId eq child.cId }">selected="selected"</c:if>>${child.cName }</option>
								</c:forEach>
							</select>
						</td>
						<td>
							状态：
							<input type="radio" name="onSale" value="0" <c:if test="${book.onSale eq false}">checked="checked"</c:if> />下架
							<input type="radio" name="onSale" value="1" <c:if test="${book.onSale eq true}">checked="checked"</c:if> />上架
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input onclick="editForm()" type="button" name="method" id="editBtn" class="btn" value="编　　辑">
							<input onclick="deleteForm()" type="button" name="method" id="delBtn" class="btn" value="删　　除">
						</td>
						<td></td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</body>
</html>
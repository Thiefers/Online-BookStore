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
    <title>Add Page</title>
	<link rel="stylesheet" type="text/css" href="adminjsps/admin/css/book/add.css">
	<!-- <link rel="stylesheet" type="text/css" href="jquery/bootstrap-datetimepicker.min.css"> -->
	<script type="text/javascript" src="jquery/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<!-- <script type="text/javascript" src="jquery/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker.zh-CN.js"></script> -->
	<script type="text/javascript">
	$(function () {
		/* $("#publishTime").click(function(){
			$("#publishTime").datetimepicker({
				minView: "month",
	            language:  'zh-CN',
	            format: 'yyyy-mm-dd',
	            autoclose: true,
	            todayBtn: true,
	            pickerPosition: "top-right"
			});
		}); */
		/* $("#printTime").click(function(){
			$("#printTime").datetimepicker({
				minView: "month",
	            language:  'zh-CN',
	            format: 'yyyy-mm-dd',
	            autoclose: true,
	            todayBtn: true,
	            pickerPosition: "top-right"
			});
		}); */

		$("#btn").addClass("btn1");
		$("#btn").hover(
			function() {
				$("#btn").removeClass("btn1");
				$("#btn").addClass("btn2");
			},
			function() {
				$("#btn").removeClass("btn2");
				$("#btn").addClass("btn1");
			}
		);
		
		$("#btn").click(function() {
			var bName = $("#bName").val();
			var currPrice = $("#currPrice").val();
			var inventory = $("#inventory").val();
			var price = $("#price").val();
			var discount = $("#discount").val();
			var author = $("#author").val();
			var press = $("#press").val();
			var pId = $("#pId").val();
			var cId = $("#cId").val();
			var imageW = $("#imageW").val();
			var imageB = $("#imageB").val();
			var edition = $("#edition").val();
			var pageNum = $("#pageNum").val();
			var wordNum = $("#wordNum").val();
			var bookSize = $("#bookSize").val();
			var paper = $("#paper").val();
			var publishTime = $("#publishTime").val();
			var printTime = $("#printTime").val();
			if(!bName || !currPrice || !price || !inventory || !discount || !author || !press || !pId || !cId || !imageW || !imageB || !edition || !pageNum || !wordNum || !bookSize || !paper || !publishTime || !printTime) {
				alert("书名/现价/定价/数量/折扣/作者/出版社/1级分类/2级分类/大图/小图/版次/页数/字数/开本/纸张/出版时间/印刷时间不能为空！");
				return false;
			}
			if(isNaN(currPrice) || isNaN(price) || isNaN(discount)) {
				alert("现价/定价/折扣必须是合法小数！");
				return false;
			}
			$("#form").submit();
		});
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
			async:true,
			cache:false,
			url:"/ssm-bookshop/adminBook/ajaxFindChildren",
			data:{pId:pId},
			type:"POST",
			dataType:"json",
			success:function(arr) {
				// 3. 得到cId，删除它的内容
				$("#cId").empty();//删除元素的子元素
				$("#cId").append($("<option>====请选择2级分类====</option>"));//4.添加头
				// 5. 循环遍历数组，把每个对象转换成<option>添加到cId中
				for(var i = 0; i < arr.length; i++) {
					var option = $("<option>").val(arr[i].cId).text(arr[i].cName);
					$("#cId").append(option);
				}
			}
		});
	}
	</script>
</head>

<body>
	<div>
		<p style="font-weight: 900; color: red;">${msg }</p>
		<form action="adminBook/addBook" enctype="multipart/form-data" method="post" id="form">
			<div>
				<ul>
					<li>书名： 
						<input id="bName" type="text" name="bName" value="Spring实战(第3版)（In Action系列中最畅销的Spring图书，近十万读者学习Spring的共同选择）" style="width: 500px;" />
					</li>
					<li>大图： <input id="imageW" type="file" name="imageWW" /></li>
					<li>小图： <input id="imageB" type="file" name="imageBB" /></li>
					<li>
						现价：
						<input id="currPrice" type="text" name="currPrice" value="40.7" style="width: 50px;" />
						数量：
						<input id="inventory" type="text" name="inventory" value="100" style="width: 50px;"/>
					</li>
					<li>
						定价：
						<input id="price" type="text" name="price" value="59.0" style="width: 50px;" />
						折扣：
						<input id="discount" type="text" name="discount" value="6.9" style="width: 30px;" />折
					</li>
				</ul>
				<hr style="margin-left: 50px; height: 1px; color: #dcdcdc" />
				<table>
					<tr>
						<td colspan="3">
							作者： <input type="text" id="author" name="author" value="Craig Walls" style="width: 150px;" />
						</td>
					</tr>
					<tr>
						<td colspan="3">
							出版社： <input type="text" name="press" id="press" value="人民邮电出版社" style="width: 200px;" />
						</td>
					</tr>
					<tr>
						<td colspan="3">
							出版时间：<input type="datetime-local" id="publishTime" name="publishTime" value="" style="width: 170px;" />
						</td>
					</tr>
					<tr>
						<td>
							版次： <input type="text" name="edition" id="edition" value="1" style="width: 40px;" />
						</td>
						<td>
							页数： <input type="text" name="pageNum" id="pageNum" value="374" style="width: 50px;" />
						</td>
						<td>
							字数： <input type="text" name="wordNum" id="wordNum" value="48700" style="width: 80px;" />
						</td>
					</tr>
					<tr>
						<td width="250">
							印刷时间：<input type="datetime-local" name="printTime" id="printTime" value="" style="width: 170px;" />
						</td>
						<td width="250">
							开本： <input type="text" name="bookSize" id="bookSize" value="16" style="width: 30px;" />
						</td>
						<td>
							纸张： <input type="text" name="paper" id="paper" value="胶版纸" style="width: 80px;" />
						</td>
					</tr>
					<tr>
						<td>
							一级分类：
							<select name="pId" id="pId" onchange="loadChildren()">
								<option value="">===请选择1级分类===</option>
								<c:forEach items="${parents }" var="parent">
									<option value="${parent.cId }">${parent.cName }</option>
								</c:forEach>
							</select>
						</td>
						<td>
							二级分类：
							<select name="cId" id="cId">
								<option value="">===请选择2级分类===</option>
							</select>
						</td>
						<td>
							立即上架：
							<input type="radio" id="upNow" name="onSale" value="1" checked/>是
							<input type="radio" id="upLater" name="onSale" value="0"/>否
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" id="btn" class="btn" value="新书入库">
						</td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</body>
</html>
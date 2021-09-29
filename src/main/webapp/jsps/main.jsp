<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线书城</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		/* 选中标签项状态切换 */
		ajaxCategory();
	});
	function showChildrenCategory(ele){
		if(ele == "init"){
			$('#myChildrenTabs li').each(function(){
				$(this).hide();
			});
			return;
		} else {
			if(ele.hasClass("active")){
				$('#myChildrenTabs li').each(function(){
					if($(this).attr('class') == ele.attr('id')){
						$(this).show();
					} else {
						$(this).hide();
					}
				});
			}
		}
	}
	function ajaxCategory(){
		$.ajax({
			url : "/ssm-bookshop/category/findAll",
			type : "POST",
			dataType : "json",
			async : false,
			cache : false,
			success : function(result) {
				var categoryHtml = "";
 				$.each(result,function(i,n){
 					categoryHtml += "<ul style='list-style: none;' class='nav nav-list'>";
 					categoryHtml += "<li>";
 					categoryHtml += "<a href='#"+n.cId+"' class='nav-header collapsed' data-toggle='collapse' style='text-decoration: none;'>"+n.cName+"</a>";
 					categoryHtml += "<ul id='"+n.cId+"' class='nav nav-list collapse'>";
 					$.each(n.children,function(i,n2){
 						categoryHtml += "<li class='second-li "+n2.pId+"' role='presentation'><a target='body' href='book/findByCategory?cId="+n2.cId+"'>"+n2.cName+"</a></li>";
 					})
					categoryHtml += "</ul>";
 					categoryHtml += "</li>";
					categoryHtml += "</ul>";
				});
 				$("#parentDiv").html(categoryHtml);
			}
		});
	}
</script>
<style type="text/css">
	.second-li{
		padding-left: 10px;
	}
</style>
</head>
<body>
	<!-- 导航条 -->
	<%@ include file="header.jsp" %>
	<!-- 导航条 -->

	<!-- 书籍分类展示区 -->
	<!-- action="category/findAll" -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2" id="parentDiv">
			</div>
			<div class="col-sm-10">
				<div class="row">
					<!-- 书籍展示区 -->
					<div class="col-sm-12">
						<div class="embed-responsive embed-responsive-16by9">
						  <iframe class="embed-responsive-item" src="jsps/body.jsp" name="body"></iframe>
						</div>
					</div>
					<!-- 书籍展示区 -->
				</div>
			</div>
		</div>
	</div>
	<!-- 书籍分类展示区 -->
	<%-- <%@ include file="footer.jsp" %> --%>
</body>
</html>
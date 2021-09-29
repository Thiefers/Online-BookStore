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
<title>图书</title>
<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="jsps/css/book/list.css?a=<%=System.currentTimeMillis()%>">
</head>
<body>
	<!-- 书籍展示区 -->
		<!-- repeat -->
		<c:forEach items="${pb.beanList}" var="book">
			<div class="col-sm-6 col-md-3" style="height: 310px;">
				<div class="thumbnail" style="height: 300px;overflow:hidden;text-overflow:ellipsis;word-break:keep-all;white-space:nowrap;">
				    <a class="pic" href="book/load?bId=${book.bId}"><img src="${book.imageB}" border="0"/></a>
				    <p class="price">
						<span class="price_n">&yen;${book.currPrice}</span>
						<span class="price_r">&yen;${book.price}</span>
						(<span class="price_s">${book.discount}折</span>)
					</p>
					<p><a id="bookname" title="${book.bName}" href="book/load?bId=${book.bId}">${book.bName}</a></p>
					<p><a href="book/findByAuthor?author=${book.author}" name='P_zz' title='${book.author}'>${book.author}</a></p>
					<p class="publishing">
						<span>出 版 社：</span><a href="book/findByPress?press=${book.press}">${book.press}</a>
					</p>
					<p class="publishing_time"><span>出版时间：</span>${book.publishTime}</p>
				</div>
			</div>
		</c:forEach>
		<!-- repeat -->
	<!-- 书籍展示区 -->

	<!-- 分页导航条 -->
	<%@ include file="../pager/pager_bs.jsp" %>
	<!-- 分页导航条 -->
</body>
</html>
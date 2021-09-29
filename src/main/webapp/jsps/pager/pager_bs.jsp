<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-sm-12">
	<div class="container">
		<div class="row">
			<div class="col-sm-offset-6 col-sm-6">
				<nav>
					<ul class="pagination">
						<!-- 首页，上一页 -->
						<c:choose>
							<c:when test="${pb.pageCode eq 1}">
								<li class="disabled">
<!-- 									<a href="#" class="btn disabled" style="height: 31px;">首页</a> -->
									<a href="#">首页</a>
								</li>
								<li class="disabled">
									<a href="#" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="${pb.url}&pageCode=1">首页</a>
								</li>
								<li>
									<a href="${pb.url}&pageCode=${pb.pageCode-1}" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:otherwise>
						</c:choose>
						<!-- 首页，上一页 -->

						<!-- 页码 -->
						<c:choose>
							<c:when test="${pb.totalPage <= 5 }">
								<c:set var="begin" value="1" />
								<c:set var="end" value="${pb.totalPage }" />
							</c:when>
							<c:otherwise>
								<c:set var="begin" value="${pb.pageCode-2 }" />
								<c:set var="end" value="${pb.pageCode + 2}" />
								<c:if test="${begin < 1 }">
									<c:set var="begin" value="1" />
									<c:set var="end" value="5" />
								</c:if>
								<c:if test="${end > pb.totalPage }">
									<c:set var="begin" value="${pb.totalPage-4 }" />
									<c:set var="end" value="${pb.totalPage }" />
								</c:if>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="${begin}" end="${end}" var="i">
							<c:choose>
								<c:when test="${i eq pb.pageCode}">
									<li class="active"><span>${i}</span></li>
								</c:when>
								<c:otherwise>
									<li><a href="${pb.url}&pageCode=${i}" class="aBtn">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- 页码 -->

						<!-- 末页，下一页 -->
						<c:choose>
							<c:when test="${pb.pageCode eq pb.totalPage}">
								<li class="disabled">
									<a href="#" aria-label="Previous">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
								<li class="disabled">
									<a href="#">末页</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="${pb.url}&pageCode=${pb.pageCode+1}" aria-label="Previous">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
								<li>
									<a href="${pb.url}&pageCode=${pb.totalPage}">末页</a>
								</li>
							</c:otherwise>
						</c:choose>
						<!-- 末页，下一页 -->
					</ul>
				</nav>
		 	</div>
		</div>
	</div>
</div>
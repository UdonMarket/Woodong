<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<input type="hidden" value="${state}" name="stateflag"/>

<div class="col-md-9" style="padding-top: 37px">
	<div class="row" id="board">
	
	  <!-- 상품 리스트 반복 start-->
		<c:forEach items="${lists}" var="row">	
			<div class="col-4">
                
				<div class="productList_div">
					<img class="productList_image" src="${pageContext.request.contextPath }/resources/img/120ben.jpg" alt="" />
				</div>
				<div>
					<h3> <a href="./productView.woo?idx=${row.idx}&nowPage=${param.nowPage}">${row.title}</a></h3>
				</div>
				<div>
					<h4>${row.price}</h4>
				</div>
				<div>
					<h4>${row.idx}</h4>
				</div>
			</div>
		 </c:forEach>   
                 <!-- 상품 리스트 반복 end-->
	</div>
</div>

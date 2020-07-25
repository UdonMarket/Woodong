<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<input type="hidden" value="${state}" name="stateflag"/>


	
  <!-- 상품 리스트 반복 start-->
		<c:forEach items="${lists}" var="row">	
			<div class="col-4">
				<div class="productList_div">
					<img class="productList_image" src="../resources/Upload/${row.imagefile}" />
				</div>
			 	<c:if test="${row.like_check eq 1}"><!-- 빨간하트 -->
					<img src="../resources/img/1.png" width="30px;" height="30px" name = "${list.idx}" onclick="like_toggle(${row.idx})"/>
				</c:if> 
				 <c:if test="${row.like_check ne 1}"><!-- 빈하트 --> 
					<img src="../resources/img/2.png" width="30px;" height="30px" name = "${list.idx}" onclick="like(${row.idx})"/>
				</c:if> 
				<div>
					<h3> <a href="./productView.woo?idx=${row.idx}&nowPage=${param.nowPage}">${row.title}</a></h3>
				</div>
				<div>
					<h4>${row.price} 원 ( idx : ${row.idx})</h4>
				</div>
			</div>
		 </c:forEach>   
   <!-- 상품 리스트 반복 end-->

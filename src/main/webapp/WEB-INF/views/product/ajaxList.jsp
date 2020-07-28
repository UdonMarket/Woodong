<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<input type="hidden" value="${state}" name="stateflag"/>

  <!-- 상품 리스트 반복 start-->
		<c:forEach items="${lists}" var="row">	
			<div class="col-4">
				<a href="./productView.woo?idx=${row.boardidx}&nowPage=${param.nowPage}">
					<div class="productList_div">
					<c:if test="${user_id ne null}">
						<c:if test="${row.like_check eq 1}"><!-- 빨간하트 --><!-- 클릭시 좋아요 해제 -->
							<img src="../resources/img/1.png" width="30px;" height="30px" name = "${row.boardidx}" id ="redHeart" onclick="like_toggle(${row.boardidx})"/>
						</c:if> 
						 <c:if test="${row.like_check ne 1}"><!-- 빈하트 --> <!-- 클릭시 좋아요 -->
							<img src="../resources/img/2.png" width="30px;" height="30px" name = "${row.boardidx}" id ="whiteHeart" onclick="like_toggle(${row.boardidx})"/>
						</c:if> 
					</c:if>
						<img class="productList_image" src="../resources/Upload/${row.imagefile}" />
					</div>
					<div>
						<h3>${row.title}</h3>
					</div>
					<div>
						<h4>${row.price} 원 ( idx : ${row.boardidx})</h4>
					</div>
				</a>
			</div>
		 </c:forEach>   
   <!-- 상품 리스트 반복 end-->

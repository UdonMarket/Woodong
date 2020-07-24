<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>	
function like_toggle(idx) {
	var like_flag;
	if($("img[name=" + idx + "]").attr('src')=="../resources/img/2.png"){
		like_flag = 1;
	}
	else{
		like_flag = -1;
	}
	var str = "";
	str += idx + "#";
	$.ajax({
		url : "../mypage/like_toggle.woo",
		type:"get",
	    contentType:"text/html;charset:utf-8",
	    data:{idx : idx, like_flag : like_flag, str : str},
 	  	success : function(d) {
 	  		if($("img[name=" + idx + "]").attr('src')=="../resources/img/2.png"){
 	  			$("img[name=" + idx + "]").attr('src', "../resources/img/1.png");
 			}
 			else{
 				$("img[name=" + idx + "]").attr('src', "../resources/img/2.png");
 			}
		},
		error : function(request,status,error) {
	          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	});
}
</script>

<input type="hidden" value="${state}" name="stateflag"/>

<div class="col-md-9" style="padding-top: 37px">
	<div class="row" id="board">
	
	  <!-- 상품 리스트 반복 start-->
		<c:forEach items="${lists}" var="row">	
			<div class="col-4">
                
				<div class="productList_div">
				<c:if test="${user_id ne null}">
				 	<c:if test="${row.like_check eq 1}"><!-- 빨간하트 --><!-- 클릭시 좋아요 해제 -->
						<img src="../resources/img/1.png" width="30px;" height="30px" name = "${row.idx}" id ="redHeart" onclick="like_toggle(${row.idx})"/>
					</c:if> 
					 <c:if test="${row.like_check ne 1}"><!-- 빈하트 --> <!-- 클릭시 좋아요 -->
						<img src="../resources/img/2.png" width="30px;" height="30px" name = "${row.idx}" id ="whiteHeart" onclick="like_toggle(${row.idx})"/>
					</c:if> 
				</c:if>
					<img class="productList_image" src="${pageContext.request.contextPath }/resources/img/회색우동.png" alt="" />
				</div>
				<div>
					<h3> <a href="./productView.woo?idx=${row.idx}&nowPage=${param.nowPage}">${row.title}</a></h3>
				</div>
				<div>
					<h4>${row.price} 원 ( idx : ${row.idx})</h4>
				</div>
			</div>
		 </c:forEach>   
                 <!-- 상품 리스트 반복 end-->
	</div>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script>	
	
function like(idx) {
	var str = "";
	str += idx + "#";
	$.ajax({
		url : "./ajaxLike.woo",
		type:"get",
	    contentType:"text/html;charset:utf-8",
	    data:{str : str, idx : idx},

		success : function (d) {
			alert("DB update성공");
			 location.reload();
		},
		error : errFunc
	    });
}

function errFunc(resData) {
	alert("DB update에러");
}

function like_toggle(idx) {
	$.ajax({
		url : "../mypage/like_toggle.woo",
		type:"get",
	    contentType:"text/html;charset:utf-8",
	    data:{idx : idx},
 	  	success : function(d) {
 		/*  if(d.like_check == 1){
				//이미지 바꾸기 (빈하트)
				$("img[name=" + idx + "]").attr('src', "../resources/img/2.png");
			}
			else{
				$("img[name=" + idx + "]").attr('src', "../resources/img/1.png");
			} */
 			restartFunc();
 	
		},
		error : function(request,status,error) {
			//alert("이미지 토글 실패" + error.status);
	          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	});
}

function restartFunc(){  
    location.reload();
}

</script>

<input type="hidden" value="${state}" name="stateflag"/>

<div class="col-md-9" style="padding-top: 37px">
	<div class="row" id="board">
	
	  <!-- 상품 리스트 반복 start-->
		<c:forEach items="${lists}" var="row">	
			<div class="col-4">
                
				<div class="productList_div">
				
				
			<%-- 	 	<c:if test="${row.like_check eq 1}"><!-- 빨간하트 -->
						<img src="../resources/img/1.png" width="30px;" height="30px" name = "${list.idx}" onclick="like_toggle(${list.idx},1);"/>
					</c:if> 
					 <c:if test="${row.like_check ne 1}"><!-- 빈하트 --> 
						<img src="../resources/img/2.png" width="30px;" height="30px" name = "${list.idx}" onclick="like_toggle(${list.idx});"/>
					</c:if>  --%>
	
			
				 	<c:if test="${row.like_check eq 1}"><!-- 빨간하트 -->
						<img src="../resources/img/1.png" width="30px;" height="30px" name = "${list.idx}" onclick="like_toggle(${row.idx})"/>
					</c:if> 
					 <c:if test="${row.like_check ne 1}"><!-- 빈하트 --> 
						<img src="../resources/img/2.png" width="30px;" height="30px" name = "${list.idx}" onclick="like(${row.idx})"/>
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

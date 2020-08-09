<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zxx">
<style>
	.score img{
		float:left;
		display: inline-block;
		white-space: nowrap;
		
	}
</style>
<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>

<body>
   <!--::header part start::-->
   <!-- header.jsp --> 
    <jsp:include page="../include/hearder.jsp"/>
   <!-- Header part end-->

      <!-- banner part start-->
   <section class="banner_part" style="margin-bottom: -50px;">
      <div class="container-fluid">
            <img src="../resources/img/main/우동메인1.png" alt="" id="main" style="height: 100%; width: 100%">
            
            <script>
            var timerMode = window.setInterval("fnContinue()", 3000);
            var count = 1; 
            
            function fnContinue() {
               if(count == 1){
                  document.getElementById("main").src = "../resources/img/main/우동메인1.png";
                  count++;
               } 
               else if(count == 2){
                  document.getElementById("main").src = "../resources/img/main/우동메인2.png";
                  count++;;
               }
               else{
                  document.getElementById("main").src = "../resources/img/main/우동메인3.png";
                  count = 1;
               }
            } 
            </script>
         </div>
   </section>
   
   <!-- 상품 보여주기 수정부분 -->
   <section class="trending_items" style="padding-top: 0px;margin-top: -80px;">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="section_tittle text-center">
                  <img src="../resources/img/main/우동마켓인기매물1.png" alt="최신매물" style="width: 450px;"/>
               </div>
            </div>
	<c:forEach items="${searchLists}" var="row">	
				<div class="col-4">
					<a href="javascript:void(0);" onclick="ajaxView(${row.boardidx })">
						<div class="productList_div" style="width: 300px;height: 300px;">
							<img class="productList_image" src="../resources/Upload/${row.imagefile}" style="padding-top: 20px;;"/>
						</div>
						<div style="text-align: left;display: inline-block; width: 300px;">
							<h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;margin: 0">${row.title }</h3>
						</div>
						<div style="text-align: left;width: 300px;padding-bottom: 20px;">
							<h4 style="margin: 0"><fmt:formatNumber type="number" maxFractionDigits="3" value="${row.price}"/>원</h4>
						</div>
					</a>
				</div>
		 </c:forEach> 
			</div>
		 </div>
		   
	</section>
 
   <!--top place start-->
   <section class="client_review section_padding1">
      <div class="container">
         <div class="row ">
            <div class="col-lg-12" style="text-align: center;">
               <div class="section_tittle text-center" style="margin-top: 50px;">
                  <img src="../resources/img/main/우동마켓사용자후기1.png" alt="후기" style="width: 500px;"/>
               </div>
            </div>
         </div>
         
         <div class="row">
            <div class="col-lg-12">
               <div class="client_review_slider owl-carousel">
         <c:forEach var="list" items="${riviewList }">
                  <div class="single_review_slider" style="height: 290px;">
       				 <div class="place_review" style="width: 35px; height: 35px; white-space: nowrap; float: left;">${list.score}</div>
                     <div style="padding-top: 20px; height: 75%; ">
                     <p style="padding-top:10px; overflow:hidden; text-overflow: ellipsis;display:-webkit-box;-webkit-line-clamp: 4; -webkit-box-orient: vertical; word-wrap:break-word;  line-height: 27px;  height: 108px;">
                      ${list.contents}
                        </p>
                     </div>
                     <h5 style="font-weight: bold; padding-top: 35px;">- ${list.buyer_id} - </h5>
                     
                  </div>
         </c:forEach>
               </div>
            </div>
         </div>
      </div>
   </section>
   <!--top place end-->

   <!-- feature part here -->
   <section class="feature_part section_padding1" style="padding-top: 100px;" >
      <div class="container">
         <div class="row justify-content-between" style="padding-bottom: 50px; padding-top:0px;">
            <div class="col-lg-12">
               <div class="feature_part_tittle text-center ">
                  <img src="../resources/img/main/우동마켓은이런점이달라요1.png" alt="우동마켓의 차이점" style="width: 650px;"/>
               </div>
            </div>
         </div>
         <div class="container">
               <div class="row justify-content-between" style="padding-right: 50px;">
                   <div class="col-lg-12">
                       <img src="../resources/img/about/소개페이지2.png" alt="소개" />
                   </div>
               </div>
            </div>
        </div>
   </section>
   <!-- feature part end -->
    <!-- bottom.jsp -->
    <jsp:include page="../include/bottom.jsp"/>
    <jsp:include page="../include/sidebar.jsp"/>
</body>

</html>


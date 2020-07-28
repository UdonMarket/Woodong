<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zxx">

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
		<div class="container" style="padding-left: 20px;">
			<div class="row">
				<div class="col-lg-12">
					<div class="section_tittle text-center">
						<img src="../resources/img/main/우동마켓인기매물1.png" alt="최신매물" style="width: 450px;"/>
					</div>
				</div>

			<c:forEach items="${searchLists}" var="row">	
				<div class="col-4" ">
					<a href="./productView.woo?idx=${row.boardidx}">
						<div class="productList_div" style="width: 300px;height: 300px;">
							<img class="productList_image" src="../resources/Upload/${row.imagefile}" style="padding-top: 20px;;"/>
						</div>
						<div style="text-align: left;display: inline-block; width: 300px;">
							<h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;margin: 0">${row.title }</h3>
						</div>
						<div style="text-align: left;width: 300px;padding-bottom: 20px;">
							<h4 style="margin: 0">${row.price} 원</h4>
						</div>
					</a>
				</div>
		 </c:forEach> 
			</div>
		 </div>
		   
	</section>
	<!-- trending item end-->


	<!-- client review part here -->
	<!--  <section class="client_review">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="client_review_slider owl-carousel">
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="../resources/img/client.png" alt="#">
                            </div>
                            <p>"Working in conjunction with humanitarian aid agencies, we have supported programmes to help alleviate human suffering.</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="../resources/img/client_1.png" alt="#">
                            </div>
                            <p>"Working in conjunction with humanitarian aid agencies, we have supported programmes to help alleviate human suffering.</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="../resources/img/client_2.png" alt="#">
                            </div>
                            <p>"Working in conjunction with humanitarian aid agencies, we have supported programmes to help alleviate human suffering.</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section> -->
	<!-- client review part end -->

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
						<div class="single_review_slider">
							<div class="place_review">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</div>
							<p>Waters make fish every without firmament saw had. Morning
								air subdue. Our Air very one whales grass is fish whales winged
								night yielding land creeping that seed</p>
							<h5>- 장채훈</h5>
							
						</div>
						<div class="single_review_slider">
							<div class="place_review">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</div>
							<p>Waters make fish every without firmament saw had. Morning
								air subdue. Our Air very one whales grass is fish whales winged
								night yielding land creeping that seed</p>
							<h5>- Allen Miller</h5>
							
						</div>
						<div class="single_review_slider">
							<div class="place_review">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</div>
							<p>Waters make fish every without firmament saw had. Morning
								air subdue. Our Air very one whales grass is fish whales winged
								night yielding land creeping that seed</p>
							<h5>- Allen Miller</h5>
							
						</div>
						<div class="single_review_slider">
							<div class="place_review">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</div>
							<p>Waters make fish every without firmament saw had. Morning
								air subdue. Our Air very one whales grass is fish whales winged
								night yielding land creeping that seed</p>
							<h5>- Allen Miller</h5>
							
						</div>
						<div class="single_review_slider">
							<div class="place_review">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</div>
							<p>Waters make fish every without firmament saw had. Morning
								air subdue. Our Air very one whales grass is fish whales winged
								night yielding land creeping that seed</p>
							<h5>- Allen Miller</h5>
							
						</div>
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



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 

<!doctype html>
<html lang="zxx">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />

<body>

<!--우동 파일명 : productView.jsp  -->

<!--::header part start::-->
<!-- header.jsp -->
<jsp:include page="../include/hearder.jsp" />
<!-- Header part end-->

<jsp:include page="../include/productLeft.jsp" />

<!--================Single Product Area =================-->
<div class="col-md-8" style="padding-top: 20px;margin-left: 40px;">

	<!--================End Single Product Area =================-->
	<!-- subscribe part here -->


<%-- 상품 상세보기 추가부분 --%>
<section class="content1" style="padding-top: 0px;">
	<div class="item_list_area" >
		<div class="item_list_area_box">
			<div class="breadcrumbs">
				<ul style="color: #ff4f4f;">
					<li><a href="/" style="color: #ff4f4f;">상품 리스트</a></li>
					<li>
					<a href="/search?category=HAA0000" style="color: #ff4f4f;">&gt;&nbsp;&nbsp;${viewRow.bname}</a></li>
				</ul>
			</div>
			<div class="main_area">
				<div class="main_area_center">
					<div class="main">
						<div class="detail_box">
							<div class="detail_box_top">
								<div class="detail_top_area" style="margin-bottom: 0; height: 450px;">
								<div class="row" style="margin: 0">
									<div id="demo" class="carousel slide col-4" data-ride="carousel">
									  <ul class="carousel-indicators">
									    <li data-target="#demo" data-slide-to="0" class="active"></li>
									    <li data-target="#demo" data-slide-to="1"></li>
									    <li data-target="#demo" data-slide-to="2"></li>
								  		
									  </ul>
								   <form:form name="viewForm" role="form" >
										<input type="hidden"  name="bname" value="${viewRow.bname}" />
										<input type="hidden"  name="boardidx" value="${viewRow.boardidx}" />
									   	<input type="hidden"  name="nowPage" value="${param.nowPage}"> 
									</form:form>
										<%-- <input type="hidden"  name="searchType" value="${param.searchType}"> 
										<input type="hidden"  name="keyword" value="${param.keyword}">  --%>
									  <!-- The slideshow -->
								  <div class="carousel-inner">
									   
								    <c:forEach var="uploadFile" items="${uploadFileList}" varStatus="status">
								    	<c:if test="${status.first}">
									    <div class="carousel-item active">
									      <img src="../resources/Upload/${uploadFile.save_name}" style="width: 100%;" />
									    </div>
									     </c:if>
									   <c:if test="${!status.first}">
									    <div class="carousel-item">
									      <img src="../resources/Upload/${uploadFile.save_name}" style="width: 100%;" />
									    </div>
									     </c:if>
								      </c:forEach>
								  </div>
									  
									  <!-- Left and right controls -->
									  <a class="carousel-control-prev" href="#demo" data-slide="prev">
									    <span class="carousel-control-prev-icon"></span>
									  </a>
									  <a class="carousel-control-next" href="#demo" data-slide="next">
									    <span class="carousel-control-next-icon"></span>
									  </a>
									</div>
									<div class="item_info col-5" >
										<div class="item_title_area">
											<span class="item_tag">
												<span class="used_type_tag">${viewRow.product_state}</span>
												<c:if test="${viewRow.woopay eq 'Y'}">
												<span class="delivery_tag used_type_tag_active  used_type_tag_active">우동페이</span>
												</c:if>
												<span class="wish_box">
													<img src="https://ccimage.hellomarket.com/web/2020/item/ico_zzim_24x23_s_x2.png" alt="찜하기이미지" class="wish_icon">
													<label>${viewRow.likecount}</label>
												</span>
											</span>
										</div>
										<span class="item_title">${viewRow.title}</span>
										<div class="item_price_box item_price_box_bottom" style="width: none; height: 200px;">
											<div class="item_price_box_bottom_low">
												<div class="item_price item_price_bottom">${viewRow.price} 원</div>
											</div>
											<div class="only_description_hellopay common_description_deal">
												<div class="detail_bottom_box" style="margin-bottom:50px; ">
											<div class="detail_bottom_area">
												<img src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_time_x2.png"
													alt="게시물업로드일" class="item_location_img"><span class="time">${viewRow.postdate}</span>
											</div>
											<div class="detail_bottom_area">
												<img src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_location_x2.png"
													alt="지도아이콘" class="item_location_img"><span>${viewRow.latitude}</span><span>${viewRow.longitude}</span>
											</div>
											<div class="detail_bottom_area1 detail_bottom_tag_area" style="margin-left: 10px;">
													<span class="tag" style="color: #ff4f4f;">
														<c:forTokens var="item" items="${viewRow.product_tag}" delims="#">
														<a href="/search?tag=${item}"><button type="button" class="btn_ca">#${item}${viewRow.boardidx}</button></a>
														</c:forTokens>
													</span>
												</div>
											</div>
												<div style="margin-top: 0px;"></div>
												<c:choose>
													<c:when test="${sellingStatus eq '판매전'}">
														<img src="../resources/img/product/상태-판매전.png" style="width: 75px; height: 45px; margin-bottom: -2px;"/>
														<div class="container">
														<div class="progress">
															<div
																class="progress-bar bg-danger progress-bar-striped progress-bar-animated"
																style="width: 6%"></div>
														</div>
													</div>
													</c:when>
													<c:when test="${sellingStatus eq '판매중'}">
														<img src="../resources/img/product/상태-판매중.png" style="width: 75px; height: 45px; margin-bottom: -2px; margin-left: 158px;"/>
														<div class="container">
														<div class="progress">
															<div
																class="progress-bar bg-danger progress-bar-striped progress-bar-animated"
																style="width: 50%"></div>
														</div>
													</div>
													</c:when>
													<c:otherwise>
														<img src="../resources/img/product/상태-판매완료.png" style="width: 90px; height: 45px; margin-bottom: -2px; margin-left: 325px;"/>
														<div class="container">
														<div class="progress">
															<div
																class="progress-bar bg-danger progress-bar-striped progress-bar-animated"
																style="width: 100%"></div>
														</div>
													</div>
													</c:otherwise>
												</c:choose>
													
											<div class=" " style="padding-top:60px;">
												<div class="">
													<div class=" row" >
														
														<div class="col-2" style="padding: 0px;">
														</div>
														<div class="col-4" style="padding:0px;">
														<c:if test="${viewRow.three_dimens eq 'Y'}">
															<img src="../resources/img/product/3d 이미지.png" data-toggle="modal" data-target="#myModal onclick="popupOpen();" style="width: 125px; height: 65px; margin-left: 8px;"/>
														</c:if>
														</div>
														<div class="col-3" style="padding:0px; ">
														<c:if test="${viewRow.woopay eq 'Y'}">
															<img src="../resources/img/product/우동페이.png" />
														</c:if>

														</div>
														<div class="col-3" style="padding: 0px;">
															<img src="../resources/img/product/우동톡톡.png"  onclick="chatting();"/>
														</div>
													</div>
												</div>
											</div>
											</div>
										</div>
									</div>
									</div>
								</div>
								<div class="detail_box_bottom detail_box_item " style="padding-top: 20px;margin: 0;">
									<div class="detail_comment row" style="padding: 20px;">
										<div class="description col-5" style="margin-left: 10px;">
											<div class="description_title1" style="margin-left: -100px;margin-top: -20px;margin-bottom: -20px;">
												<img src="../resources/img/product/상세설명.png" alt="" width="250px;"/>
											</div>
											<div class="detail_item_description">
												<div class="description_text" style="font-size: 1.2em; width:50px; height: 25px;">
														${viewRow.contents}
												</div>
												<div style="margin-top:100px; margin-right: 20px;">
												
												</div>
											</div>
										</div>

										<img src="../resources/img/myPage/삭제.png" style="width: 70px; height: 50px; margin-left:185px;" id="delete_btn" />
										<img src="../resources/img/myPage/수정.png" style="width: 70px; height: 50px;" id="update_btn" />
										<div class="col-4" style="border:1px solid #d9d9d9;width: 200px; height:250px;;margin-left:420px;margin-top:;   ">
											<div class="my_profile_info ">
											<div class="row">
											<div class="col-3" style="margin-bottom:50px;"></div>
												<div class="my_profile_image col-6" style="text-align: center; width: 150px; height: 150px; padding-top: 20px; padding-bottom:20px;  padding-left: px;">
													<a href="../mypage/myPage.woo?mode=review&dealPosition=seller&seller_id=${viewRow.id}&seller_avgscore=${memberVO.avg_score}&score=${score}">${udongGrade }</a>
												</div>
											<div class="col-3" style="padding-bottom: 100px;"></div>
											</div>
												<div class="my_profile_nick" style="text-align: center; font-size:18px; font-weight: bold; padding-bottom: 5px; padding-top: 5px;">판매자 : ${viewRow.id} </div>
												<div class="my_profile_pro_review">
													<div class="my_profile_pro_review_box">
														<a href="../main/write.woo">
															<div class="my_profile_pro_review">
															<div class="my_profile_pro_review_rating" style="white-space: nowrap; width: 40px; height: 20px; padding-left: 20px;">
																<span style="padding-left: 10px; font-size: 15px;">거래후기 : <span style="font-weight: bold;">${memberVO.avg_score}개</span> &nbsp;</span>${score}
															<br />
															<span style="font-size: 15px; padding-left: 10px;">거래횟수 : <span style="font-weight: bold; font-size: 15px;">${memberVO.trade_count} 번</span></span>
															</div>
															<div style="padding-left: 90px" style="font-size: 15px;"></div>
															</div>
														</a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</section>
</div>
<!-- The Modal -->
<div class="modal fade" id="myModal">
     <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">3D이미지</h4>
           <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
<!--3D .product-viewer   -->
              <div class="cd-product-viewer-wrapper" data-frame="16" data-friction="0.33">
				   <div>
				      <figure class="product-viewer">
				        <img src="../resources/img/1.png" class="img-rounded mx-auto d-block" style="width:80%;" >
				         <div class="product-sprite" data-image="../resources/img/1.png"></div>
				      </figure> <!-- .product-viewer -->
				
				      <div class="cd-product-viewer-handle">
				         <span class="fill"></span>
				         <span class="handle">Handle</span>
				      </div>
				   </div> <!-- .cd-product-viewer-handle -->
				</div> <!-- .cd-product-viewer-wrapper -->
<!--3D .product-viewer   -->
        </div>
      </div>
    </div>
  </div>
<!-- The Modal -->
<script>
$(document).ready(function(){
	var formObj = $("[name='viewForm']");
	
	// 수정 
	$("#update_btn").on("click", function(){
		formObj.attr("action", "./productUpdate.woo");
		formObj.attr("method", "post");
		formObj.submit();				
	})
	
	// 삭제
	$("#delete_btn").on("click", function(){
		
		var deleteYN = confirm("삭제하시겠습니까?");
		if(deleteYN){
		formObj.attr("action", "./productDelete.woo");
		formObj.attr("method", "post");
		formObj.submit();
		}
	})
});

function chatting() {
	var chattingFrm = document.chattingFrm;
	window.open('', '1', 'height=640; width=480; top=200; left=150;', true);
	chattingFrm.action = "../chatting/chatting.woo";
	chattingFrm.method = "post";
	chattingFrm.target = "1";
	chattingFrm.testVal = 'test';
	chattingFrm.submit();
}
</script>

<form:form name="chattingFrm">
	<input type="hidden" name="boardidx" value="${viewRow.boardidx }" />
	<input type="hidden" name="sellerid" value="${viewRow.id }" />
</form:form>
<!-- subscribe part end -->
<!-- bottom.jsp -->
<jsp:include page="../include/bottom.jsp" />
<jsp:include page="../include/sidebar.jsp" />

        
      </div>
    </div>
  </div>
 
</body>

</html>

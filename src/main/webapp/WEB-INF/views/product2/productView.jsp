<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />

<body>
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
							<li><a href="/search?category=HAA0000" style="color: #ff4f4f;">&gt; 의류(남성/여성/아동)</a></li>
						</ul>
					</div>
					<div class="main_area">
						<div class="main_area_center">
							<div class="main">
								<div class="detail_box">
									<div class="detail_box_top">
										<div class="detail_top_area" style="margin-bottom: 0">
										<div class="row" style="margin: 0">
											<div id="demo" class="carousel slide col-4" data-ride="carousel">
											  <ul class="carousel-indicators">
											    <li data-target="#demo" data-slide-to="0" class="active"></li>
											    <li data-target="#demo" data-slide-to="1"></li>
											    <li data-target="#demo" data-slide-to="2"></li>
											  </ul>
											  
											  <!-- The slideshow -->
											  <div class="carousel-inner">
											    <div class="carousel-item active">
											      <img src="../resources/img/product.png" alt="Los Angeles" width="100%" >
											    </div>
											    <div class="carousel-item">
											      <img src="../resources/img/product.png" alt="Chicago" width="100%">
											    </div>
											    <div class="carousel-item">
											      <img src="../resources/img/product.png" alt="New York" width="100%" >
											    </div>
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
														<span class="used_type_tag">거의새것</span>
														<span class="delivery_tag used_type_tag_active  used_type_tag_active">우동페이</span>
														<span class="wish_box">
															<img src="https://ccimage.hellomarket.com/web/2020/item/ico_zzim_24x23_s_x2.png" alt="찜하기이미지" class="wish_icon"><label>3</label>
														</span>
													</span>
												</div>
												<span class="item_title">원피스</span>
												<div class="item_price_box item_price_box_bottom" style="width: none;">
													<div class="item_price_box_bottom_low">
														<div class="item_price item_price_bottom">18,000원</div>
													</div>
													<div class="only_description_hellopay common_description_deal">
														<div class="detail_bottom_box">
													<div class="detail_bottom_area">
														<img
															src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_time_x2.png"
															alt="지도아이콘" class="item_location_img"><span
															class="time">1일전</span>
													</div>
													<div class="detail_bottom_area">
														<img
															src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_location_x2.png"
															alt="지도아이콘" class="item_location_img"><span>대구
															북구 복현동</span>
													</div>
													<div class="detail_bottom_area1 detail_bottom_tag_area" style="margin-left: 10px;">
															<span class="tag" style="color: #ff4f4f;">
																<a href="/search?q=앙투">
																	<button type="button" class="btn_ca">#앙투</button>
																</a>
																	<a href="/search?q=롱원피스">
																<button type="button" class="btn_ca">#롱원피스</button>
																</a>
																	<a href="/search?q=7788">
																<button type="button" class="btn_ca">#7788</button>
																</a>
																	<a href="/search?q=앙투">
																<button type="button" class="btn_ca">#앙투</button>
																</a>
																	<a href="/search?q=빅사이즈">
																<button type="button" class="btn_ca">#빅사이즈</button>
																</a>
															</span>
													</div>
													
												</div>

														<div style="margin-top: 0px;"></div>
													</div>
													<div class=" ">
														<div class="">
															<div class=" row">
																<div class="col-3" style="padding: 0;">
																	<button type="button" class="btn_ca1">3D이미지</button>
																</div>
																<div class="col-3" style="padding: 0;">
																	<button type="button" class="btn_ca1">♡찜하기</button>
																</div>
																<div class="col-3" style="padding: 0">
																	<button type="button" class="btn_ca1">우동페이</button>
																</div>
																<div class="col-3" style="padding: 0">
																	<button type="button" class="btn_ca1" onclick="window.open('../main/catting.woo', '_blank', 'height=600; width=480; top=200; left=150;', true);">우동톡톡</button>
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
												<div class="description col-6" style="margin-left: 10px;">
													<div class="description_title1" style="margin-left: -100px;margin-top: -20px;margin-bottom: -20px;">
														<img src="../resources/img/product/상세설명.png" alt="" width="250px;"/>
													</div>
													<div class="detail_item_description">
														<div class="description_text" style="font-size: 1.2em;">
															구매후 같이 산 옷들 입어보고 세탁햇는데
															하필 안입어본 이게 작네요ㅠㅠㅠㅠ정말 세탁만 하고 판매합니다ㅠㅠ색상은 아이보리,77-88까지 되는
															사이즈인데 전 바스크땜에 단추가 안되네요ㅠㅠ앙투에서 판매하는 옷이에요 참고해주세요
														</div>
													</div>
												</div>
												<div class="col-3" style="border:1px solid #d9d9d9;width: 200px;padding: 20px;margin-left: 10px;margin-top: 50px;">
													<div class="my_profile_info ">
														<div class="my_profile_image" style="text-align: center;">
															<img src="../resources/img/myPage/nor-blue.png" alt="우동등급" style="width: 100px;"/>
														</div>
														<div class="my_profile_nick" style="text-align: center;">우동이</div>
														<div class="my_profile_pro_review">
															<div class="my_profile_pro_review_box">
																<a href="../main/write.woo"><span>거래후기</span><span>(0)</span>
																	<div class="my_profile_pro_review_rating" style="text-align: center;">
																		<img src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
																			alt="프로필 별점 없는 이미지 1" />
																		<img src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
																			alt="프로필 별점 없는 이미지 2" />
																		<img src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
																			alt="프로필 별점 없는 이미지 3" />
																		<img src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
																			alt="프로필 별점 없는 이미지 4" />
																		<img src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
																			alt="프로필 별점 없는 이미지 5" />
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
	<!-- subscribe part end -->
	<!-- bottom.jsp -->
	<jsp:include page="../include/bottom.jsp" />
	<jsp:include page="../include/sidebar.jsp" />
</body>

</html>
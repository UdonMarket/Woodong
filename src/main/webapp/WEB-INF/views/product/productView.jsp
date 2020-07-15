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

	<!-- breadcrumb part start
	<section class="breadcrumb_part single_product_breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                    </div>
                </div>
            </div>
        </div> 
    </section>
	breadcrumb part end -->

	<!--================Single Product Area =================-->
	<div class="product_image_area">
		<div class="container">
			<div class="row justify-content-center">
				<!-- <div class="col-lg-12">
					 <div class="product_img_slide owl-carousel">
            <div class="single_product_img">
              <img src="./resources/img/logo.png" alt="#" class="img-fluid">
            </div>
            <div class="single_product_img">
              <img src="./resources/img/logo.png" alt="#" class="img-fluid">
            </div>
            <div class="single_product_img">
              <img src="./resources/img/logo.png" alt="#" class="img-fluid">
            </div>
 -->          </div>
				</div>
				<div class="col-lg-8">
<!-- 					<div class="single_product_text text-center"
						style="color: #783712; font-weight: bold;">
						<h3>모자팔아요.</h3>
						<h4 style="color: #783712; font-weight: bold;">
							<i class="fa">&#xf159;</i> 10000원
						</h4>
						<div style="text-align: right;">
							<h4 style="color: #783712; font-weight: bold;">
								<i class="material-icons">&#xe88a;</i>우리동네 | 금천구 가산동
							</h4>
						</div>
						<p>test</p>
 -->
						<!-- <p>
                Seamlessly empower fully researched growth strategies and interoperable internal or “organic” sources. Credibly innovate granular internal or “organic” sources whereas high standards in web-readiness. Credibly innovate granular internal or organic sources whereas high standards in web-readiness. Energistically scale future-proof core competencies vis-a-vis impactful experiences. Dramatically synthesize integrated schemas. with optimal networks.
            </p> -->
						<div class="card_area">
							<!-- <div class="product_count_area">
                    <p>Quantity</p>
                    <div class="product_count d-inline-block">
                        <span class="product_count_item inumber-decrement"> <i class="ti-minus"></i></span>
                        <input class="product_count_item input-number" type="text" value="1" min="0" max="10">
                        <span class="product_count_item number-increment"> <i class="ti-plus"></i></span>
                    </div>
                    <p>$5</p>
                </div> -->
							<!-- style="text-align:right;" -->
							<!--  <div class="add_to_cart" >
                  <a href="#" class="btn_3" style="color:#783712;"><i style='font-size:24px' class='far'>&#xf004;</i>  관심</a>
                  <a href="#" class="btn_3" style="color:#783712;"><i style='font-size:24px' class='far'>&#xf086;</i>  채팅</a>
                  <a href="#" class="btn_3" style="color:#783712;"><i style='font-size:24px' class='fas'>&#xf03c;</i>  목록</a>
              </div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--================End Single Product Area =================-->
	<!-- subscribe part here -->
	<section class="subscribe_part section_padding">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8">
					<!--  <div class="subscribe_part_content">
                      <h2>Get promotions & updates!</h2>
                      <p>Seamlessly empower fully researched growth strategies and interoperable internal or “organic” sources credibly innovate granular internal .</p>
                      <div class="subscribe_form">
                          <input type="email" placeholder="Enter your mail">
                          <a href="#" class="btn_1">Subscribe</a>
                      </div>
                  </div> -->
				</div>

			</div>

		</div>
	</section>

	<%-- 상품 상세보기 추가부분 --%>
	<section class="content">
		<div class="item_list_area">
			<div class="item_list_area_box">
				<div class="breadcrumbs">
					<ul>
						<li><a href="/">HOME</a></li>
						<li><a href="/search?category=HAA0000">&gt; ${viewRow.bname }</a></li>
						<li><a href="/search?category=HAA0008">&gt; 원피스,정장</a></li>
					</ul>
				</div>
				<div class="main_area">
					<div class="main_area_center">
						<div class="main">
							<div class="detail_box">
								<div class="detail_box_top">
									<div class="detail_top_area">
										<div class="photo_area">
											<div class="large_img">
												<div
													class="swiper-container swiper-container-initialized swiper-container-horizontal">
													<div class="swiper-wrapper"
														style="transform: translate3d(0px, 0px, 0px);">
														<div class="swiper-slide thumbnail_wrapper"
															style="width: 460px;">
															<div class="badeagle">
																<div class="centered">
																	<img alt="셀린원피스의 상세 이미지 5" class="view thumbnail_img"
																		src="https://ccimage.hellomarket.com/web/2018/main/img_default_thumbnail_495x495.png"
																		data-src="https://ccimg.hellomarket.com/images/2020/item/07/07/18/3208607_2131380_5.jpg?size=s6">
																</div>
															</div>
														</div>
													</div>
													<div
														class="swiper-pagination swiper-pagination-white auto_item_image_pagination swiper-pagination-fraction">
														<span class="swiper-pagination-current">1</span> / <span
															class="swiper-pagination-total">5</span>
													</div>
													<div class="swiper-button-next auto_swiper_next"
														tabindex="0" role="button" aria-label="Next slide"
														aria-disabled="false">
														<svg xmlns="https://www.w3.org/2000/svg"
															viewBox="0 0 27 44">
																	<path
																d="M27,22L27,22L5,44l-2.1-2.1L22.8,22L2.9,2.1L5,0L27,22L27,22z"></path></svg>
													</div>
													<div
														class="swiper-button-prev auto_swiper_prev swiper-button-disabled"
														tabindex="0" role="button" aria-label="Previous slide"
														aria-disabled="true">
														<svg xmlns="https://www.w3.org/2000/svg"
															viewBox="0 0 27 44">
																	<path
																d="M0,22L22,0l2.1,2.1L4.2,22l19.9,19.9L22,44L0,22L0,22L0,22z"></path></svg>
													</div>
													<span class="swiper-notification" aria-live="assertive"
														aria-atomic="true"></span>
												</div>
											</div>
											<div class="als_image_viewport">
												<div class="als_prev"></div>
												<div class="als_container">
													<div class="als_viewport"
														style="transform: translateX(0px);">
														<div class="als_item als_normal_item">
															<a><img alt="작은 썸네일 이미지" class="thumbnail_img"
																src="https://ccimg.hellomarket.com/images/2020/item/07/07/18/3208571_2131380_1.jpg?size=s6"></a>
														</div>
														<div class="als_item als_normal_item als_item_other">
															<a><img alt="작은 썸네일 이미지" class="thumbnail_img"
																src="https://ccimg.hellomarket.com/images/2020/item/07/07/18/3208580_2131380_2.jpg?size=s6"></a>
														</div>
														<div class="als_item als_normal_item als_item_other">
															<a><img alt="작은 썸네일 이미지" class="thumbnail_img"
																src="https://ccimg.hellomarket.com/images/2020/item/07/07/18/3208590_2131380_3.jpg?size=s6"></a>
														</div>
														<div class="als_item als_normal_item als_item_other">
															<a><img alt="작은 썸네일 이미지" class="thumbnail_img"
																src="https://ccimg.hellomarket.com/images/2020/item/07/07/18/3208600_2131380_4.jpg?size=s6"></a>
														</div>
														<div class="als_item als_normal_item als_item_other">
															<a><img alt="작은 썸네일 이미지" class="thumbnail_img"
																src="https://ccimg.hellomarket.com/images/2020/item/07/07/18/3208607_2131380_5.jpg?size=s6"></a>
														</div>
														<div class="als_item als_item_other">
															<a><img alt="작은 썸네일 이미지" class="thumbnail_img"
																src="https://ccimage.hellomarket.com/web/2019/item/img_itemdetails_thumbnail_noimage50x50_x2.png"></a>
														</div>
													</div>
												</div>
												<div class="als_next"></div>
											</div>
										</div>
										<div class="item_info">
											<div class="item_title_area">
												<span class="item_tag"><span class="used_type_tag">새상품</span><span
													class="delivery_tag used_type_tag_active  used_type_tag_active">배송비별도</span><span
													class="share_box item_share_box"><img
														src="https://ccimage.hellomarket.com/web/2018/item/btn_share_16x16_x2.png"
														alt="공유이미지" class="share_icon"></span><span
													class="wish_box"><img
														src="https://ccimage.hellomarket.com/web/2020/item/ico_zzim_24x23_s_x2.png"
														alt="찜하기이미지" class="wish_icon"><label>1</label></span></span>
											</div>
											<span class="item_title">${viewRow.title }</span>
											<span class="item_title">${viewRow.idx }</span>
											<div class="item_price_box item_price_box_bottom">
												<div class="item_price_box_bottom_low">
													<div class="item_price item_price_bottom">${viewRow.price }</div>
													<div class="item_coupon_download">
														<div class="download_title">할인 쿠폰 받기</div>
														<div class="download_image">
															<img
																src="https://ccimage.hellomarket.com/web/2019/item/ico_download_white_x2.png"
																alt="다운로드 이미지">
														</div>
													</div>
												</div>
												<div class="description_hellopay  hellopay_isdirect_area">
													<table>
														<tbody>
															<tr class="first">
																<td class="title">거래방법</td>
																<td class="description" style="padding-bottom: 3px;"><img
																	src="https://ccimage.hellomarket.com/web/2020/item/img_detail_howto_hellopay_x2.png"
																	alt="일반 헬로페이"
																	style="height: 15px; width: 40px; margin-top: 4px;"></td>
															</tr>
														</tbody>
													</table>
													<div style="margin-top: 0px;"></div>
												</div>
												<div class="item_sns item_detail_sns">
													<div class="item_hello_box">
														<div class="item_hello_box_talk">
															<div class="wish_img_box">
																<img
																	src="https://ccimage.hellomarket.com/web/2018/item/ico_zzim.png"
																	alt="찜하기이미지" class="wish_icon">
															</div>
															<button type="button"
																class="hello_talk_btn canpayment_hello_talk_btn">헬로톡</button>
														</div>
														<div class="item_hello_box_pay item_hello_box_chat_pay">
															<button type="button" class="hello_pay_btn">헬로페이
																구매</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="detail_box_bottom detail_box_item"
										style="padding-top: 0px;">
										<div class="detail_comment">
											<div class="pc_item_user_info">
												<div class="profile_img">
													<a href="/s/@13242491"><img class="profile"
														src="https://ccimg.hellomarket.com/images/2017/member_profile/s4/03/09/13/5652_2131380_1.jpg?size=s4"
														alt="모바일 상품 회원 프로필 이미지"><img
														class="profile_img_level"
														src="https://ccimage.hellomarket.com/web/2020/item/img_level_1.png"
														alt="뱃지 이미지"></a>
												</div>
												<div class="nick">
													<a href="/s/@13242491">화성에온아이</a>
													<div class="detail_member_level">Lv 1 화이트</div>
												</div>
												<div class="item_count">
													<a href="/s/@13242491?type=item"><span
														class="item_count_title">상품</span><span
														class="item_count_number">4282</span></a>
												</div>
												<div class="detail_profile_review">
													<a href="/s/@13242491?tab=review"><span
														class="review_label">거래후기</span><span
														class="item_count_rating">(2)</span><span
														class="item_count_rating_image"><img
															src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
															alt="상품 상세 모바일 별점 한개 이미지 1"><img
															src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
															alt="상품 상세 모바일 별점 한개 이미지 2"><img
															src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
															alt="상품 상세 모바일 별점 한개 이미지 3"><img
															src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
															alt="상품 상세 모바일 별점 한개 이미지 4"><img
															src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
															alt="상품 상세 모바일 별점 한개 이미지 5"></span></a>
												</div>
											</div>
											<div class="description">
												<div class="description_title">상세설명</div>
												<div class="detail_item_description">
													<div class="description_text">
														린넨100 <br>파격 <br>세일가 <br>프리
													</div>
												</div>
											</div>
											<div class="detail_bottom_box">
												<div class="detail_bottom_area">
													<img
														src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_time_x2.png"
														alt="지도아이콘" class="item_location_img"><span
														class="time">2일전</span>
												</div>
												<div class="detail_bottom_area">
													<img
														src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_category_x2.png"
														alt="지도아이콘" class="item_location_img"><a
														href="/search?category=HAA0000"><span>여성의류</span></a>
													<div>&gt;</div>
													<a href="/search?category=HAA0008"><span>원피스,정장</span></a>
												</div>
											</div>
											<div class="item_buy_area">
												<div class="item_wish_box">
													<div class="item_wish_box_border">
														<button type="button" class="image_wish_box_btn">
															<img
																src="https://ccimage.hellomarket.com/web/2018/item/ico_zzim.png"
																alt="찜하기이미지" class="ad_wish_icon">
														</button>
													</div>
												</div>
												<div class="item_talk_box">
													<div class="item_talk">헬로톡</div>
												</div>
												<div class="item_buy_box">
													<button type="button" class="item_buy">헬로페이 구매</button>
												</div>
											</div>
											<div class="item_user_info mobile_item_user_info">
												<div class="profile_img">
													<a href="/s/@13242491"><img
														src="https://ccimg.hellomarket.com/images/2017/member_profile/s4/03/09/13/5652_2131380_1.jpg?size=s4"
														alt="상품 상세 회원 프로필 이미지"></a>
												</div>
												<div class="nick">
													<a href="/s/@13242491">화성에온아이</a>
												</div>
												<div class="item_count">
													<span class="member_level">Lv 1 화이트</span><span
														class="item_count_middot">・</span><span
														class="item_count_rating_image"><img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
														alt="상품 상세 별점 한개 이미지 1"><img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
														alt="상품 상세 별점 한개 이미지 2"><img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
														alt="상품 상세 별점 한개 이미지 3"><img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
														alt="상품 상세 별점 한개 이미지 4"><img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_16x16_x2.png"
														alt="상품 상세 별점 한개 이미지 5"></span><span
														class="item_count_rating">(2)</span>
												</div>
												<span class="item_count_number mw_item_count_number">상품
													4282개</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
	</section>
	<!-- subscribe part end -->
	<!-- bottom.jsp -->
	<jsp:include page="../include/bottom.jsp" />
	<jsp:include page="../include/sidebar.jsp" />
</body>

</html>
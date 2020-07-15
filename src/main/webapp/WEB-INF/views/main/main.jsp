<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section_tittle text-center">
						<img src="../resources/img/main/우동마켓인기매물1.png" alt="최신매물" style="width: 450px;"/>
					</div>
				</div>

			</div>
			<ul class="mian_row profile_main_row">
				<li class="main_col_3" style="padding: 10px;">
					<div class="search_icon_box related_item_icon profile_libs_page">
						<div class="search_icon">
							<div class="search_circle"></div>
							<div class="search_rectangle"></div>
						</div>
					</div>
					<a class="card card_list" href="/item/166608634?viewPath=wish_list&amp;clickPath=member">
						<div class="card_box">
							<div class="image_wrapper">
								<div class="image_outside">
									<div class="image_centerbox">
										<img
											src="https://ccimage.hellomarket.com/web/2018/main/img_default_thumbnail_495x495.png"
											data-src="https://ccimg.hellomarket.com/images/2020/item/04/28/15/1709868_4830039_1.jpg?size=s4"
											class="thumbnail_img" alt="18인치 휠 타이어 판매합니다(배송비,스페이스1조포함)" />
									</div>
									<div class="dealer_text_position">
										<img
											src="https://ccimage.hellomarket.com/web/2020/item/ico_badge_thumbnail_hellopay_x2.png"
											alt="헬로페이 아이콘" style="width: 43px; height: 21px" />
									</div>
								</div>
							</div>
							<div class="cont">
								<div class="item_title related_item_icon">18인치 휠 타이어
									판매합니다(배송비,스페이스1조포함)</div>
								<div class="item_price profile_price">240,000원</div>
							</div>
						</div></a>
				<div class="image_wish_box">
						<button type="button" class="image_wish_box_btn">
							<svg viewBox="0 0 24 24" fill="#FF2C41" fill-opacity="1"
								stroke="#ffffff" stroke-width="2" focusable="false"
								aria-label="찜하기" role="img" stroke-linecap="round"
								stroke-linejoin="round" class="image_wish_box_img">
								<path d="m17.5 2.9c-2.1 0-4.1 1.3-5.4 2.8-1.6-1.6-3.8-3.2-6.2-2.7-1.5.2-2.9 1.2-3.6 2.6-2.3 4.1 1 8.3 3.9 11.1 1.4 1.3 2.8 2.5 4.3 3.6.4.3 1.1.9 1.6.9s1.2-.6 1.6-.9c3.2-2.3 6.6-5.1 8.2-8.8 1.5-3.4 0-8.6-4.4-8.6"
									stroke-linejoin="round">
								</path>
							</svg>
						</button>
					</div>
				</li>
				<li class="main_col_3" style="padding: 10px;">
					<a href="javascript:void(0);" onclick="window.open('../product/productView.woo', '_blank', 'height=1000; width=1200; top=200; left=150;', true);">
					<div class="search_icon_box related_item_icon profile_libs_page">
						<div class="search_icon">
							<div class="search_circle"></div>
							<div class="search_rectangle"></div>
						</div>
					</div>
					</a>
					<a class="card card_list" href="/item/166608634?viewPath=wish_list&amp;clickPath=member">
						<div class="card_box">
							<div class="image_wrapper">
								<div class="image_outside">
									<div class="image_centerbox">
										<img
											src="https://ccimage.hellomarket.com/web/2018/main/img_default_thumbnail_495x495.png"
											data-src="https://ccimg.hellomarket.com/images/2020/item/04/28/15/1709868_4830039_1.jpg?size=s4"
											class="thumbnail_img" alt="18인치 휠 타이어 판매합니다(배송비,스페이스1조포함)" />
									</div>
									<div class="dealer_text_position">
										<img
											src="https://ccimage.hellomarket.com/web/2020/item/ico_badge_thumbnail_hellopay_x2.png"
											alt="헬로페이 아이콘" style="width: 43px; height: 21px" />
									</div>
								</div>
							</div>
							<div class="cont">
								<div class="item_title related_item_icon">18인치 휠 타이어
									판매합니다(배송비,스페이스1조포함)</div>
								<div class="item_price profile_price">240,000원</div>
							</div>
						</div></a>
				<div class="image_wish_box">
						<button type="button" class="image_wish_box_btn">
							<svg viewBox="0 0 24 24" fill="#FF2C41" fill-opacity="1"
								stroke="#ffffff" stroke-width="2" focusable="false"
								aria-label="찜하기" role="img" stroke-linecap="round"
								stroke-linejoin="round" class="image_wish_box_img">
								<path d="m17.5 2.9c-2.1 0-4.1 1.3-5.4 2.8-1.6-1.6-3.8-3.2-6.2-2.7-1.5.2-2.9 1.2-3.6 2.6-2.3 4.1 1 8.3 3.9 11.1 1.4 1.3 2.8 2.5 4.3 3.6.4.3 1.1.9 1.6.9s1.2-.6 1.6-.9c3.2-2.3 6.6-5.1 8.2-8.8 1.5-3.4 0-8.6-4.4-8.6"
									stroke-linejoin="round">
								</path>
							</svg>
						</button>
					</div>
				</li>
				<li class="main_col_3" style="padding: 10px;">
					<div class="search_icon_box related_item_icon profile_libs_page">
						<div class="search_icon">
							<div class="search_circle"></div>
							<div class="search_rectangle"></div>
						</div>
					</div>
					<a class="card card_list" href="/item/166608634?viewPath=wish_list&amp;clickPath=member">
						<div class="card_box">
							<div class="image_wrapper">
								<div class="image_outside">
									<div class="image_centerbox">
										<img
											src="https://ccimage.hellomarket.com/web/2018/main/img_default_thumbnail_495x495.png"
											data-src="https://ccimg.hellomarket.com/images/2020/item/04/28/15/1709868_4830039_1.jpg?size=s4"
											class="thumbnail_img" alt="18인치 휠 타이어 판매합니다(배송비,스페이스1조포함)" />
									</div>
									<div class="dealer_text_position">
										<img
											src="https://ccimage.hellomarket.com/web/2020/item/ico_badge_thumbnail_hellopay_x2.png"
											alt="헬로페이 아이콘" style="width: 43px; height: 21px" />
									</div>
								</div>
							</div>
							<div class="cont">
								<div class="item_title related_item_icon">18인치 휠 타이어
									판매합니다(배송비,스페이스1조포함)</div>
								<div class="item_price profile_price">240,000원</div>
							</div>
						</div></a>
				<div class="image_wish_box">
						<button type="button" class="image_wish_box_btn">
							<svg viewBox="0 0 24 24" fill="#FF2C41" fill-opacity="1"
								stroke="#ffffff" stroke-width="2" focusable="false"
								aria-label="찜하기" role="img" stroke-linecap="round"
								stroke-linejoin="round" class="image_wish_box_img">
								<path d="m17.5 2.9c-2.1 0-4.1 1.3-5.4 2.8-1.6-1.6-3.8-3.2-6.2-2.7-1.5.2-2.9 1.2-3.6 2.6-2.3 4.1 1 8.3 3.9 11.1 1.4 1.3 2.8 2.5 4.3 3.6.4.3 1.1.9 1.6.9s1.2-.6 1.6-.9c3.2-2.3 6.6-5.1 8.2-8.8 1.5-3.4 0-8.6-4.4-8.6"
									stroke-linejoin="round">
								</path>
							</svg>
						</button>
					</div>
				</li>
				<li class="main_col_3" style="padding: 10px;">
					<div class="search_icon_box related_item_icon profile_libs_page">
						<div class="search_icon">
							<div class="search_circle"></div>
							<div class="search_rectangle"></div>
						</div>
					</div>
					<a class="card card_list" href="/item/166608634?viewPath=wish_list&amp;clickPath=member">
						<div class="card_box">
							<div class="image_wrapper">
								<div class="image_outside">
									<div class="image_centerbox">
										<img
											src="https://ccimage.hellomarket.com/web/2018/main/img_default_thumbnail_495x495.png"
											data-src="https://ccimg.hellomarket.com/images/2020/item/04/28/15/1709868_4830039_1.jpg?size=s4"
											class="thumbnail_img" alt="18인치 휠 타이어 판매합니다(배송비,스페이스1조포함)" />
									</div>
									<div class="dealer_text_position">
										<img
											src="https://ccimage.hellomarket.com/web/2020/item/ico_badge_thumbnail_hellopay_x2.png"
											alt="헬로페이 아이콘" style="width: 43px; height: 21px" />
									</div>
								</div>
							</div>
							<div class="cont">
								<div class="item_title related_item_icon">18인치 휠 타이어
									판매합니다(배송비,스페이스1조포함)</div>
								<div class="item_price profile_price">240,000원</div>
							</div>
						</div></a>
				<div class="image_wish_box">
						<button type="button" class="image_wish_box_btn">
							<svg viewBox="0 0 24 24" fill="#FF2C41" fill-opacity="1"
								stroke="#ffffff" stroke-width="2" focusable="false"
								aria-label="찜하기" role="img" stroke-linecap="round"
								stroke-linejoin="round" class="image_wish_box_img">
								<path d="m17.5 2.9c-2.1 0-4.1 1.3-5.4 2.8-1.6-1.6-3.8-3.2-6.2-2.7-1.5.2-2.9 1.2-3.6 2.6-2.3 4.1 1 8.3 3.9 11.1 1.4 1.3 2.8 2.5 4.3 3.6.4.3 1.1.9 1.6.9s1.2-.6 1.6-.9c3.2-2.3 6.6-5.1 8.2-8.8 1.5-3.4 0-8.6-4.4-8.6"
									stroke-linejoin="round">
								</path>
							</svg>
						</button>
					</div>
				</li>
				<li class="main_col_3" style="padding: 10px;">
					<div class="search_icon_box related_item_icon profile_libs_page">
						<div class="search_icon">
							<div class="search_circle"></div>
							<div class="search_rectangle"></div>
						</div>
					</div>
					<a class="card card_list" href="/item/166608634?viewPath=wish_list&amp;clickPath=member">
						<div class="card_box">
							<div class="image_wrapper">
								<div class="image_outside">
									<div class="image_centerbox">
										<img
											src="https://ccimage.hellomarket.com/web/2018/main/img_default_thumbnail_495x495.png"
											data-src="https://ccimg.hellomarket.com/images/2020/item/04/28/15/1709868_4830039_1.jpg?size=s4"
											class="thumbnail_img" alt="18인치 휠 타이어 판매합니다(배송비,스페이스1조포함)" />
									</div>
									<div class="dealer_text_position">
										<img
											src="https://ccimage.hellomarket.com/web/2020/item/ico_badge_thumbnail_hellopay_x2.png"
											alt="헬로페이 아이콘" style="width: 43px; height: 21px" />
									</div>
								</div>
							</div>
							<div class="cont">
								<div class="item_title related_item_icon">18인치 휠 타이어
									판매합니다(배송비,스페이스1조포함)</div>
								<div class="item_price profile_price">240,000원</div>
							</div>
						</div></a>
				<div class="image_wish_box">
						<button type="button" class="image_wish_box_btn">
							<svg viewBox="0 0 24 24" fill="#FF2C41" fill-opacity="1"
								stroke="#ffffff" stroke-width="2" focusable="false"
								aria-label="찜하기" role="img" stroke-linecap="round"
								stroke-linejoin="round" class="image_wish_box_img">
								<path d="m17.5 2.9c-2.1 0-4.1 1.3-5.4 2.8-1.6-1.6-3.8-3.2-6.2-2.7-1.5.2-2.9 1.2-3.6 2.6-2.3 4.1 1 8.3 3.9 11.1 1.4 1.3 2.8 2.5 4.3 3.6.4.3 1.1.9 1.6.9s1.2-.6 1.6-.9c3.2-2.3 6.6-5.1 8.2-8.8 1.5-3.4 0-8.6-4.4-8.6"
									stroke-linejoin="round">
								</path>
							</svg>
						</button>
					</div>
				</li>
				<li class="main_col_3" style="padding: 10px;">
					<div class="search_icon_box related_item_icon profile_libs_page">
						<div class="search_icon">
							<div class="search_circle"></div>
							<div class="search_rectangle"></div>
						</div>
					</div>
					<a class="card card_list" href="/item/166608634?viewPath=wish_list&amp;clickPath=member">
						<div class="card_box">
							<div class="image_wrapper">
								<div class="image_outside">
									<div class="image_centerbox">
										<img
											src="https://ccimage.hellomarket.com/web/2018/main/img_default_thumbnail_495x495.png"
											data-src="https://ccimg.hellomarket.com/images/2020/item/04/28/15/1709868_4830039_1.jpg?size=s4"
											class="thumbnail_img" alt="18인치 휠 타이어 판매합니다(배송비,스페이스1조포함)" />
									</div>
									<div class="dealer_text_position">
										<img
											src="https://ccimage.hellomarket.com/web/2020/item/ico_badge_thumbnail_hellopay_x2.png"
											alt="헬로페이 아이콘" style="width: 43px; height: 21px" />
									</div>
								</div>
							</div>
							<div class="cont">
								<div class="item_title related_item_icon">18인치 휠 타이어
									판매합니다(배송비,스페이스1조포함)</div>
								<div class="item_price profile_price">240,000원</div>
							</div>
						</div></a>
				<div class="image_wish_box">
						<button type="button" class="image_wish_box_btn">
							<svg viewBox="0 0 24 24" fill="#FF2C41" fill-opacity="1"
								stroke="#ffffff" stroke-width="2" focusable="false"
								aria-label="찜하기" role="img" stroke-linecap="round"
								stroke-linejoin="round" class="image_wish_box_img">
								<path d="m17.5 2.9c-2.1 0-4.1 1.3-5.4 2.8-1.6-1.6-3.8-3.2-6.2-2.7-1.5.2-2.9 1.2-3.6 2.6-2.3 4.1 1 8.3 3.9 11.1 1.4 1.3 2.8 2.5 4.3 3.6.4.3 1.1.9 1.6.9s1.2-.6 1.6-.9c3.2-2.3 6.6-5.1 8.2-8.8 1.5-3.4 0-8.6-4.4-8.6"
									stroke-linejoin="round">
								</path>
							</svg>
						</button>
					</div>
				</li>
				
			</ul>
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



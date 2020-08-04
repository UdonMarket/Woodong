<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- breadcrumb part start-->
<section class="breadcrumb_part">
	<div class="container-fluid">
		<div class="row top_image"></div>
		<img src="../resources/img/나의우동.png" alt="" id="main"
			style="height: 100%; width: 100%">
	</div>
</section>
<!-- breadcrumb part end-->

<!--================Blog Area =================-->
<section class="content1" style="padding-top: 30px;">
	<!-- <h1>우동마켓 - 100% 안전한 중고거래 장터</h1>
				<h2>나의 등급</h2> -->
	<div class="item_list_min" style="margin-bottom: -50px;">
		<div class="item_list_area">
			<div class="main_area">
				<div class="main_area_center">
					<div class="main">
						<div class="left">
							<div class="my_profile_left">
								<div class="my_profile_info">

									<div class="breadcrumbs" style="margin-top: 100px;"></div>
									<div class="my_profile_image">
										${udongGrade }
										<!-- 	<img src="../resources/img/myPage/nor-blue.png" alt="우동등급" /> -->
									</div>
									<div class="my_profile_nick">'${memberVO.id }' 님</div>
									<div class="my_profile_shop_created">
										<div class="my_profile_start_mobile"></div>
										<div class="my_profile_start">우동마켓 시작일 : ${memberVO.regidate }</div>
									</div>

									<div class="my_profile_follow"></div>
									<div class="my_profile_pro_review">
										<div class="my_profile_pro_review_box">
											<a href="./myPage.woo?mode=review&dealPosition=buyer"><span>거래후기</span><span>${memberVO.avg_score}개</span>
												<div class="my_profile_pro_review_rating">${score}</div></a>
											<div    style="padding-left: 90px">
												<span>거래횟수 : </span><span>${memberVO.trade_count} 번</span>
											</div>

										</div>
									</div>
									<span class="my_profile_more_text" width="0"> <span></span>
										<span> </span> <span
										style="position: fixed; visibility: hidden; top: 0; left: 0">
											<span class="text_trcucate_more">...
												<p>전체보기</p>
										</span>
									</span>
									</span>
								</div>
								<div class="my_profile_nav">
									<ul style="background-color: #FFF; border: 1px solid #d9d9d9;">
										<li class="my_profile_m_nav"><a
											href="/s/@16128096?tab=item"><span>상품 <!-- -->0
											</span></a></li>
										<li class="my_profile_m_nav"><a
											href="./myPage.woo?mode=review"><span>거래후기 </span><span>0</span>
												<div class="my_profile_pro_review_rating">
													<img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
														alt="프로필 별점 없는 이미지 1" /> <img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
														alt="프로필 별점 없는 이미지 2" /> <img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
														alt="프로필 별점 없는 이미지 3" /> <img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
														alt="프로필 별점 없는 이미지 4" /> <img
														src="https://ccimage.hellomarket.com/web/2019/member/img_review_star_blank_16x16_x2.png"
														alt="프로필 별점 없는 이미지 5" />
												</div> </a></li>
										<li><a class="active" id="scrollMain" href="../mypage/myPage.woo"><span
												style="font-size: 1.4em; color: #ff4f4f;">쇼핑 활동</span></a></li>
										<c:if test="${param.dealPosition eq seller }">
											<li><a
												href="../mypage/myPage.woo?mode=deal&dealMode=sell"><span>거래중</span></a>
											</li>
										</c:if>
										<li><a href="../mypage/myPage.woo?mode=sell"><span>판매목록</span></a>
										</li>
										<c:if test="${param.dealPosition eq seller }">
											<li><a href="../mypage/myPage.woo?mode=like"><span>관심목록</span></a>
											</li>
											<li><a href="../mypage/myPage.woo?mode=buy"><span>구매목록</span></a>
											</li>
										</c:if>
										<li><a
											href="../mypage/myPage.woo?mode=review&dealPosition=buyer"><span>후기</span></a>
										</li>
										<c:if test="${param.dealPosition eq seller }">
										<li><a class="active" id="scrollMain" 	href="../mypage/myPage.woo">
										<span style="font-size: 1.4em; color: #ff4f4f;"> 회원설정</span></a></li>
										<li><a href="../member/memberModify.woo"><span>회원정보 수정</span></a></li>
										<li><a href="../member/myPlace.woo"><span>동네인증</span></a>
										</li>
										<li><a href="../member/passwordform.woo"><span>회원탈퇴</span></a>
										</li>
										</c:if>

									</ul>
								</div>
							</div>
						</div>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!doctype html>
	<html lang="zxx">
	
	<!-- head.jsp -->
	<jsp:include page="../include/head.jsp"/>
	
	<body>
		<!--::header part start::-->
		<!-- header.jsp --> 
	    <jsp:include page="../include/hearder.jsp"/>
		<!-- Header part end-->
	
		<jsp:include page="../include/mypageLeft.jsp"/>
									<section class="left_main">
										<div class="level_top">
											<div class="level_header">
												<div class="level_title1" style="padding-left: 50px;padding-top: 50px;">
													<div class="row">
														<div class="col-4">
															<a href="../mypage/myList_W.woo">
																<img src="../resources/img/myPage/거래중.png" alt="거래중" style="width: 230px;height: 130px;"/>
															</a>
														</div>
														<div class="col-4">
															 <a href="../mypage/myList_S.woo">
																<img src="../resources/img/myPage/판매목록.png" alt="판매목록" style="width: 230px;height: 130px;" />
															</a>
														</div>
														<div class="col-4">
															<a href="../mypage/myList_B.woo">
																<img src="../resources/img/myPage/구매목록.png" alt="구매목록" style="width: 230px;height: 130px;" />
															</a>
														</div>
													</div>
													<div class="row" style="padding-top: 50px;">
														<div class="col-4">
															<a href="../mypage/likelist.woo">
																<img src="../resources/img/myPage/관심목록.png" alt="관심목록"  style="width: 230px;height: 130px;"/>
															</a>
														</div>
														<div class="col-4">
															<a href="../mypage/myPlace.woo">
																<img src="../resources/img/myPage/동네인증.png" alt="동네인증" style="width: 230px;height: 130px;" />
															</a>
														</div>
														<div class="col-4">
															<a href="../mypage/myReview.woo">
																<img src="../resources/img/myPage/후기.png" alt="후기"  style="width: 230px;height: 130px;"/>
															</a>
														</div>
													</div>
												</div>
											</div>
											<div class="level_body" style="padding-bottom: 50px;">
												<div class=""  style="width: 630px;height:220px;">
													<img src="../resources/img/myPage/나의우동등급.png" alt="우동마켓 등급 이미지" />
												</div>
												<div class=""  style="width: 630px;margin-top: 25px;">
													<img src="../resources/img/myPage/등급선정기준.png" alt="선정기준" />
												</div>
											</div>
										</div>
									</section>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		<!--================Blog Area =================-->
	<!-- bottom.jsp -->
	    <jsp:include page="../include/bottom.jsp"/>
	    <jsp:include page="../include/sidebar.jsp"/>
	</body>
	
	</html>
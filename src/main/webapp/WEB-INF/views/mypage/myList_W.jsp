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
							<section class="left_main" style="padding-top: 100px;padding-left: 70px;">
							<div class="col-12" style="text-align: center;">
					          	<img src="../resources/img/myPage/거래중1.png" alt="" width="280px;"/>
					        </div>
							<div class="cat_box">
								<div class="my_specialist_name">
									전체 <span>1</span>
								</div>
							
							</div>
							<div class="tab_content">
								<div>
									<div class="infinite-scroll-component "
										style="height: auto; overflow: auto; -webkit-overflow-scrolling: touch">
										<ul class="mian_row profile_main_row">
											<c:forEach var="list" items="${likeList }">
											<li class="main_col_3" style="padding: 5px">
											<!-- <div
													class="search_icon_box related_item_icon profile_libs_page">
													<div class="search_icon">
														<div class="search_circle"></div>
														<div class="search_rectangle"></div>
													</div>
												</div> -->
												<a class="card card_list"
												href="/item/166608634?viewPath=wish_list&amp;clickPath=member"><div
														class="card_box">
														<div class="image_wrapper">
															<div class="image_outside">
																<div class="image_centerbox">
																	<img
																		src="../resources/Upload/${list.image }"
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
															<div class="item_title related_item_icon">${list.title }</div>
															<div class="item_price profile_price">${list.price }원</div>
														</div>
													</div></a>
											<!-- <div class="image_wish_box">
													<button type="button" class="image_wish_box_btn">
														<svg viewBox="0 0 24 24" fill="#FF2C41" fill-opacity="1"
															stroke="#ffffff" stroke-width="2" focusable="false"
															aria-label="찜하기" role="img" stroke-linecap="round"
															stroke-linejoin="round" class="image_wish_box_img">
															<path
																d="m17.5 2.9c-2.1 0-4.1 1.3-5.4 2.8-1.6-1.6-3.8-3.2-6.2-2.7-1.5.2-2.9 1.2-3.6 2.6-2.3 4.1 1 8.3 3.9 11.1 1.4 1.3 2.8 2.5 4.3 3.6.4.3 1.1.9 1.6.9s1.2-.6 1.6-.9c3.2-2.3 6.6-5.1 8.2-8.8 1.5-3.4 0-8.6-4.4-8.6"
																stroke-linejoin="round"></path></svg>
													</button>
												</div> -->
												</li>
												</c:forEach>
										</ul>
									</div>
									<ul class="pagination justify-content-center">
										${pagingImg }
									</ul>
								</div>
								<!-- <div class="paging">
									<ul>
										<li></li>
										<li class="active">
											<a href="/s/@16128097?tab=wish&amp;page=1">
												<div class="paging_box">1</div>
											</a>
										</li>
										<li></li>
									</ul>
								</div> -->
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
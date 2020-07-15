<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!doctype html>
	<html lang="zxx">
	
	<!-- head.jsp -->
	<jsp:include page="../include/head.jsp"/>
	<script>
	function like_toggle(idx) {
		$.ajax({
			url : "./like_toggle.woo",
			type:"get",
		    contentType:"text/html;charset:utf-8",
		    data:{idx : idx},
		    dataType : "json" ,
	 	  success : function(d) {
	 		 // alert(d);
	 		 if(d.like_check  == 1){
					//이미지 바꾸기 (빈하트)
		 		// alert("토글성공");
					$("img[name=" + idx + "]").attr('src', "../resources/img/2.png");
				//alert("이미지 토글성공");
					 //idx짤라서 update 
				}
				else{
					/* 빨간하트로 이미지 변경 */
					$("img[name=" + idx + "]").attr('src', "../resources/img/1.png");
				}
			},
			error : function(request,status,error) {
				//alert("이미지 토글 실패" + error.status);
		          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		});
	}
		
	</script>
	<body>
		<!--::header part start::-->
		<!-- header.jsp --> 
	    <jsp:include page="../include/hearder.jsp"/>
		<!-- Header part end-->
	
		<jsp:include page="../include/mypageLeft.jsp"/>
							<section class="left_main" style="padding-top: 100px;padding-left: 70px;">
							<div class="col-12" style="text-align: center;">
					         	 <img src="../resources/img/myPage/관심목록1.png" alt="" width="280px;"/>
					        </div>
							<div class="cat_box">
								<div class="my_specialist_name">
									전체 <span>1</span>
								</div>
								<select class="mobile_filter_icon profile_filter_icon"><option
										value="current-wish">찜한 상품순</option>
									<option value="high-wish">찜 많은 상품순</option>
									<option value="lowprice">저가순</option>
									<option value="current">최근 등록순</option></select>
								<div class="regist_category_profile regist_category_profile_wish">
									<select><option selected="" value="">카테고리 전체</option>
										<option value="HAR0000">자동차용품</option></select>
								</div>
							</div>
							<div class="tab_content">
								<div>
									<div class="infinite-scroll-component "
										style="height: auto; overflow: auto; -webkit-overflow-scrolling: touch">
										<ul class="mian_row profile_main_row">
										<c:forEach var="list" items="${likeList }">
											<li class="main_col_3" style="padding: 5px;">
												<div class="search_icon_box related_item_icon profile_libs_page">
													<div class="search_icon">
														<div class="search_circle"></div>
														<div class="search_rectangle"></div>
													</div>
												</div>
												<a class="card card_list"
												href="/item/166608634?viewPath=wish_list&amp;clickPath=member"><div
														class="card_box">
														<div class="image_wrapper">
															<div class="image_outside">
																<div class="image_centerbox">
																	<img
																		src="../resources/Upload/${list.image }.png"
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
												<div class="image_wish_box">
														<c:if test="${list.like_check eq 1}"><!-- 빈하트로 바꾸기 -->
															<img src="../resources/img/2.png" width="30px;" height="30px" name = "${list.idx}" onclick="like_toggle(${list.idx});"/>
														</c:if>
														<c:if test="${list.like_check eq -1}"><!-- 빨간하트로 바꾸기 -->
															<img src="../resources/img/1.png" width="30px;" height="30px" name = "${list.idx}" onclick="like_toggle(${list.idx});"/>
														</c:if>
													</div></li>
												</c:forEach>
										</ul>
									</div>
									<ul class="pagination justify-content-center">
										${pagingImg }
									</ul>
								</div>
								<div class="paging">
									<ul>
										<li></li>
										<li class="active">
											<a href="/s/@16128097?tab=wish&amp;page=1">
												<div class="paging_box">1</div>
											</a>
										</li>
										<li></li>
									</ul>
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
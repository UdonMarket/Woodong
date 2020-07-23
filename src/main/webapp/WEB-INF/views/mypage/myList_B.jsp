<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!doctype html>
	<html lang="zxx">
	
	<!-- head.jsp -->
	<jsp:include page="../include/head.jsp"/>
	<script>
	function write_review(idx,title,id) {
		$.ajax({
			url : "./write_review.woo",
			type:"get",
		    contentType:"text/html;charset:utf-8",
		    data:{idx : idx, title:title, id:id},
		    dataType : "json" ,
		 	success : function(d){},
		 	error : function(request,status,error) {
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
					          	<img src="../resources/img/myPage/구매목록1.png" alt="" width="280px;"/>
					        </div>
							<div class="cat_box">
								<div class="my_specialist_name">
									 <span></span>
								</div>
							
								</div>
							
							<div class="tab_content">
								<div>
									<div class="infinite-scroll-component "
										style="height: auto; overflow: auto; -webkit-overflow-scrolling: touch">
										<ul class="mian_row profile_main_row">
											<c:forEach var="list" items="${likeList }">
											<li class="main_col_3" style="padding: 5px">
										
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
																	
																</div>
															</div>
														</div>
														<div class="cont">
															<div class="item_title related_item_icon">${list.title }</div>
															<div class="item_price profile_price">${list.price }원</div>
															
														<div style="text-align: right;">
															 <a href="javascript:void(0);" onclick="window.open('../mypage/reviewPop.woo?idx=${list.idx}', '_blank', 'height=430; width=480; top=200; left=700;', true);"> 
																	
																<img src="../resources/img/myPage/리뷰작성.png" style="width: 90px; height:40px;" onclick="write_review('${list.idx}','${list.title}','${list.id}');"/>
															 </a> 
														</div>
														
														</div>
													</div></a>
											
												</li>
												</c:forEach>
										</ul>
									</div>
									<ul class="pagination justify-content-center">
										${pagingImg }
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
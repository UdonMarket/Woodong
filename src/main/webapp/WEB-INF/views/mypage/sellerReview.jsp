<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script>
	function deleteRow() {
		var c = confirm("정말 삭제하시겠습니까?");
		if(c){
			return true;
		}
		else{
			return false;
		}
	}
</script>

<body>
	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<jsp:include page="../include/mypageLeft.jsp" />
	<section class="left_main"
		style="padding-top: 100px; padding-left: 70px;">
		<div style="text-align: center;">
			<img src="../resources/img/myPage/후기1.png" alt="" width="280px;" />
		</div>
		<div class="profile_review_content"
			style="padding-top: 15px; padding-bottom: 150px;">
			<div class="profile_review_header">
				<ul>
					<li>
						<div class="row"
							style="display: inline-block; padding: 0px; margin: 0px; padding-left: 30px;">
							<div class="col-5"
								style="font-size: 30px; font-weight: bold; padding: 0px; padding-left: 50px; padding-top: 30px; margin: 0px; display: inline-block;">
								${seller_avgscore} 개</div>

							<div class="col-3"
								style="white-space: nowrap; width: 200px; padding: 0px; display: inline-block; margin: 0px; margin-bottom: 50px;">
								${score}</div>
						</div>
					</li>
					<li></li>
				</ul>
			</div>
			<div class="profile_review_mobile_back"style="border-top: 1px solid #d9d9d9; margin"  ></div>
			<div class="profile_review_align"></div>
			<div class="profile_review_body">
				<div class="review_list" style=" margin-top: 100px;">
					<ul>
						<li><c:choose>
								<c:when test="${empty sellerRiviewList}">
									<span style="font-size: 20px; padding-left: 250px;">게시물이 없습니다.</span>
									
									
									<div class="row"
												style="padding-top: 50px; padding-left: 50px; padding-bottom: 50px; border-bottom: 1px solid #d9d9d9;">
												<div class="col-3">
													<div class="member_image_box1">
														
													</div>
												</div>
												<div class="col-1"></div>
												<div class="member_box col-8">
												</div>
											</div>
								</c:when>
								<c:otherwise>
										<c:forEach var="list" items="${sellerRiviewList }">
											<div class="row"
												style="padding-top: 50px; padding-left: 50px; padding-bottom: 50px; border-bottom: 1px solid #d9d9d9;">
												<div class="col-3">
													<div class="member_image_box1">
														<a href="../product/productView.woo?boardidx=${list.boardidx}"> 
														<img src="../resources/Upload/${list.imagefile}">
														</a> <a href="/s/@16078391?tab=item">
															<div class="" style="font-weight: bold; font-size: 15px; padding-top: 30px; padding-left: 8px;">
																판매자 : ${list.seller_id}</div>
														</a>
													</div>
												</div>
												<div class="col-1"></div>
												<div class="member_box col-8">

													<div class="item_review_title"
														style="font-weight: bold; font-size: 15px;">
														${list.title}</div>
													<span class="description" width="0"> <span> <span>
																${list.contents}</span><br>
													</span> <span style="position: fixed; visibility: hidden; top: 0px; left: 0px;">
															<span class="text_trcucate_more"><p>전체보기</p> </span>
													</span>
													</span>
												</div>
											<c:if test="${user_id eq list.buyer_id}">
												<form:form name="deleteFrm" onsubmit="return deleteRow();" method="post" action="../mypage/reviewDelete.woo">
													<input type="image" src="../resources/img/myPage/삭제.png" style="width: 50px; height: 40px; margin-left: 500px;" />
													 <input type="hidden" name ="boardidx" value="${list.boardidx}"/>
													 <input type="hidden" name ="seller_id" value="${list.seller_id}"/>
													 <input type="hidden" name ="seller_avgscore" value="${seller_avgscore}"/>
													 <input type="hidden" name ="score" value="${score}"/>
													 <input type="hidden" name ="dealPosition" value="seller"/>
												 </form:form>
											</c:if>
												
											</div>
										</c:forEach>
								</c:otherwise>
							</c:choose></li>
					</ul>

					<div class="paging">
						<ul>
							<li></li>
							<li class="active"><a
								href="/s/@16059379?tab=review&amp;page=1">
									<div class="paging_box" style="padding-top: 2px;">1</div>
							</a></li>
							<li class=""><a href="/s/@16059379?tab=review&amp;page=2">
									<div class="paging_box" style="padding-top: 2px;">2</div>
							</a></li>
							<li class=""><a href="/s/@16059379?tab=review&amp;page=3">
									<div class="paging_box" style="padding-top: 2px;">3</div>
							</a></li>
							<li><a href="/s/@16059379?tab=review&amp;page=2">
									<div class="paging_box" style="padding-top: 2px;">
										<i style='font-size: 15px' class='fas'>&#xf054;</i>
										<!-- <svg viewBox="0 0 18 18" role="img" aria-label="이전" focusable="false" class="prev">
												<path d="m4.29 1.71a1 1 0 1 1 1.42-1.41l8 8a1 1 0 0 1 0 1.41l-8 8a1 1 0 1 1 -1.42-1.41l7.29-7.29z"></path>
											</svg> -->
									</div>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		</div>
	</section>

	<!--================Blog Area =================-->
	<!-- bottom.jsp -->
	<jsp:include page="../include/bottom.jsp" />
	<jsp:include page="../include/sidebar.jsp" />
</body>

</html>
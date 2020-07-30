<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script>
function deleteRow(boardidx) {
	if(confirm("정말 삭제하시겠습니까?")){
		location.href="../mypage/reviewDelete.woo?boardidx=" + boardidx + "&dealPosition=buyer";
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
			
			<div class="profile_review_mobile_back"style="border-top: 1px solid #d9d9d9; margin"  ></div>
			<div class="profile_review_align"></div>
			<div class="profile_review_body">
				<div class="review_list" style=" margin-top: 100px;">
					<ul>
						<li>
						<c:choose>
								<c:when test="${empty riviewList}">
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
										<c:forEach var="list" items="${riviewList }">
											<div class="row"
												style="padding-top: 50px; padding-left: 50px; padding-bottom: 50px; border-bottom: 1px solid #d9d9d9;">
												<div class="col-3">
													<div class="member_image_box1">
														<a href="../product/productView.woo?boardidx=${list.boardidx}"  > 
														<img src="../resources/Upload/${list.imagefile}">
														</a> 
														<a href="/s/@16078391?tab=item">
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
													</span> <span
														style="position: fixed; visibility: hidden; top: 0px; left: 0px;">
															<span class="text_trcucate_more"><p>전체보기</p> </span>
													</span>
													</span>
												</div>
												
												<c:if test="${user_id eq list.buyer_id}">
												<img src="../resources/img/myPage/삭제.png" style="width: 50px; height:40px; margin-left:500px;" onclick="javascript:deleteRow(${list.boardidx});" />
												</c:if>
											</div>
										</c:forEach>
								</c:otherwise>

							</c:choose></li>

					</ul>


					<div class="paging">
						<ul>${pagingImg }
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
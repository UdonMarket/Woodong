<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script>
function like_toggle(idx) {
	$.ajax({
		url : "./likeToggle.woo",
		type:"get",
	    contentType:"text/html;charset:utf-8",
	    data:{idx : idx},
	    dataType : "json" ,
 	  success : function(d) {
 		/*  if(d.like_check == 1){
				//이미지 바꾸기 (빈하트)
				$("img[name=" + idx + "]").attr('src', "../resources/img/2.png");
			}
			else{
				$("img[name=" + idx + "]").attr('src', "../resources/img/1.png");
			} */
 			restartFunc();
 	
		},
		error : function(request,status,error) {
			//alert("이미지 토글 실패" + error.status);
	          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	});
}


function restartFunc(){  
	    location.reload();
}
</script>
<body>
	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<jsp:include page="../include/mypageLeft.jsp" />
		<section class="left_main" style="padding-top: 100px;padding-left: 70px;">
							<div class="col-12" style="text-align: center;">
					          	<img src="../resources/img/myPage/관심목록1.png" alt="" width="280px;"/>
					        </div>
							<div class="cat_box">
								<div class="my_specialist_name">
									 <span></span>
								</div>	
		</div>

		<div class="tab_content">
			<div>
				<div class="infinite-scroll-component"
					style="height: auto; overflow: auto; -webkit-overflow-scrolling: touch">

					<ul class="mian_row profile_main_row">
						<c:forEach var="list" items="${likeList }">
						<c:if test="list == null">
							게시물이 없습니다.
						</c:if>
							<li class="main_col_3" style="padding: 5px">
								<a class="card card_list"
								href="/item/166608634?viewPath=wish_list&amp;clickPath=member">
								
									<div class="card_box">
										<div class="image_wrapper">
											<div class="image_outside">
												<div class="image_centerbox">
												
													<img src="../resources/Upload/"
														data-src="https://ccimg.hellomarket.com/images/2020/item/04/28/15/1709868_4830039_1.jpg?size=s4"
														class="thumbnail_img" alt="18인치 휠 타이어 판매합니다(배송비,스페이스1조포함)" />
												</div>
												<div class="dealer_text_position">
													
												</div>
											</div>
										</div>
										<div class="cont">
											<div class="item_title related_item_icon">
											${list.title }</div>
											<div class="item_price profile_price">${list.price }원</div>
										</div>
									</div>
							</a>
								<div class="image_wish_box">
								
								
								<img src="../resources/img/1.png" width="30px;" height="30px" name = "${list.boardidx}" onclick="like_toggle(${list.boardidx});"/>

							
								</div>
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
	<jsp:include page="../include/bottom.jsp" />
	<jsp:include page="../include/sidebar.jsp" />
</body>

</html>
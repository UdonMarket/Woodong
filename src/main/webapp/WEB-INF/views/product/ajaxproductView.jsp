<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<c:choose>
	<c:when test="${check eq 1}">
		!!!!!!! ${viewRow.publicSet}
	</c:when>
	<c:otherwise>
	
	
<!-- ajaxproductView.jsp (ajax View ) -->
      <%-- 상품 상세보기 추가부분 --%>
      
      <section class="content1" style="padding-top: 0px;">
         <div class="item_list_area">
            <div class="item_list_area_box">
               <div class="breadcrumbs"> </div>
               <div class="main_area">
                  <div class="main_area_center">
                     <div class="main">
                        <div class="detail_box">
                              <div class="detail_top_area">
                                 <div class="row" style="margin: 0; height: 450px">
                                    <div class="col-1"></div>
                                    <div id="demo" class="carousel slide col-4" data-ride="carousel">
                                       <ul class="carousel-indicators">
                                          <li data-target="#demo" data-slide-to="0" class="active"></li>
                                          <li data-target="#demo" data-slide-to="1"></li>
                                          <li data-target="#demo" data-slide-to="2"></li>
                                       </ul>
                                       <form:form name="viewForm" role="form">
                                          <input type="hidden" name="id" value="${viewRow.id}">
                                          <input type="hidden" name="bname" value="${viewRow.bname}" />
                                          <input type="hidden" name="boardidx" value="${viewRow.boardidx}" />
                                          <input type="hidden" name="nowPage" value="${param.nowPage}">
                                       </form:form>
                                       <div class="carousel-inner">
                                          <c:forEach var="uploadFile" items="${uploadFileList}" varStatus="status">
                                             <c:if test="${status.first}">
                                                <div class="carousel-item active">
                                                   <img src="../resources/Upload/${uploadFile.save_name}" style=" width:350px; height:300px;" />
                                                </div>
                                             </c:if>
                                             <c:if test="${!status.first}">
                                                <div class="carousel-item">
                                                   <img src="../resources/Upload/${uploadFile.save_name}"   style=" width:350px; height:300px;"/>
                                                </div>
                                             </c:if>
                                          </c:forEach>
                                       </div>
                                       
                                       <c:forEach var="file" items="${uploadFileList}" varStatus="status">
                                          <c:if test="${not empty file.threedimage}">
                                             <c:set var="tdimage" value="${file.threedimage}" />
                                          </c:if>
                                       </c:forEach>
                                       
                                       <!-- Left and right controls -->
                                       <a class="carousel-control-prev" href="#demo" data-slide="prev"> <span class="carousel-control-prev-icon"></span></a>
                                        <a class="carousel-control-next" href="#demo"   data-slide="next">
                                         <span class="carousel-control-next-icon"></span>
                                       </a>
                                    </div>
                                    <div class="item_info col-6" style="height: 100%">
                                       <div class="row">
                                          <div class="item_title_area col-12">
                                             <span class="item_tag">
                                                <span class="used_type_tag">${viewRow.product_state}</span>
                                                <c:if test="${viewRow.woopay eq 'Y'}">
                                                   <span class="delivery_tag used_type_tag_active  used_type_tag_active">우동페이</span>
                                                </c:if>
                                                <span class="wish_box">
                                                   <img src="https://ccimage.hellomarket.com/web/2020/item/ico_zzim_24x23_s_x2.png" alt="찜하기이미지" class="wish_icon"> 
                                                   <label>${viewRow.likecount}</label>
                                                </span>
                                             </span>
                                          </div>
                                       </div>
                                       <div class="row">
                                          <div class="col-12">
                                             <span class="item_title" >${viewRow.title}</span>
                                          </div>
                                       </div>
                                       <div class="row">
                                          <div class="item_price_box item_price_box_bottom col-12">
                                             <div class="item_price_box_bottom_low">
                                                <div class="item_price item_price_bottom">
                                                   <fmt:formatNumber type="number" maxFractionDigits="3" value="${viewRow.price}"/> 원
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                       <div class="only_description_hellopay common_description_deal row">
                                          <div class="col-12">
                                             <div class="detail_bottom_box" style="margin-bottom: 50px;">
                                                <div class="detail_bottom_area">
                                                   <img src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_time_x2.png" alt="게시물업로드일" class="item_location_img">
                                                  <span class="time">게시물 업로드일 : ${viewRow.postdate}</span>
                                                </div>
                                                <div class="detail_bottom_area">
                                                   <img src="https://ccimage.hellomarket.com/web/2020/item/ico_detail_info_location_x2.png" alt="지도아이콘" class="item_location_img">
                                                   <span class="time">거래 희망 위치  : ${viewRow.deal_location} </span>
                                                </div>
                                                <div class="detail_bottom_area1 detail_bottom_tag_area" style="margin-left: 10px;">
                                                   <span class="tag" style="color: #ff4f4f;">
                                                      <c:forTokens var="item" items="${viewRow.product_tag}" delims="#">
                                                         <a href="./productList.woo?searchField=product_tag&searchTxt=${item}">
                                                            <button type="button" class="btn_ca">#${item}</button>
                                                         </a>
                                                      </c:forTokens>
                                                   </span>
                                                </div>
                                             </div>
                                             <div>
                                                <c:choose>
                                                   <c:when test="${sellingStatus eq '판매전'}">
                                                      <img src="../resources/img/product/상태-판매전.png" style="width: 75px; height: 45px; margin-bottom: -2px;" />
                                                      <div class="container">
                                                         <div class="progress">
                                                            <div class="progress-bar bg-danger progress-bar-striped progress-bar-animated" style="width: 6%"></div>
                                                         </div>
                                                      </div>
                                                   </c:when>
                                                   <c:when test="${sellingStatus eq '판매중'}">
                                                      <img src="../resources/img/product/상태-판매중.png" style="width: 75px; height: 45px; margin-bottom: -2px; margin-left: 158px;" />
                                                      <div class="container">
                                                         <div class="progress">
                                                            <div class="progress-bar bg-danger progress-bar-striped progress-bar-animated" style="width: 50%"></div>
                                                         </div>
                                                      </div>
                                                   </c:when>
                                                   <c:otherwise>
                                                      <img src="../resources/img/product/상태-판매완료.png" style="width: 90px; height: 45px; margin-bottom: -2px; margin-left: 325px;" />
                                                      <div class="container">
                                                         <div class="progress">
                                                            <div class="progress-bar bg-danger progress-bar-striped progress-bar-animated" style="width: 100%"></div>
                                                         </div>
                                                      </div>
                                                   </c:otherwise>
                                                </c:choose>
                                             </div>
                                             <div class="row" style="margin-top: 60px">
                                                <div class="col-2" style="padding: 0px;"></div>
                                                <div class="col-4" style="padding: 0px;">
                                                   <c:if test="${viewRow.three_dimens eq 'Y'}">
                                                    <!-- data-toggle="modal" data-target="#tdModal"  -->
                                                      <img src="../resources/img/product/3d 이미지.png"  style="width: 125px; height: 75px; margin-left: 8px;" 
                                                      data-toggle="modal" data-target="#tdModal" />
                                                   </c:if>
                                                </div>
                                                <div class="col-3" style="padding: 0px;">
                                                  <c:if test="${viewRow.woopay eq 'Y'}">
                                       				<a href="../product/woopay.woo?boardidx=${viewRow.boardidx}&price=${viewRow.price}&title=${viewRow.title}&sellerID=${viewRow.id}">
                                       					<img src="../resources/img/product/우동페이.png" /></a>
                                   					 </c:if>
                                                </div>
                                                <div class="col-3" style="padding: 0px;">

                                                   <img src="../resources/img/product/우동톡톡.png" onclick="window.open('http://192.168.219.142:8282/woodong/chatting/chatting.woo?boardidx=${viewRow.boardidx}&sellerid=${viewRow.id}', 'name(${row.chatroomidx})', 'height=640; width=480; top=200; left=700;', true);" />

                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                              </div>
                           </div>
                           </div>
                           <div class="detail_box_bottom1 detail_box_item1" style="padding-top: 5px">
                              <div class="detail_comment1 row">
                                 <div class="col-1"></div>
                                 <div class="col-6">
                                    <div class="row">
                                       <div class="description1 col-12">
                                          <div class="description_title1" style="margin-left: -70px; margin-top: -20px; margin-bottom: -20px;">
                                             <img src="../resources/img/product/상세설명.png" alt="" width="250px;" />
                                          </div>
                                       </div>
                                       <div class="detail_item_description col-12">
                                       <!-- style="font-size: 1.2em; width:400px; word-break:break-all;word-wrap:break-word;" class="description_text1" -->
                                          <div style="font-size: 1.2em; width:400px; word-break:break-all;word-wrap:break-word; color: black;">${viewRow.contents} </div>
                                       </div>
                                    </div>
                                 </div>
                                 <!--  -->
                                   <div class="col-4">
                                    <div class="row">
                                       <div class="col-12" style="border: 1px solid #d9d9d9; width: 200px; height: 300px;">
                                          <div class="my_profile_info">
                                             <div class="row">
                                                <div class="col-3"></div>
                                                <div class="my_profile_image col-6"
                                                   style="text-align: center; width: 150px; height: 150px; padding-top: 20px; padding-bottom: 170px; padding-left: px;">
                                                   <a href="../mypage/myPage.woo?mode=review&dealPosition=seller&seller_id=${viewRow.id}&">${udongGrade}</a>
                                                </div>
                                                <div class="col-3"></div>
                                             </div> 
                                             <div class="my_profile_nick"style="text-align: center; font-size: 18px; font-weight: bold; padding-bottom: 5px; padding-top: 5px; color: black;">
                                          										   판매자 : ${viewRow.id}</div>
                                             <div class="my_profile_pro_review">
                                                <div class="my_profile_pro_review_box">
                                                <c:choose>
                                                <c:when test="${viewRow.id eq user_id}">
	                                                <div style="margin-left:40px; margin-top: 20px;">
	                                                 	 <img src="../resources/img/myPage/삭제.png" style="width: 70px; height: 50px;" id="delete_btn" />
	                                            		 <img src="../resources/img/myPage/수정.png" style="width: 70px; height: 50px;" id="update_btn" />
	                                            		 <img src="../resources/img/product/jumpboard.png" style="width: 70px; height: 50px;" id="jump_btn" />
	                                           		 </div>
                                                </c:when>
                                                <c:otherwise>
                                             		 <div class="my_profile_pro_review">
                                                         <div class="my_profile_pro_review_rating"  style="white-space: nowrap; width: 40px; height: 20px; padding-left: 20px;">
                                                            <span style="padding-left: 10px; font-size: 15px;">거래후기     : <span style="font-weight: bold;">
                                                            ${memberVO.avg_score}개</span>&nbsp;</span>${score}
                                                            <br />
                                                            <span style="font-size: 15px; padding-left: 10px;">거래횟수  : 
                                                              <span style="font-weight: bold; font-size: 15px;">${memberVO.trade_count}&nbsp;번</span>
                                                            </span>
                                                         </div>
                                                      </div>
                                                </c:otherwise>
                                                </c:choose> 
                                                
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                           </div>
                           <!--  -->
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>

      </section>
    <script>
      $(document).ready(function() {
         var formObj = $("[name='viewForm']");

         // 수정 
         $("#update_btn").on("click", function() {
            formObj.attr("action", "./productUpdate.woo");
            formObj.attr("method", "post");
            formObj.submit();
         });
         // 삭제
         $("#delete_btn").on("click", function() {

            var deleteYN = confirm("삭제하시겠습니까?");
            if (deleteYN) {
               formObj.attr("action", "./productDelete.woo");
               formObj.attr("method", "post");
               formObj.submit();
            }
         });
         // 끌올
         $("#jump_btn").on("click", function() {

            var jumpYN = confirm("끌올 하시겠습니까? 끌올시 우동페이 수수료가 3.0% 에서 3.4% 로 증가합니다!");
            if (jumpYN) {
               formObj.attr("action", "./productJump.woo");
               formObj.attr("method", "post");
               formObj.submit();
            }
         });
      });


   </script>

   <form:form name="chattingFrm">
      <input type="hidden" name="boardidx" value="${viewRow.boardidx}" />
      <input type="hidden" name="sellerid" value="'${viewRow.id}'" />
   </form:form>
   <!-- The Modal start-->
   <!-- margin-top: 100px; -->
   <div class="modal fade" id="tdModal" >
      <div class="modal-dialog modal-dialog-centered modal-lg">
         <div class="modal-content">
            <!-- Modal Header -->
          <!--   <div class="modal-header">
               <h4 class="modal-title">3D이미지</h4>
               <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
            </div> -->
            <!-- Modal body -->
            <div class="modal-body">
               <!--3D .product-viewer   -->
               <div class="cd-product-viewer-wrapper" data-frame="8"  data-friction="0.33">
                  <div>
                     <figure class="product-viewer">
                         <img src="../resources/Upload/${tdimage}" alt="Product Preview" style="width: 550px; height: 550px;"> 
                           
                        <div class="product-sprite"
                           data-image="../resources/Upload/${tdimage}"	
                           style="background: url(../resources/Upload/${tdimage}) no-repeat center center;"></div>
                     </figure>
                     <!-- .product-viewer -->
                     <div class="cd-product-viewer-handle">
                        <span class="fill" style="transform: scaleX(1);"></span> <span class="handle">Handle</span>
                           
                     </div>
                  </div>
               </div>
               <script src="../resources/js/main.js"></script>
               <script src="../resources/js/jquery.mobile.custom.min.js"></script>
               <!--3D .product-viewer   -->
            </div>
         </div>
      </div>
   </div>
   <!-- The Modal end-->
   </c:otherwise>
</c:choose>
   

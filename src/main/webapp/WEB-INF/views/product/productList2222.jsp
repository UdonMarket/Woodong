<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>
<body>

    <!--::header part start::-->
    <!-- header.jsp --> 
    <jsp:include page="../include/hearder.jsp"/>
    <!-- Header part end-->

    <!-- breadcrumb part start-->
    <section class="breadcrumb_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>product list</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->
    
    <!-- Search Form Section Begin -->
    <div class="search-form">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="search-form-text">
                        <div class="search-text">
                            <i class="fa fa-search"></i>
                            Find Your Product
                        </div>
                        <div class="home-text">
                            <i class="fa fa-home"></i>
                            		우리동네마켓
                        </div>
                    </div>
                    <form action="#" class="filter-form">
                        <div class="first-row">
                            <select>
                                <option value="">정렬방식</option>
                                <option value="">최신순</option>
                                <option value="">저가순</option>
                                <option value="">고가순</option>
                            </select>
                            <select>
                                <option value="">상품상태</option>
                                <option value="">새상품</option>
                                <option value="">거의새것</option>
                                <option value="">중고</option>
                                <option value="">하자있음</option>
                            </select>
                            <select>
                                <option value="">거래종류</option>
                                <option value="">판매</option>
                                <option value="">무료나눔</option>
                                <option value="">삽니다</option>
                            </select>
                            <select>
                                <option value="">판매자 온도</option>
                                <option value="">튀김우동</option>
                                <option value="">일반우동</option>
                            </select>
                        </div>
                        <div class="second-row">
                        <div style="width: 530px; display: inline-block; margin-right:20px;">
							<input type="text" name="first_name" placeholder="검색할 상품명"
								onfocus="this.placeholder = ''" onblur="this.placeholder = '검색할 상품명'" required
								class="single-input">
					  </div>
                            <div class="price-range-wrap">
                                <div class="price-text">
                                    <label for="priceRange">가격:</label>
                                    <input type="text" id="priceRange" readonly>
                                </div>
                                <div id="price-range" class="slider"></div>
                            </div> 
                            <button type="button" class="search-btn">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Search Form Section End -->
   
    
    <!-- product list part start-->
    <section class="product_list section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                
					<div class="blog_right_sidebar">

						<aside class="single_sidebar_widget post_category_widget" style="background-color: #Fcf8e3">
							<a href="productWrite.woo" class="genric-btn danger radius"> 글쓰기</a>
							<h4 class="widget_title" style="margin-top: 30px">상품 리스트</h4>
							<ul class="list cat-list">
								<li><a href="#" class="d-flex">
										<p>인기매물</p><!-- 인기매물 bname = ranking -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>의류(남성/여성/아동)</p><!-- 의류 bname = clothes -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>가전/디지털</p><!-- 가전/디지털 bname = digital -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>가구</p><!-- 가구 bname = funiture -->
								</a></li>

								<li><a href="#" class="d-flex">
										<p>스포츠</p><!-- 스포츠 bname = sports -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>유아용품</p><!-- 유아용품 bname = baby -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>뷰티/여성잡화</p><!-- 뷰티/여성잡화 bname = beauty -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>게임/도서</p><!-- 게임/도서 bname = gameNbook -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>반려동물</p><!-- 반려동물 bname = animal -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>기타</p><!-- 기타 bname = etc -->
								</a></li>
								<li><a href="#" class="d-flex">
										<p>삽니다</p><!-- 삽니다 bname = buy -->
								</a></li>

							</ul>

						</aside>
					</div>
				</div>


                <div class="col-md-9">
                    <div class="product_list">
                        <div class="row">
                        <!-- 상품 리스트 반복 start-->
                        <c:forEach items="${lists }" var="row">	
                            <div class="col-lg-4 col-sm-4">
                                <div class="single_product_item" id="boardHTML">
                                    <img src="${pageContext.request.contextPath }/resources/img/arrivel/arrivel_1.png"  width="100px">
                                    <h3> <a href="./productView.woo?idx=${row.idx}&nowPage=${nowPage}">${row.title}</a> </h3>
                                    <p>${row.price}</p>
                                </div>
                            </div>
                         </c:forEach>   
                        <!-- 상품 리스트 반복 end-->
                        </div>
                        <div class="load_more_btn text-center">
                            <a href="#" class="btn_3">Load More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- product list part end-->
    
    <!-- client review part here -->
	<!-- 삭제  -->
    <!-- client review part end -->

    <!-- feature part here -->
    <!-- 삭제  -->
    <!-- feature part end -->

    <!-- subscribe part here -->
    <!-- 삭제  -->
    <!-- subscribe part end -->

    <!--::footer_part start::-->
    <footer class="footer_part">
            <div class="footer_iner">
                <div class="container">
                    <div class="row justify-content-between align-items-center">
                        <div class="col-lg-8">
                            <div class="footer_menu">
                              <!-- 0705 home 외 6 삭제 -->
                            </div>
                        </div>
                      <!--0705  아이콘 삭제 -->
                        
                    </div>
                </div>
            </div>
            
            <div class="copyright_part">
                <div class="container">
                    <div class="row ">
                        <div class="col-lg-12">
                            <div class="copyright_text">
                                <P><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="ti-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></P>
                                <div class="copyright_link">
                                    <a href="#">Turms & Conditions</a>
                                    <a href="#">FAQ</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </footer>
    <!--::footer_part end::-->

     <!-- jquery plugins here-->
    <script src="./resources/js/jquery-1.12.1.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <!-- popper js -->
    <script src="./resources/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="./resources/js/bootstrap.min.js"></script>
    <!-- magnific popup js -->
    <script src="./resources/js/jquery.magnific-popup.js"></script>
    <!-- carousel js -->
    <script src="./resources/js/owl.carousel.min.js"></script>
    <script src="./resources/js/jquery.nice-select.min.js"></script>
    <!-- slick js -->
    <script src="./resources/js/slick.min.js"></script>
    <script src="./resources/js/jquery.counterup.min.js"></script>
    <script src="./resources/js/waypoints.min.js"></script>
    <script src="./resources/js/contact.js"></script>
    <script src="./resources/js/jquery.ajaxchimp.min.js"></script>
    <script src="./resources/js/jquery.form.js"></script>
    <script src="./resources/js/jquery.validate.min.js"></script>
    <script src="./resources/js/mail-script.js"></script>
    <!-- custom js -->
    <script src="./resources/js/custom.js"></script>
    
    <!-- (추가)  search Form Slider bar js파일 -->
    <script src="./resources/js/slider.js"></script>
    
   
</body>

</html>
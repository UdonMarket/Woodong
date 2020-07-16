<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 	 
<section class="breadcrumb_part" >
		<div class="container-fluid">
			<div class="row top_image"></div>
			<img src="../resources/img/product/카테고리.png" alt="" id="main" style="height: 100%; width: 100%">
		</div>
	</section>
    <!-- breadcrumb part end-->
    
    <!-- Search Form Section Begin -->
    <section style="padding-top: 130px">
	    <div class="search-form">
	        <div class="container">
	        	<div class="row">
	        		<div class="col-9"></div>
	        		<div class="col-3" style="padding: 0px;">
	        		<div style="display: inline;">
	        			<img src="../resources/img/product/map1.png" alt="" style="width: 120px;"/>
        			</div>
        			<div style="display: inline;">
	        			<img src="../resources/img/product/이미지로보기.png" alt="" style="width: 155px; ,margin-bottom: -10px"/>
        			</div>
	        		</div>
	        	</div>
	            <div class="row" style="padding-top: 20px">
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
	                     <form:form action="./ajaxList.woo" class="filter-form">
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
	                                <div id="price-range" class="slider" style="background: #d9d9d9;"></div>
	                            </div> 
	                            <button type="button" class="search-btn">Search</button>
	                        </div>
	                      </form:form>
	                </div>
	            </div>
	        </div>
	    </div>
    </section>
    <!-- Search Form Section End -->
   
    
    <!-- product list part start-->
    <section class="product_list section_padding" style="padding-top: 50px">
        <div class="container">
            <div class="row">
			<div class="col-lg-3">
			                
				<div class="my_profile_nav">
					<ul style="background-color:#FFF;border:1px solid #d9d9d9;">
						<li>
							<a class="active" id="scrollMain"href="/m/level.hm"><span style="font-size:1.4em;color:#ff4f4f;">상품 리스트</span></a>
						</li>
						<c:forEach items="${lists }" var="row">
							<li>
					 			<a href="${row.requestname }"><span>${row.bname }</span></a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
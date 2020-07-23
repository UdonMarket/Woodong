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
    <script>
    var span;
	window.onload = function(){
		span = document.getElementById("result");
		if(navigator.geolocation){
			span.innerHTML = "Geolocation API를 지원합니다.";
			
			var options = {	
				enableHighAccurcy:true, 
				timeout:5000,
				maximumAge:3000
			};
			navigator.geolocation.getCurrentPosition(showPosition,showError,options);
			
		}
		else{
			span.innerHTML = "이 브라우저는 Geolocation API를 지원하지 않습니다.";
		}	
	}
	var showPosition = function(position){
		//위도를 가져오는 부분
		var latitude = position.coords.latitude;
		//경도를 가져오는 부분
		var longitude = position.coords.longitude;
		span.innerHTML = "위도:"+latitude+",경도:"+longitude;	
		
		////////////////////////////////////////////////////////////////////////
		//위경도를 text input에 입력
		document.getElementById("lat").value = latitude;
		document.getElementById("lon").value = longitude;
		////////////////////////////////////////////////////////////////////////
		
			
		//위경도를 가져온후 지도 표시
		initMap(latitude, longitude) ;
	}
	var showError = function(error){
	switch(error.code){
		case error.UNKNOWN_ERROR:
			span.innerHTML = "알수없는오류발생";break;
		case error.PERMISSION_DENIED:
			span.innerHTML = "권한이 없습니다";break;
		case error.POSITION_UNAVAILABLE:
			span.innerHTML = "위치 확인불가";break;
		case error.TIMEOUT:
			span.innerHTML = "시간초과";break;
	}
	}
    </script>
    <!-- Search Form Section Begin -->
    <section style="padding-top: 130px">
    <span id="result" style="display: none"></span>
	    <div class="search-form">
	        <div class="container">
	        	<div class="row">
	        		<div class="col-9"></div>
	        		<div class="col-3" style="padding: 0px;">
	        		<div style="display: inline-block;">
        			    <form:form action="../product/productListMap.woo" method="post">
				    <!-- 현재위치 위경도 입력상자 -->
							<input type="hidden" id="lat" name="lat" />
							<input type="hidden" id="lon" name="lon" />
							<input type="image" src="../resources/img/product/map1.png" alt=""style="margin-bottom: -20px;width: 120px;cursor: pointer;" />
		        			<!-- <img src="../resources/img/product/map1.png" alt="" style="width: 120px;cursor: pointer;"onclick="location.href='../product/productListMap.woo';"/> -->
					    </form:form>
        			</div>
        			<div style="display: inline-block;">
	        			<img src="../resources/img/product/이미지로보기.png" alt="" style="margin-bottom: -12px;width: 155px; cursor: pointer;"onclick="location.href='../product/productList.woo';"/>
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
	                                <option value="">인기순</option>
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
	                                <option value="">차가운 일반우동</option>
	                                <option value="">따뜻한 일반우동</option>
	                                <option value="">차가운 튀김우동</option>
	                                <option value="">따뜻한 튀김우동</option>
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
	                            <button type="button" class="search-btn" style="border: 0;">Search</button>
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
						<c:forEach items="${blists }" var="row">
							<li>
					 			<a href="${row.requestname }"><span>${row.bname }</span></a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
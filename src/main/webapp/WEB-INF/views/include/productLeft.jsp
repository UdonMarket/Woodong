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
		document.getElementById("lat1").value = latitude;
		document.getElementById("lon1").value = longitude;
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
	function aa(f) {
		f.submit();
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
	        			    <form:form action="../product/productList.woo?mode=map&bname=${parameterVO.bname}&" method="post">
					    <!-- 현재위치 위경도 입력상자 -->
								<input type="hidden" id="lat" name="lat" />
								<input type="hidden" id="lon" name="lon" />
								<input type="image" src="../resources/img/product/map1.png" style="margin-bottom: 0px;width: 120px;cursor: pointer;" />
						    </form:form>
	        			</div>
	        			<div style="display: inline-block;">
	        				 <form:form action="../product/productList.woo?bname=${parameterVO.bname}&" method="post">
					    <!-- 현재위치 위경도 입력상자 -->
								<input type="hidden" id="lat1" name="lat" />
								<input type="hidden" id="lon1" name="lon" />
								<input type="image" src="../resources/img/product/이미지로보기.png" style="margin-bottom: -12px;width: 155px; cursor: pointer;" />
						    </form:form>
	        			</div>
	        		</div>
	        	</div>
	            <div class="row" style="padding-top: 20px">
	                <div class="col-lg-12">
	                    <div class="search-form-text">
	                        <div class="search-text"><i class="fa fa-search"></i> 원하는 조건으로  검색해보세요 ! </div>
	                        <div class="home-text"> <i class="fa fa-home"></i> Find Your Product in WOODONG </div>
	                    </div>
	                     <form:form class="filter-form">
	                        <div class="first-row" >
	                            <select name="order">
	                                <option value="" <c:out value="${parameterVO.order == null ? 'selected' : ''}"/>> ---  최신순 ( 정렬방식 ) --- </option>
	                                <option value="visitcount desc" <c:out value="${parameterVO.order eq 'visitcount' ? 'selected' : ''}"/>>조회순</option>
	                                <option value="likecount desc" <c:out value="${parameterVO.order eq 'likecount' ? 'selected' : ''}"/>>좋아요 순</option>
	                                <option value="price" <c:out value="${parameterVO.order eq 'price' ?  'selected': ''}"/>>저가순</option>
	                                <option value="price desc" <c:out value="${parameterVO.order eq 'price desc' ? 'selected' : ''}"/>>고가순</option>
	                            </select>
	                            <select name="pstate">
	                                <option value=""  <c:out value="${parameterVO.pstate == null ? 'selected' : ''}"/>> ---- 상품상태 ( 전체 ) ---- </option>
	                                <option value="새상품" <c:out value="${parameterVO.pstate eq '새상품' ? 'selected' : ''}"/>>새상품</option>
	                                <option value="거의새것" <c:out value="${parameterVO.pstate eq '거의새것' ? 'selected' : ''}"/>>거의새것</option>
	                                <option value="중고" <c:out value="${parameterVO.pstate eq '중고' ? 'selected' : ''}"/>>중고</option>
	                                <option value="하자있음" <c:out value="${parameterVO.pstate eq '하자있음' ? 'selected' : ''}"/>>하자있음</option>
	                            </select>
								 <select name="ispay">
	                                <option value="" <c:out value="${parameterVO.ispay == null ? 'selected' : ''}"/>>우동페이 + 전체 (결제방식)</option>
	                                <option value="only" <c:out value="${parameterVO.ispay eq 'only' ? 'selected' : ''}"/>>우동페이만 보기</option>
	                            </select>
	                            <!-- price-range-wrap -->
	                             <div class="price-range-wrap" style="width: 530px;display: table-cell;">
	                                <div class="price-text"> 
	                                	<p>
	                                	가격&nbsp;&nbsp;
	                                    <input type="text" id="priceviewStart"  style="width: 70px; text-align: center;" readonly>
	                                    &nbsp;&nbsp;~&nbsp;&nbsp;
	                                    <input type="text" id="priceviewEnd"  style="width: 80px; text-align: center;"  readonly>
	                                    &nbsp;&nbsp;원
	                                	</p>
	                                </div>
	                                <div id="price-range" class="slider" style="background: #d9d9d9; margin-top: 10px;"></div>
	                            </div>  
	                            <!-- price-range-wrap -->
	                            <input type="hidden" id="priceStart" name="priceStart"/>
	                            <input type="hidden" id="priceEnd" name="priceEnd"/>
	                            <input type="hidden" id="bname" value="${parameterVO.bname}"/>
	                        </div>
	                        <div class="second-row">
							  	<select name="searchField">
	                                <option value="" <c:out value="${parameterVO.searchField  == null ? 'selected' : ''}"/>>--검색필드를 선택하세요--</option>
	                                <option value="tc" <c:out value="${parameterVO.searchField eq 'tc' ? 'selected' : ''}"/>>제목 + 내용</option>
	                                <option value="product_tag" <c:out value="${parameterVO.searchField eq 'product_tag' ? 'selected' : ''}"/>>태그</option>
	                                <option value="title" <c:out value="${parameterVO.searchField eq 'title' ? 'selected' : ''}"/>>제목</option>
	                                <option value="contents" <c:out value="${parameterVO.searchField eq 'contents' ? 'selected' : ''}"/>>내용</option>
	                                <option value="id" <c:out value="${parameterVO.searchField eq 'id' ? 'selected' : ''}"/>>작성자</option>
	                            </select>
		                        <div style="width: 530px; display:inline-block; margin-right:20px;">
									<input type="text" name="searchTxt" placeholder="검색어를  입력하세요"
										onfocus="this.placeholder=''" onblur="this.placeholder='검색어를  입력하세요'" required="required"
										class="single-input" id="keywordInput" >
							  	</div>
	                            <button type="button" class="search-btn" style="border: 0;" id="searchBtn">Search</button>
	                        </div>
                         </form:form>
<script>
$(function(){
	$('#searchBtn').click(function() {
	self.location = "./productList.woo?bname="+$("#bname").val() 
	 + "&order=" + $("select[name=order]").val() 
	 + "&pstate=" + $("select[name=pstate]").val() 
	 + "&ispay=" + $("select[name=ispay]").val() 
	 + "&priceStart=" + $("#priceStart").val()  + "&priceEnd=" + $("#priceEnd").val() 
	 + "&searchField=" + $("select[name=searchField]").val() + "&searchTxt=" + encodeURIComponent($('#keywordInput').val())+"&";
	});

});  



</script>
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
							<a href="javascript:void(0);"><span style="font-size:1.4em;color:#ff4f4f;">상품 리스트</span></a>
						</li>
						<li>
							<form:form action="../product/productList.woo?mode=${mode}&" method="post">
								<input type="hidden" name="lat"  value="${parameterVO.latTxt }"/>
								<input type="hidden" name="lon"  value="${parameterVO.lngTxt }"/>
								<button type="submit" style="cursor:pointer; border: none; background: none; font-size: 17px; padding: 18px 0px 18px 22px;">모든상품</button>
						    </form:form>
						</li>
						<c:forEach items="${blists }" var="row">
							<li>
								<form:form action="${row.requestname }"> 
									<input type="hidden" name="mode" value="${mode}" />
									<input type="hidden" name="lat"  value="${parameterVO.latTxt}"/>
									<input type="hidden" name="lon"  value="${parameterVO.lngTxt}"/>
									<button type="submit" style="cursor:pointer; border: none; background: none; font-size: 17px; padding: 18px 0px 18px 22px;">${row.bname}</button>
						 		</form:form>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>

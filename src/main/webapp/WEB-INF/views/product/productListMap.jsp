<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
  <style>
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:43%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4416f1cdac23198286eb3f5394e6240d&libraries=services"></script>

<body>

	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<!-- breadcrumb part start-->

	<jsp:include page="../include/productLeft.jsp" />
	
	<div class="col-md-9" style="padding-top: 37px;padding-left: 50px;" >
		<div class="row" id="boardHTML">
    <div id="map" style="width:800px;;height:500px;position:relative;overflow:hidden;"></div>
		
		</div>
		
		
	</div>
	
	</div>
	</div>
	</section>
	<script>
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            
	        var imageSrc = '../resources/img/map/지도마커1-1.png', // 마커이미지의 주소입니다    
	        imageSize = new kakao.maps.Size(25), // 마커이미지의 크기입니다
	        imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	          
		    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		        markerPosition = locPosition; // 마커가 표시될 위치입니다
	
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        position: markerPosition, 
		        image: markerImage // 마커이미지 설정 
		    });
	
		    // 마커가 지도 위에 표시되도록 설정합니다
		    marker.setMap(map);
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
	    	var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	        	message = 'geolocation을 사용할수 없어요..'
	        
	        	var imageSrc = '../resources/img/map/지도마커1-1.png', // 마커이미지의 주소입니다    
	            imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
	            imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	              
	        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	            markerPosition = locPosition; // 마커가 표시될 위치입니다

	        // 마커를 생성합니다
	        var marker = new kakao.maps.Marker({
	            position: markerPosition, 
	            image: markerImage // 마커이미지 설정 
	        });

	        // 마커가 지도 위에 표시되도록 설정합니다
	        marker.setMap(map);
	}
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
	var overlay = new kakao.maps.CustomOverlay({
	    map: null,
	    position: null,
	    content: null,
	    yAnchor: 1 
	});
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(); 
	
	// 키워드로 장소를 검색합니다
	ps.keywordSearch('가산디지털단지역 맛집', placesSearchCB); 
	
	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();
	
	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	}

	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
		var imageSrc = '../resources/img/map/지도마커1-2.png', // 마커이미지의 주소입니다    
	    	imageSize = new kakao.maps.Size(30), // 마커이미지의 크기입니다
	    	imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
		    //markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        image: markerImage, // 마커이미지 설정 
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });
	
	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	    	// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    	var content = '<div class="customoverlay">' +
	    	    '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
	    	    '    <span class="title">'+place.place_name +'</span>' +
	    	    '  </a>' +
	    	    '</div>';

	    	// 커스텀 오버레이가 표시될 위치입니다 
	    	var position = new kakao.maps.LatLng(place.y, place.x);  
	    	overlay.setMap(map);
	    	overlay.setPosition(position);
	    	overlay.setContent(content);
	    });
	}
	</script>
	<jsp:include page="../include/bottom.jsp" />
	
	<jsp:include page="../include/sidebar.jsp" />
	
</body>

</html>
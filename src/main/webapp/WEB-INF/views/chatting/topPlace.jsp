<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../include/head.jsp" />

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4416f1cdac23198286eb3f5394e6240d&libraries=services"></script>
<body>
<jsp:include page="../include/hearder.jsp" />
<div class="container" style="padding-top: 100px;">
	<div class="row">
		<div class="col-10" id="map" style="width:800px;;height:750px;overflow:hidden;"></div>
	</div>
	<div class="row">
		<div class="col-9" style="text-align: center;font-size: 40px; font-weight: bold; color: #ff4f4f">
			&nbsp;&nbsp;<i class='fas fa-map-marked-alt' style='font-size:36px'></i>&nbsp;&nbsp;${parameterVO.place } 거래추천 장소
		</div>
	</div>
</div>
<script>
//위경도를 가져온후 지도 표시
initMap(${parameterVO.latTxt}, ${parameterVO.lngTxt}) ;

function initMap(latVar, lngVar) {				
	var uluru = {lat: latVar, lng: lngVar};
	
	var map = new kakao.maps.Map(document.getElementById('map'), {
		center: new kakao.maps.LatLng(latVar, lngVar),
		level: 6 
});
	
	var imageSrc = '../resources/img/map/지도마커1-1.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(30), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
    //markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다
// 마커를 생성하고 지도에 표시합니다
var marker = new kakao.maps.Marker({
    map: map,
    image: markerImage, // 마커이미지 설정 
    position: new kakao.maps.LatLng(latVar, lngVar) 
});
	//////////////////////////////////////////////////////////////////////////
	//다중마커s
	
 	//시설을 맵에 표시
	var locations = [		
		/* ['명동', 37.563576, 126.983431],
		['가로수길', 37.520300, 127.023008],
		['광화문', 37.575268, 126.976896],
		['남산', 37.550925, 126.990945],
		['이태원', 37.540223, 126.994005] */
		<c:forEach items="${searchLists }" var="row">
			['${row.juso }', ${row.latitude }, ${row.longitude },], 
		</c:forEach>
	];
	
 	var marker, i;
 	var overlay = new kakao.maps.CustomOverlay({
	    map: null,
	    position: null,
	    content: null,
	    yAnchor: 1 
	});
 	for (i=0; i<locations.length; i++) { 
	var imageSrc = '../resources/img/map/지도마커1-2.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(30), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	    //markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다
    // 마커를 생성하고 지도에 표시합니다
    marker = new kakao.maps.Marker({
        map: map,
        image: markerImage, // 마커이미지 설정 
        position: new kakao.maps.LatLng(locations[i][1], locations[i][2]) 
    });
		
    	asas(locations[i]);
    // 마커에 클릭이벤트를 등록합니다
    
}
 	function asas(locations) {
 		var location = locations;
 	kakao.maps.event.addListener(marker, 'click', function() {
    	// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    	var content = '<div class="customoverlay">' +
	    '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
	    '    <span class="title">'+location[0]+'</span>' +
	    '  </a>' +
	    '</div>';
    	// 커스텀 오버레이가 표시될 위치입니다 
    	var position = new kakao.maps.LatLng(location[1], location[2]);  
    	overlay.setMap(map);
    	overlay.setPosition(position);
    	overlay.setContent(content);
    });
	}
	//다중마커s
	//////////////////////////////////////////////////////////////////////////
}

</script>
<jsp:include page="../include/bottom.jsp" />
	
	<jsp:include page="../include/sidebar.jsp" />

</body>
</html>
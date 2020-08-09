<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<jsp:include page="../include/head.jsp" />
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4416f1cdac23198286eb3f5394e6240d&libraries=services">
</script>
	
<body>
<div style="height: 2000px">
		<div id="map" style="width:100%; height:100%;" border="1px solid black"></div>
</div>
<script>
//위경도를 가져온후 지도 표시
initMap(${latitude}, ${logitude});

var map;
var marker;
function initMap(latVar, lngVar) {				
	var uluru = {lat: latVar, lng: lngVar};
	
	map = new kakao.maps.Map(document.getElementById('map'), {
		center: new kakao.maps.LatLng(latVar, lngVar),
		level: 2
});
	
	var imageSrc = './resources/img/map/지도마커1-1.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(30), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
    //markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다
// 마커를 생성하고 지도에 표시합니다
marker = new kakao.maps.Marker({
    map: map,
    image: markerImage, // 마커이미지 설정 
    position: new kakao.maps.LatLng(latVar, lngVar) 
});
marker.setMap(map);  
}
	
</script>

<script type="text/javascript">
$(document).ready(function() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(function() {
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});

	});
	setInterval(function() {	
		$.ajax({
			type : "get",
			url : './Wooajaxmap.woo',
			dataType : "json",
			contentType : "text/html;charset:utf-8",
			data : {
				user_id : '${user_id }'
			},
			async : false,
			success : function(d) {
				console.log("dsasdasa");
				map.setCenter(new kakao.maps.LatLng(d.latitude, d.longitude));
				marker.setPosition(new kakao.maps.LatLng(d.latitude, d.longitude));
			}
			,error : function(request, status, error){
				alert(request.status);
				alert(request.responseText);
				alert(error);
			}
			
			});
	}, 1000);
});
</script>

</body>
</html>
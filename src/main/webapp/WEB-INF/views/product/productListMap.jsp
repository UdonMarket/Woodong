<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
  <style>
    .wrap {position: absolute;left: -11px;bottom: 75px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 7px 0 0 100px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 9px;left: 15px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
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
		<span id="result" style="display: none;"></span>
		</div>
		
		
	</div>
	
	</div>
	</div>
	</section>
	<script>
	
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
			<c:forEach items="${searchLists}" var="row">
				['${row.title }', ${row.latitude}, ${row.longitude}, '${row.bname}', '${row.product_tag}',
					'${row.id}', 
					'<fmt:formatNumber type="number" maxFractionDigits="3" value="${row.price}"/>'
					, '${row.imagefile}','${row.boardidx}'], 
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
	    	var content = '<div class="wrap">' + 
            '    <div class="info">' + 
            '	 	<a href="./productView.woo?boardidx='+location[8]+'" target="_blank" class="link">'+
            '       	 <div class="title">'+location[0]+'</div>' + 
            '        		<div class="body">' + 
            '            		<div class="img">' +
            '                		<img src="../resources/Upload/'+location[7]+'" width="73" height="70">' +
            '         			</div>' + 
            '            		<div class="desc">' + 
            '                		<div class="ellipsis">카테고리 | '+location[3]+'</br>'+' 태그 | '+location[4]+'</div>' + 
            '                		<div class="ellipsis">판매자 | '+location[5]+'</div>' + 
            '                		<div>가격 | '+location[6]+' 원</div>' + 
   	    	'    				</div>' + 
		    '	        	</div>' + 
	        '	    	</div>' + 
	        '		</a>'+
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
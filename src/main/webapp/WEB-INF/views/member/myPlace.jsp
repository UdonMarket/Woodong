<%@ page language="java" contentType="text/html; charset=UTF-8" 
		pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
	<!doctype html>
	<html lang="zxx">
	
	<!-- head.jsp -->
	<jsp:include page="../include/head.jsp"/>
	
	<script>
		function distance(lat, lng, clat, clng) {
			$.ajax({
				url : "../member/myPlaceDistance.woo",
				dataType : "json",
				type : "get",
				async : false,
				contentType : "text/html;charset:utf-8",
				data : {
					lat : lat,
					lng : lng,
					clat : clat,
					clng : clng
				},
				success : function(d){
					$('#dis').val(d.distance);
				},
				error : function(e){
					alert("실패:"+e.status+":"+e.statusText);
				}
			});
		}
	</script>
	<body>
		<!--::header part start::-->
		<!-- header.jsp --> 
	    <jsp:include page="../include/hearder.jsp"/>
		<!-- Header part end-->
	
		<jsp:include page="../include/mypageLeft.jsp"/>
							<section class="left_main" style="padding-top: 100px;padding-left: 70px;">
							<div class="container1">
							      <div class="row"style="padding-bottom: 50px;">
							        <div class="col-12" style="text-align: center;">
							          <img src="../resources/img/myPage/동네인증1.png" alt="" width="280px;"/>
							        </div>
							        </div>
									<div id="map" style="width:100%;height:400px;"></div>
									<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4416f1cdac23198286eb3f5394e6240d&libraries=services"></script>
									<script>
									
									var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
									    mapOption = { 
									        center: new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
									        level: 6 // 지도의 확대 레벨
									    };
									
									var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
									var marker;
									var infowindow;
									var lat, lon;
									// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
									if (navigator.geolocation) {
									    
									    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
									    navigator.geolocation.getCurrentPosition(function(position) {
									        
									        lat = position.coords.latitude // 위도
								            lon = position.coords.longitude; // 경도
									        
									            var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
							                // 인포윈도우에 표시될 내용입니다
							             	searchDetailAddrFromCoords(locPosition, function(result, status) {
									        if (status === kakao.maps.services.Status.OK) {
									            var detailAddr = !!result[0].road_address ? 
									            		'<div class="juso" style="top:77px;">도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
									            detailAddr += '<div class="juso">지번 주소 : ' + result[0].address.address_name + '</div>';
									            
									            var message = '<div class="bAddr">' +
									                            '<span class="title">위치</span>' + 
									                             detailAddr + 
									                           '</div>';
									            document.getElementById('juso').value = result[0].address.address_name;
									            var circle = new kakao.maps.Circle({
									                center : locPosition,  // 원의 중심좌표 입니다 
									                radius: 1000, // 미터 단위의 원의 반지름입니다 
									                strokeWeight: 5, // 선의 두께입니다 
									                strokeColor: '#75B8FA', // 선의 색깔입니다
									                strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
									                strokeStyle: 'solid', // 선의 스타일 입니다
									                fillColor: '#CFE7FF', // 채우기 색깔입니다
									                fillOpacity: 0.5  // 채우기 불투명도 입니다   
									            }); 

									            // 지도에 원을 표시합니다 
									            circle.setMap(map); 
									            // 마커를 클릭한 위치에 표시합니다 
									            marker.setPosition(locPosition);
									            marker.setMap(map);

									            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
									            //infowindow.setContent(message);
									            //infowindow.open(map, marker);
									        }   
									    });
									        
									        // 마커와 인포윈도우를 표시합니다
									        displayMarker(locPosition, message);
									            
									      });
									    
									} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
									    
										var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
									        message = 'geolocation을 사용할수 없어요..'
									        
									    displayMarker(locPosition, message);
									}
									
									// 주소-좌표 변환 객체를 생성합니다
									var geocoder = new kakao.maps.services.Geocoder();

									// 지도에 마커와 인포윈도우를 표시하는 함수입니다
									function displayMarker(locPosition, message) {
										var imageSrc = '../resources/img/map/지도마커1-2.png', // 마커이미지의 주소입니다    
										    imageSize = new kakao.maps.Size(50), // 마커이미지의 크기입니다
										    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
										      
										// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
										var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
										    markerPosition = new kakao.maps.LatLng(37.54699, 127.09598) // 마커가 표시될 위치입니다
									    infowindow = new kakao.maps.InfoWindow({
									    	zindex:1,
									    	content : iwContent,
									        removable : iwRemoveable
									    	}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
										
										 // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
										    searchAddrFromCoords(map.getCenter(), displayCenterInfo);    
									    
									    // 마커를 생성합니다
										marker = new kakao.maps.Marker({
										    //position: markerPosition, 
										    map: map,
										    position:locPosition,
										    image: markerImage // 마커이미지 설정 
										});
										 var iwContent = message, // 인포윈도우에 표시할 내용
									        iwRemoveable = true;

									    // 인포윈도우를 생성합니다
									   
									    
									    // 인포윈도우를 마커위에 표시합니다 
									    //infowindow.open(map, marker);
									    
									    // 지도 중심좌표를 접속위치로 변경합니다
									    map.setCenter(locPosition);      
										// 마커가 지도 위에 표시되도록 설정합니다
										marker.setMap(map);  
										
									}
									
									kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
									    
										searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
											var lat1 = mouseEvent.latLng.getLat(); // 현재 위도
		                                    var lng = mouseEvent.latLng.getLng(); // 현재 경도
		                                    var clat = lat; // 중심 위도
		                                    var clng = lon; // 중심 경도
		                                   
		                                    distance(lat1,lng,clat,clng);
		                                    var distance2 = document.getElementById("dis").value;
			                                 if(distance2>=1){
			                                    alert("원 안에서만 이동이 가능합니다.")
			                                    return;
			                                 }
			                                 
									        if (status === kakao.maps.services.Status.OK) {
									            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
									            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
									            
									            var content = '<div class="bAddr">' +
									                            '<span class="title">위치</span>' + 
									                            detailAddr + 
									                        '</div>';
									            document.getElementById('juso').value = result[0].address.address_name;
									            marker.setPosition(mouseEvent.latLng);
									            marker.setMap(map);

									        }   
									    });
									});
									// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
									kakao.maps.event.addListener(map, 'idle', function() {
									    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
									});

									function searchAddrFromCoords(coords, callback) {
									    // 좌표로 행정동 주소 정보를 요청합니다
									    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
									}

									function searchDetailAddrFromCoords(coords, callback) {
									    // 좌표로 법정동 상세 주소 정보를 요청합니다
									    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
									}
									function displayCenterInfo(result, status) {
										    
									    
									}
									
									
									//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
									function circle(){
										centerPosition = mouseEvent.latLng;
										drawingLine = new kakao.maps.Polyline({
							                strokeWeight: 3, // 선의 두께입니다
							                strokeColor: '#00a0e9', // 선의 색깔입니다
							                strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
							                strokeStyle: 'solid' // 선의 스타일입니다
							            }); 
										 drawingCircle = new kakao.maps.Circle({ 
								                strokeWeight: 1, // 선의 두께입니다
								                strokeColor: '#00a0e9', // 선의 색깔입니다
								                strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
								                strokeStyle: 'solid', // 선의 스타일입니다
								                fillColor: '#00a0e9', // 채우기 색깔입니다
								                fillOpacity: 0.2 // 채우기 불투명도입니다 
								            });    
										 drawingOverlay = new kakao.maps.CustomOverlay({
								                xAnchor: 0,
								                yAnchor: 0,
								                zIndex: 1
								            });              
									}
									
									</script>
									<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
									<script>
									    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
									    function sample4_execDaumPostcode() {
									        new daum.Postcode({
									            oncomplete: function(data) {
									                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
									
									                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
									                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
									                var roadAddr = data.roadAddress; // 도로명 주소 변수
									                var extraRoadAddr = ''; // 참고 항목 변수
									
									                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
									                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
									                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
									                    extraRoadAddr += data.bname;
									                }
									                // 건물명이 있고, 공동주택일 경우 추가한다.
									                if(data.buildingName !== '' && data.apartment === 'Y'){
									                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
									                }
									                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
									                if(extraRoadAddr !== ''){
									                    extraRoadAddr = ' (' + extraRoadAddr + ')';
									                }
									
									                // 우편번호와 주소 정보를 해당 필드에 넣는다.
									                document.getElementById('sample4_postcode').value = data.zonecode;
									                document.getElementById("sample4_roadAddress").value = roadAddr;
									                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
									                
									                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
									                if(roadAddr !== ''){
									                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
									                } else {
									                    document.getElementById("sample4_extraAddress").value = '';
									                }
									
									                var guideTextBox = document.getElementById("guide");
									                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
									                if(data.autoRoadAddress) {
									                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
									                    document.getElementById("sample4_jibunAddress").value = expJibunAddr;
									                    guideTextBox.style.display = 'block';
									
									                } else if(data.autoJibunAddress) {
									                    var expJibunAddr = data.autoJibunAddress;
									                    document.getElementById("sample4_jibunAddress").value = expJibunAddr;
									                    guideTextBox.style.display = 'block';
									                } else {
									                    guideTextBox.innerHTML = '';
									                    guideTextBox.style.display = 'none';
									                }
									            }
									        }).open();
									    }
									</script>
							      <div class="">
							        <div class=""style="padding-left: 5px; padding-top: 50px;">
							          <form:form class="form-contact contact_form" action="../member/myPlaceAction.woo" method="post"
							            novalidate="novalidate" onsubmit="return jusoCheck(this);">
							            <div class="row">
							            
							              <div class="col-6" style="text-align: center;padding-bottom: 10px;">
							                <span style="font-size: 15px;font-weight: bold;">지금 내 위치</span>
							              </div>
							              <div class="col-6"  style="text-align: center;padding-bottom: 10px;">
							                <span style="font-size: 15px;font-weight: bold;">인증한 우리 동네</span>
							              </div>
							              <div class="col-6">
							                <div class="form-group">
							                  <input class="form-control" name="juso" id="juso" type="text" placeholder='내 위치를 확인해주세요'>
							                </div>
							              </div>
							              <div class="col-6">
							                <div class="form-group">
							                  <input class="form-control" name="" id="" type="text" placeholder='동네인증을 해주세요' readonly="readonly"  value="${memberVO.addr}">
							                </div>
							              </div>
							             
							              <input type="hidden" id="sample4_postcode" placeholder="우편번호">
										  <input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
										  <span id="guide" style="color:#999;visibility: hidden;"></span>
										  <input type="hidden" id="sample4_detailAddress" placeholder="상세주소">
										  <input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
										  <input type="hidden" id="dis">
							              <div class="col-8">
							                <div class="form-group">
							                  <input type="text" id="sample4_jibunAddress" name="selectJuso" class="form-control" readonly="readonly">
							                </div>
							              </div>
							              <div class="col-4">
							                <div class="form-group" style="text-align: center;">
							                  <input type="button" onclick="sample4_execDaumPostcode()" class="btn_3 button-contactForm" value="우리동네 인증하기"><br>
							                </div>
							              </div>
							            </div>
							            <div class="form-group mt-3" style="text-align: right;margin-right: 15px;">
							              <button type="submit" class="btn_3 button-contactForm">인증완료</button>
							            </div>
							          </form:form>
							        </div>
							        
							      </div>
							    </div>
							</section>
							<script>
								function jusoCheck(frm) {
									var select = frm.selectJuso.value;
									var clientJuso = select.substring(0, select.lastIndexOf(" "));
									var server = frm.juso.value;
									var serverJuso = server.substring(0, server.lastIndexOf(" "));
									if(clientJuso==serverJuso){
										alert("동네인증이 완료되었습니다.");
										return true;
									}
									else{
										alert("동네인증에 실패했습니다.");
										return false;
									}
									
								}
							</script>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		<!--================Blog Area =================-->
	<!-- bottom.jsp -->
	    <jsp:include page="../include/bottom.jsp"/>
	    <jsp:include page="../include/sidebar.jsp"/>
	</body>
	
	</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../include/head.jsp" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4416f1cdac23198286eb3f5394e6240d&libraries=services"></script>
<script>
$(window).ready(function() {
	setTimeout(function() {
		document.getElementById("aa").submit()
	}, 1000);
});
//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${place}', function(result, status) {
    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
       
    		////////////////////////////////////////////////////////////////////////
    		//위경도를 text input에 입력
    		document.getElementById("latitude").value = result[0].y;
    		document.getElementById("longitude").value = result[0].x;
    		document.getElementById("place").value = '${place}';
    		////////////////////////////////////////////////////////////////////////
    }
}); 
</script>

<body>
<jsp:include page="../include/hearder.jsp" />

<form:form id="aa" action="../chatting/topPlace.woo">
	<input type="hidden" id="latitude" name="latitude" />
	<input type="hidden" id="longitude" name="longitude" />
	<input type="hidden" id="place" name="place" value="${place}" />
</form:form>	
</body>

</html>
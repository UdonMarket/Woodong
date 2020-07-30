<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script>
$(function() {
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  $('#cal_reviewPoint').val(this.id);
		  $('#aa').text(this.id);
		  return false;
		});
})
	
</script>

<style>
   .starR1{
	background:url("../resources/img/우동수정1.png");/* 왼쪽 빨강 */
	background-repeat: no-repeat;
   
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
    background:url("../resources/img/우동수정2.png");
	background-repeat: no-repeat; 
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:-21px 0;}
.starR2.on{background-position:-20px 0;}

</style>

<script type="text/javascript">
function writeValidate(f)
{
	if(f.contents.value==""){
		alert("내용을 입력하세요");
		f.contents.focus(); 
		return false;
	} 
}

</script>


<body>
   <div class="oViOeBoH3d container" style="padding-top: 10px;">
         <h4>상대방의 거래에 만족하셨나요?</h4>
      <div class="row" style=" padding-bottom: 20px; ">
         <div class="col-1"></div>
        	 <div class="col-3" id="aa" style="font-size: 40px; font-weight: bold;">
				1
         	</div>
            <div class="profile_review_image col-7">
               <div class="profile_review_image_box">
					<div class="starRev" style="margin-top: 18px; ">
						<span class="starR1 on" id="0.5">별1_왼쪽</span> <span class="starR2 on" id="1">별1_오른쪽</span>
						<span class="starR1" id="1.5">별2_왼쪽</span> <span class="starR2" id="2">별2_오른쪽</span>
						<span class="starR1" id="2.5">별3_왼쪽</span> <span class="starR2" id="3">별3_오른쪽</span>
						<span class="starR1" id="3.5">별4_왼쪽</span> <span class="starR2" id="4">별4_오른쪽</span>
						<span class="starR1" id="4.5">별5_왼쪽</span> <span class="starR2" id="5">별5_오른쪽</span>
					</div>
				</div>
            </div>
         </div>
      </div>
   <div class="oViOeBoH3d container" style="padding-top: 20px;">
      <h4>어떤 점이 좋았나요?</h4>
      <form:form  name="writeFrm" method="post" onsubmit="return writeValidate(this);" action="writeReviewContents.woo">
         	<input type ="hidden" value="" id="cal_reviewPoint" name="cal_reviewPoint"/>
      <input type="hidden" name ="write_idx" value="${boardidx}"/>
      <input type="hidden" name ="id" value="${id}"/>
      <input type="hidden" name ="title" value="${title}"/>
      <div class="ystMZ36gvH row" style="padding-top: 10px;">
         <div class="_30-j0z23yB col-12">
            <textarea class="_2mqbEheJIc" id="reviewInput"  name ="contents" cols="30"
               style="width: 100%; height: 100px;" placeholder="최소 10글자이상 입력해 주세요."></textarea>
            <div class="_2WdOh6YXC8" style="text-align: right;">
               <em class="_3LoikG0PPT"><span class="blind">입력글자수</span>0</em><span
                  class="_2dV9e5HlSd"></span><span class="blind">최대글자수</span>5,000
            </div>
         </div>
      </div>
      <div style="padding-top: 10px;">
      	<dl>
           <dt>
              <label>거래추천 장소</label>
           </dt>
           <dd class="map_box">
           <div class="row">
	           <div class="col-9" style="display:inline-block;">
	           	  <input type="text" id="sample4_jibunAddress" name="juso" class="form-control" readonly="readonly">
	              <input type="hid den" id="latitude" name="latitude">
	              <input type="hid den" id="longitude" name="longitude">
	           </div>
              <div class="col-3" style="display:inline-block;"> 
                 <input class="btn_my" type="button" onclick="sample4_execDaumPostcode()" value="검색" style=""><br>
              </div> 
           </div>
           </dd>
        </dl>
      </div>
      <div class="_3DpEZeFAIG">
         <div class="j7JepWm_pE">
            <button type="submit" class="btn_my" style="margin-top: 20px;">
               <span class="" >작성완료</span>
            </button>
         </div>
      </div>
      </form:form>
      <input type="hidden" id="sample4_postcode" placeholder="우편번호">
      <input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
      <span id="guide" style="color:#999;display:none"></span>
      <input type="hidden" id="sample4_detailAddress" placeholder="상세주소">
      <input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
   </div>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4416f1cdac23198286eb3f5394e6240d&libraries=services"></script>
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
                document.getElementById("latitude").value = code(data.jibunAddress);
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
    function code(juso) {
       var geocoder = new kakao.maps.services.Geocoder();
       geocoder.addressSearch(juso, function(result, status) {
          
           // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {
              var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
           } 
           document.getElementById("latitude").value = result[0].y;
           document.getElementById("longitude").value = result[0].x;
       }); 
   }
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!doctype html>
<html lang="zxx">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<body>
<!--우동 파일명 : productWrite.jsp  -->

	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<!-- breadcrumb part start-->
	<section class="breadcrumb_part" >
	      <div class="container-fluid">
	         <div class="row top_image"></div>
	         <img src="../resources/img/board/판매하기.png" alt="" id="main" style="height: 100%; width: 100%">
	      </div>
	   </section>
	<!-- breadcrumb part end-->

	<!-- ================ contact section start ================= -->
	<section class="contact-section section_padding" style="padding-top: 50px">
	<form:form name="writeFrm" action="./writeAction.woo" method="post" enctype="multipart/form-data">
		<div class="container">
			<div class="regist_box">
				<div class="description">
					<dl id="mainDiv">
						<dt>
							<label style="color: rgb(51, 51, 51);">우동페이  <span>(선택 사항)</span></label>
						</dt>
						<dd>
							<div class="hellopay_box_area">
								<ul>
									<li>
										<label>
											<input type="checkbox" name="woopay_check" value="" /> 우동페이 (이용)
											<input type="hidden" name="woopay" value="N" /> 
										</label>
									</li>
								</ul>
							</div>
							<div class="hellopay_direct_notice">
								<span class="normal_notice">우동페이 이용시 카드결제 , 모바일결제가 가능합니다.</span>
							</div>
						</dd>
					</dl>
					<dl class="regist_image_dl" id="registImage">
						<dt>
							<label style="color: rgb(51, 51, 51);">상품사진</label><span class="photo_max">* 최대 8장</span>
						</dt>
						<dd>
					<!-- 상품 사진 등록 (최대 8개) -->
					 <ul class="image_list">
                        <li id="image1">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file1" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="1" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        <li id="image2">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file2" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="2" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        <li id="image3">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file3" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="3" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        <li id="image4">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file4" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="4" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        <li id="image5">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file5" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="5" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        <li id="image6">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file6" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="6" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        <li id="image7">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file7" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="7" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        <li id="image8">
                           <div style="width: 146px;height: 146px">
                              <input type="file" name="file" id="file8" style="display: none;" accept="image/*"/>
                              <img name="fileimage" id="8" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0'>
                           </div>
                        </li>
                        
                     </ul>
							<div class="up_img_label">대표이미지</div>
							<div class="up_img_description">
								<span class="up_img_description_title">* 첫번째 사진은 직접 촬영한
									상품 사진을 등록해주세요.</span><img
									src="https://ccimage.hellomarket.com/web/2019/ad/ico_question_gr_60x60.png"
									alt="물음표이미지">
								<div class="up_img_hover">
									<span>판매자의 상품 보유 유무와 실물 상태 확인을 위해 직접 촬영한 실제 상품 사진을 첫번째
										이미지로 첨부해주시기 바랍니다.</span><span class="img_hover_margin">상품 첫번째
										이미지에 실제 사진이 첨부되지 않은 경우, 사전안내 없이 수정 또는 삭제될 수 있습니다.</span><span
										class="img_hover_margin">*삽니다. 무형의 상품 제외</span>
								</div>
							</div>

						</dd>
					</dl>
					
					<dl id="mainDiv">
					<dt>
						<label style="color: rgb(51, 51, 51);">3D 이미지 <span>(선택 사항)</span></label>
					</dt>
					<dd>
						<div class="hellopay_box_area">
							<ul>
								<li>
									<label>
										<input type="checkbox" name="three_check" value=""/> 3D 이미지 (이용)
										<input type="hidden" name="three_dimens" value="N"/> 
									</label>
								</li>
							</ul>
						</div>
						<div class="hellopay_direct_notice">
							<span class="normal_notice">3D 이미지 선택시 8장의 이미지를 모두 첨부해주세요.</span>
						</div>
					</dd>
				</dl>
					
					<dl id="title">
						<dt>
							<label style="color: rgb(51, 51, 51);">제목</label>
						</dt>
						<dd>
							<input type="text" class="title_input" placeholder="상품 제목을 입력하세요" name="title">
						</dd>
					</dl>
					<dl id="category">
						<dt>
							<label style="color: rgb(51, 51, 51);">카테고리</label>
						</dt>
						<dd>
							<div>
								<select name="bname">
									<option value="" hidden="">카테고리</option>
									<c:forEach items="${selectlist}" var="row">
									<option value="${row.bname}">${row.bname}</option>
									</c:forEach>
								</select>
							</div>
							<!-- <div class="item_select_box item_select_margin">
								<select><option value="" hidden="">하위 카테고리</option></select>
							</div> -->
						</dd>
					</dl>
					<dl id="content">
						<dt>
							<label style="color: rgb(51, 51, 51);">상품설명</label>
						</dt>
						<dd>
							<textarea rows="5" class="introduce" name="contents"
								placeholder="상품 정보를 상세하게 적어주세요.
설명되지 않은 하자나 문제 발생시 책임은 판매자에게 있습니다.
- 구매정보(구매일시, 구매시 가격)
- 상품 정보(사이즈, 색상, 브랜드 등)
- 상품 사용감(스크래치, 고장, 수리 여부 등)"></textarea>
						</dd>
					</dl>
					<!-- 상품 태그 :) 
						 1.태그 입력후   태그 저장 클릭시 span 태그와 hidden input에 값  입력됨 
						 2.태그를 입력하지 않을시 div 박스는 display none 상태 유지
					 -->
					<dl id="mainDiv">
						<dt>
							<label>태그</label>
						</dt>
						
						<dd class="map_box">
						
							<div class="hellopay_box_area">
								<ul>
									<li>
										<input type="hidden" name="product_tag"/>
										<input type="text" class="my_location_input item_location_input" placeholder="최소 1개의 태그를 입력해주세요." name="input_tag" >
										<div class="my_location_map" >
											<span id="tagsave">태그 저장</span>
										</div>
										
									</li>
								</ul>
							</div>
							
							<div class="hellopay_direct_notice" >
								<span class="normal_notice">태그는 최대 3개까지 입력가능합니다.
								&nbsp;&nbsp;각 태그는 최대 10자까지 입력할 수 있습니다.</span>
							</div>
							<div class="hellopay_direct_notice" id="div_tag" style="display: none;">
								<span class="normal_notice" id="sapn_tag"></span>
							</div>
						</dd>
					</dl>
					<dl>
						<dt>
							<label>상품상태</label>
						</dt>
						<dd>
							<ul class="item_status_list">
								<li class="item_status">
									<label>
										<input type="radio" name="product_state" value="새상품" checked="checked"/>새상품
									</label>
								</li>
								<li class="item_status">
									<label>
										<input type="radio" name="product_state" value="거의새것"/>거의새것
									</label>
								</li><li class="item_status">
									<label>
										<input type="radio" name="product_state" value="중고"/>중고
									</label>
								</li><li class="item_status">
									<label>
										<input type="radio" name="product_state" value="하자있음"/>하자있음
									</label>
								</li>
							</ul>
						</dd>
					</dl>
					
					<dl class="sell_method_box">
						<dt>
							<label id="price" style="color: rgb(51, 51, 51);">거래종류</label>
						</dt>
						<dd>
							<div class="box_sell_method box_area">
								<ul class="item_status_list">
									<li class="item_status">
										<label>
											<input type="radio" name="deal_type" value="판매" checked="checked"/>판매
										</label>
									</li>
									<li class="item_status">
										<label>
											<input type="radio" name="deal_type"  value="무료나눔"/>무료나눔
										</label>
									</li>
									<li class="item_status">
										<label>
											<input type="radio" name="deal_type"  value="삽니다"/>삽니다
										</label>
									</li>
								</ul>
							</div>
						</dd>
					</dl>
					<dl class="hellopay_options_box direct_options_box" id="price">
						<dt style="color: rgb(51, 51, 51);">판매가격</dt>
						<dd>
							<div class="box_price box_area">
								<input type="text" placeholder="판매희망 가격을 입력하세요"class="sell_type_input" name="price">
									<span class="box_prive_text">원</span>
							</div>
						</dd>
					</dl>
					<dl>
						<dt>
							<label>거래희망 위치 </label>
						</dt>
						<dd class="map_box">
						<span class="juso" id="sample4_jibunAddress">
						</span>
						<!-- <input type="text" class="my_location_input item_location_input" id="sample4_jibunAddress" name="deal_location" placeholder="선택한 위치" readonly="readonly"> -->
							<input type="hid den" id="latitude" name="latitude">
							<input type="hid den" id="longitude" name="longitude">
							<div class="" style="display:inline-block;"> 
								<input class="my_location_map" type="button" onclick="sample4_execDaumPostcode()" value="검색" style="background-color: #fff;margin-top: -23.5px;margin-left: 5px;"><br>
							</div> 
						</dd>
					</dl>
				</div>
				<button type="submit" class="btn_my" id="subtn" style="margin-bottom: 10px;margin-left: 500px;">글쓰기</button>
			</div>
		</div>
				
		
		</form:form>
		
		<input type="hidden" id="sample4_postcode" placeholder="우편번호">
		<input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
		<span id="guide" style="color:#999;display:none"></span>
		<input type="hidden" id="sample4_detailAddress" placeholder="상세주소">
		<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
	</section>
	<!-- ================ contact section end ================= -->
<script>
var fileCount = 1;
var maxfile = 9;
var count = 1;	
var msg="";
	
//사진 미리보기	  
function readFile(f) {
   if(f.files && f.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
             $('img[name=fileimage]:eq(' + (fileCount-2) + ')').prop("src", e.target.result);
      }
      reader.readAsDataURL(f.files[0]);
   }
}
$(function() {
	//input 파일이 바꼈을때 실행되는 함수 (이벤트 / target / 실행될 부분)
   $('input:file').on("change", function() {
      readFile(this);
      fileCount++;
   });
	
	//이미지 클릭했을때 
   $('img[name=fileimage]').on('click',function() {
	   
      var id = this.id;
      
     // 클릭한 이미지가 기본이미지라면 파일 선택 이벤트 실행
     if(this.src=="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png"){
    	 	//빈 이미지가 아니라면 
           if(!$('input:file[name]:eq('+ (fileCount-1) +')').val()){
        	   //파일갯수 8개로 제한
              if(fileCount>8){
                 return;
              }
        	   //파일첨부 창 로드
              $('input:file[name]:eq(' + (fileCount-1) + ')').click();
           }
     }
	else{
		 //클릭한 이미지가 기본이미지가 아니라면 파일 삭제 이벤트 실행
	   if(confirm("삭제하시겠습니까?")){
		   //li 태그 삭제
	      $('#image' + id).remove();
	      
		   //ul 태그 안에 append
	      $('.image_list').append(
	         '<li id="image'+maxfile+'">'
	         +   '<div style="width: 146px;height: 146px">'
	         +      '<input type="file" name="file" id="file'
	         +maxfile+'" style="display: none;" accept="image/*"/>'
	         +      '<img name="fileimage" id="'+maxfile
	         +'" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border="0">'
	         +   '</div>'
	         +'</li>'      
	      );
	      maxfile++;
	      fileCount--;
	   }
	}
   });
});
	
//라디오 토글
$(function() {
	$("input:radio[name=product_state]").checkboxradio({
		icon: false
	});
	$("input:radio[name=deal_type]").checkboxradio({
		icon: false
	});
	$('input[type=checkbox]').click(function(){
		
		if($(this).is(':checked')){
	        $(this).val('Y');
	    }else{
	    	 $(this).val('N');
	    }
	});
	
	$('#subtn').click(function(){
		
		if($('input:checkbox[name=woopay_check]').is(':checked')==true){
			$('[name=woopay]').val('Y');
	    }else{
	    	$('[name=woopay]').val('N');
	    }
		
		if($('input:checkbox[name=three_check]').is(':checked')==true){
			$('[name=three_dimens]').val('Y');
	    }else{
	    	$('[name=three_dimens]').val('N');
	    }
	});
	
	//태그 추가 함수
	$('#tagsave').click(function() {
		var msg = $("[name=product_tag]").val();
		if(count<4 && $("input[name=input_tag]").val()!=""){
			$("input[name=product_tag]").val(msg+'#'+$("input[name=input_tag]").val());
			console.log($("[name=product_tag]").val());
			$("#div_tag").removeAttr('style');
			$("#sapn_tag").append('#'+$("input[name=input_tag]").val()+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
			count++;
		}
		$("[name=input_tag]").val('');
	});
	
});

</script>
  <script>
  </script>
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
                document.getElementById("sample4_jibunAddress").innerHTML = data.jibunAddress;
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
	<!--::footer_part start::-->
	<jsp:include page="../include/bottom.jsp" />
	<jsp:include page="../include/sidebar.jsp" />
	
</body>

</html>
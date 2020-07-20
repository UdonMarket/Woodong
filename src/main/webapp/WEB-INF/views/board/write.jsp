<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="zxx">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<body>
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
		<div class="container">
			<div class="regist_box">
				<div class="description">
					<dl id="mainDiv">
						<dt>
							<label style="color: rgb(51, 51, 51);">거래방법</label>
						</dt>
						<dd>
							<div class="hellopay_box_area">
								<ul>
									<li>
										<label>
											<input type="checkbox" /> 우동페이
										</label>
									</li>
									<li style="margin-left: 10px;">
										<label>
											<input type="checkbox" /> 직거래
										</label>
									</li>
								</ul>
							</div>
							<div class="hellopay_direct_notice">
								<span class="normal_notice">우동페이만 선택 후 등록시 노출, 할인 혜택 지원으로 빠른 판매를 도와드립니다.</span>
							</div>
						</dd>
					</dl>
					<dl class="regist_image_dl" id="registImage">
						<dt>
							<label style="color: rgb(51, 51, 51);">상품사진</label><span
								class="photo_max">* 최대 12장</span>
						</dt>
						<dd>
							<ul class="image_list">
								<li>
									<div style="width: 146px;height: 146px">
										<input type="file" name="file1" id="file1" style="display: none;" accept="image/*"/>
										<img id="fileimage1" src="https://ccimage.hellomarket.com/web/2018/auto/img_car_pic_basic.png" style="width: 100%; height: 100%" border='0' onclick='fileClick(this);'> 
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
					<dl id="title">
						<dt>
							<label style="color: rgb(51, 51, 51);">제목</label>
						</dt>
						<dd>
							<input type="text" class="title_input" placeholder="상품 제목을 입력하세요"
								value="">
							<ul class="item_recommend_box"></ul>
						</dd>
					</dl>
					<dl id="category">
						<dt>
							<label style="color: rgb(51, 51, 51);">카테고리</label>
						</dt>
						<dd>
							<div>
								<select>
									<option value="" hidden="">카테고리</option>
									<option value="HAR0000">남성의류</option>
									<option value="HFB0000">여성의류</option>
									<option value="HFC0000">아동의류</option>
									<option value="HAO0000">가전/디지털</option>
									<option value="HAN0000">가구</option>
									<option value="HBA0000">유아용품</option>
									<option value="HAE0000">뷰티/여성잡화</option>
									<option value="HAD0000">게임/도서</option>
									<option value="HAA0000">반려동물</option>
									<option value="HZZ0000">기타</option>
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
							<textarea rows="5" class="introduce"
								placeholder="상품 정보를 상세하게 적어보세요.
설명되지 않은 하자나 문제 발생시 책임은 판매자에게 있습니다.
- 구매정보(구매일시, 구매시 가격)
- 상품 정보(사이즈, 색상, 브랜드 등)
- 상품 사용감(스크래치, 고장, 수리 여부 등)"></textarea>
						</dd>
					</dl>
					<dl>
						<dt>
							<label>태그</label>
						</dt>
						<dd>
							<span class="tag_open_btn">태그입력</span>
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
										<input type="radio" name="chek" id="" />새상품
									</label>
								</li>
								<li class="item_status">
									<label>
										<input type="radio" name="chek" id="" />거의새것
									</label>
								</li><li class="item_status">
									<label>
										<input type="radio" name="chek" id="" />중고
									</label>
								</li><li class="item_status">
									<label>
										<input type="radio" name="chek" id="" />하자있음
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
											<input type="radio" name="chek1" id="" />판매
										</label>
									</li>
									<li class="item_status">
										<label>
											<input type="radio" name="chek1" id="" />무료나눔
										</label>
									</li>
									<li class="item_status">
										<label>
											<input type="radio" name="chek1" id="" />삽니다
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
								<input type="text" placeholder="판매희망 가격을 입력하세요"
									class="sell_type_input" value=""><span
									class="box_prive_text">원</span>
							</div>
						</dd>
					</dl>
					<dl>
						<dt>
							<label>거래희망 위치 <span>(선택)</span></label>
						</dt>
						<dd class="map_box">
							<input type="text" class="my_location_input item_location_input"
								placeholder="위치 선택" readonly="" value="">
							<div class="close_button item_close_button"></div>
							<div class="my_location_map">
								<span>검색</span>
							</div>
							<div class="my_location_map">
								<span>현재위치</span>
							</div>
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ contact section end ================= -->
<script>
	$(function() {
		$("input:radio[name=chek]").checkboxradio({
			icon: false
		});
		$("input:radio[name=chek1]").checkboxradio({
			icon: false
		});
	});

	function fileClick(f) {
		switch (f.id) {
		case "fileimage1":
			document.all.file1.click();
			break;
		case "fileimage2":
			document.all.file2.click();
			break;
		case "fileimage3":
			document.all.file3.click();
			break;
		case "fileimage4":
			document.all.file4.click();
			break;
		case "fileimage5":
			document.all.file5.click();
			break;
		case "fileimage6":
			document.all.file6.click();
			break;
		case "fileimage7":
			document.all.file7.click();
			break;
		case "fileimage8":
			document.all.file8.click();
			break;
		default:
			break;
		}
	}
	function readFile(f) {
		if(f.files && f.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
				switch (f.id) {
				case "file1":
	            	$('#fileimage1').attr("src", e.target.result);
					break;
				case "file2":
	            	$('#fileimage2').attr("src", e.target.result);
					break;
				case "file3":
	            	$('#fileimage3').attr("src", e.target.result);
					break;
				case "file4":
	            	$('#fileimage4').attr("src", e.target.result);
					break;
				case "file5":
	            	$('#fileimage5').attr("src", e.target.result);
					break;
				case "file6":
	            	$('#fileimage6').attr("src", e.target.result);
					break;
				case "file7":
	            	$('#fileimage7').attr("src", e.target.result);
					break;
				case "file8":
	            	$('#fileimage8').attr("src", e.target.result);
					break;
				}
	        }
	        reader.readAsDataURL(f.files[0]);
		}
	}
	
	$(function() {
		$('input:file').change(function() {
			readFile(this);
		})
	});
</script>
  <script>
  </script>
	<!--::footer_part start::-->
	<jsp:include page="../include/bottom.jsp" />
	<jsp:include page="../include/sidebar.jsp" />
	
</body>

</html>
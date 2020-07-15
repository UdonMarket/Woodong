<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>
<body>
	<!--::header part start::-->
	<!-- header.jsp --> 
    <jsp:include page="../include/hearder.jsp"/>
	<!-- Header part end-->

	<!-- breadcrumb part start-->
		<section class="breadcrumb_part" >
	      <div class="container-fluid">
	         <div class="row top_image"></div>
	         <img src="../resources/img/공지사항.png" alt="" id="main" style="height: 100%; width: 100%">
	      </div>
	   </section>
	<!-- breadcrumb part end-->

	<!--================login_part Area =================-->
	<section class="login_part section_padding" style="padding-top: 30px">
		<!-- 상단과 내용 띄우기 -->
		<div class="container">
		<div class="row">
			<jsp:include page="../include/communityLeft.jsp"/>
			<div class="col-lg-9" style=" margin-top: 50px;">
				<div id="accordion">
					<div class="card">
						<div class="card-header" style="background-color: #ffffff;">
							<a class="card-link" data-toggle="collapse" href="#collapseOne">
								[공지] 카카오톡 아이디 포함 시 상품 삭제 정책 안내 </a>
						</div>
						<div id="collapseOne" class="collapse" data-parent="#accordion">
							<div class="card-body">
								<pre>
안녕하세요. 번개장터입니다.

최근 카카오톡 아이디를 이용한 피싱 사기가 증가하고 있습니다.

사기의 대부분은 번개톡이 아닌 카카오톡으로 대화를 유도한 뒤에 번개페이와 유사한 피싱 사이트의 URL로 결제를 요청하여 사기를 발생시키고 있습니다.

 

따라서, 번개장터에서는 상품 등록 시 카카오톡 ID를 포함할 경우 해당 상품을 삭제하여 ‘카카오톡 피싱 사기’ 피해가 발생하지 않도록 상품등록 정책을 변경할 예정입니다.

해당 정책은 2020년 6월 23일 12:00부터 적용될 예정입니다.

 

번개장터 회원님들의 사기 피해를 방지하기 위한 조치이므로 불편한 점은 양해 부탁드리며, 정책 변경 후부터는 상품 상세에 카카오톡 아이디를 넣지 말아 주시기 바랍니다.

<정책 변경 사항>

 

- 적용 일시: 2020년 6월 23일 12:00

- 정책: 상품 상세에 카카오톡 ID 포함 시 상품 삭제

그밖에 아래와 같은 상황에서 사기가 많이 발생하고 있으니 거래 시 꼭 주의해주세요.

 

- 카카오톡 등 외부 채팅 서비스로 대화 유도

- 무리한 선입금 요구 및 입금후 잠적

- 번개페이 사용 거부 (정산이 느리다, 사용법을 모른다, 오류가 많다, 급전이 필요하다 등의 이유로 거부)

- 직거래 거부 및 택배거래 유도(코로나, 출장, 특정지역에서만 가능 등의 이유로 거부)
									
								</pre>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-header" style="background-color: #ffffff">
							<a class="collapsed card-link" data-toggle="collapse"
								href="#collapseTwo"> Collapsible Group Item #2 </a>
						</div>
						<div id="collapseTwo" class="collapse" data-parent="#accordion">
							<div class="card-body">Lorem ipsum..</div>
						</div>
					</div>

					<div class="card">
						<div class="card-header" style="background-color: #ffffff">
							<a class="collapsed card-link" data-toggle="collapse"
								href="#collapseThree"> Collapsible Group Item #3 </a>
						</div>
						<div id="collapseThree" class="collapse" data-parent="#accordion">
							<div class="card-body">Lorem ipsum..</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" style="background-color: #ffffff">
							<a class="collapsed card-link" data-toggle="collapse"
								href="#collapseThree"> Collapsible Group Item #3 </a>
						</div>
						<div id="collapseThree" class="collapse" data-parent="#accordion">
							<div class="card-body">Lorem ipsum..</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" style="background-color: #ffffff">
							<a class="collapsed card-link" data-toggle="collapse"
								href="#collapseThree"> Collapsible Group Item #3 </a>
						</div>
						<div id="collapseThree" class="collapse" data-parent="#accordion">
							<div class="card-body">Lorem ipsum..</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" style="background-color: #ffffff">
							<a class="collapsed card-link" data-toggle="collapse"
								href="#collapseThree"> Collapsible Group Item #3 </a>
						</div>
						<div id="collapseThree" class="collapse" data-parent="#accordion">
							<div class="card-body">Lorem ipsum..</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" style="background-color: #ffffff">
							<a class="collapsed card-link" data-toggle="collapse"
								href="#collapseThree"> Collapsible Group Item #3 </a>
						</div>
						<div id="collapseThree" class="collapse" data-parent="#accordion">
							<div class="card-body">Lorem ipsum..</div>
						</div>
					</div>
				</div>
			</div>
			
			</div>
			
		</div>
	</section>
	<!--================login_part end =================-->

	<!-- bottom.jsp -->
    <jsp:include page="../include/bottom.jsp"/>
    <jsp:include page="../include/sidebar.jsp"/>
</body>

</html>



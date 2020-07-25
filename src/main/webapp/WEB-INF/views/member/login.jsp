<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script>
// 공백 체크 정규식
var empJ = /\s/g;
// 아이디 정규식 - '_'특수문자가 가능하며 중앙에 @ 필수 그리고 뒤에 2~3글자가 필요하다.
var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 비밀번호 정규식 - A~Z, a~z, 0~9로 시작하는 4~12자리 비밀번호를 설정할 수 있다.
var pwJ = /^[A-Za-z0-9]{4,12}$/; 

$(function(){
	// 아이디
	$("#name").blur(function() {
		if (mailJ.test($(this).val())) {
				console.log(mailJ.test($(this).val()));
				$("#id_check").text('');
		} else {
			$('#id_check').text('이메일을 확인해주세요');
			$('#id_check').css('color', 'red');
		}
	});


	// 비밀번호
	$('#password').blur(function(){
		if(pwJ.test($(this).val())){
			console.log(pwJ.test($(this).val()));
			$("#pw_check").text('');
		} else {
			$('#pw_check').text('비밀번호를 확인해주세요 :)');
			$('#pw_check').css('color', 'red');
		}
	});
	
});
</script>
<body>
	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<!-- breadcrumb part start-->
	<!-- <section class="breadcrumb_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>login</h2>
                        
                    </div>
                </div>
            </div>
        </div>
    </section> -->
	<!-- breadcrumb part end-->

	<!--================login_part Area =================-->
	<!-- Cookie가 비어있지 않을 때 checked 속성을 줌 -->
	<c:if test="${not empty cookie.user_check}">
		<c:set value="checked" var="checked"/>
	</c:if>
	
	<section class="login_part section_padding"
		style="padding-bottom: 30px; padding-top: 210px;">
		<div class="container">
			<div class="row align-items-center">
				<!-- <div class="col-lg-6 col-md-6">
                    <div class="login_part_text text-center">
                        <div class="login_part_text_iner">
                            <h2 style="color:#783712;">우동마켓이 처음이신 분은</h2>
                            <p style="color:#783712;">회원가입을 먼저 해주세요.</p>
                            <a href="#" class="btn_3" style="color:#783712;">회원가입</a>
                        </div>
                    </div>
                </div> -->
				<div class="col-lg-9" style="padding-left: 300px;">
					<div class="login_part_form" style="border: 1px solid #d9d9d9;">
						<div class="login_part_form_iner">
							<div
								style="color: #ff4f4f; font-weight: bold; text-align: center; font-size: 3.0em; margin-bottom: 60px;">로그인</div>

							<div style="margin-bottom: 10px;">
								<c:url value="/loginAction" var="loginUrl" />
								<form:form name="loginFrm" class="row contact_form"
									action="${loginUrl }" method="post" novalidate="novalidate"
									id="loginFrm" onsubmit="return frmCheck(this);">
									<c:if test="${param.error != null} }">
										<p>아이디와 패스워드가 잘못되었습니다.</p>
									</c:if>
									<c:if test="${param.login != null} }">
										<p>로그아웃하였습니다.</p>
									</c:if>

									<div class="col-md-12 form-group p_star">
										<input type="text" class="single-input-primary" id="name"
											name="name" value="" placeholder="아이디" value="${cookie.user_check.value}"
											style="border-bottom: 1px solid gray;">
											
										<div id="id_check"></div>
									</div>
									<div class="col-md-12 form-group p_star">
										<input type="password" class="single-input-primary"
											id="password" name="password" value="" placeholder="비밀번호"
											style="border-bottom: 1px solid gray;">
											
										<div id="pw_check"></div>
									</div>
									<div class="col-md-12 form-group">
										<div style="text-align: right; margin-top: 10px;">
											<div>
												<input type="checkbox" id="remember_us" name="remember_userId" ${checked}>
												<label for="f-option1" >아이디저장</label>
											</div>
										</div>
										<div style="margin-bottom: 20px;">
											<button type="submit" value="submit" class="btn_3">
												로그인</button>
												
												
											<!-- 네이버 로그인 창으로 이동 -->
											<div id="naver_id_login" style="text-align: center; display:inline-block;">
												<a href="${url}"> <img width="223"
													src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
											</div>
											
											<div style="text-align: center; display:inline-block;">
											<a href = "https://kauth.kakao.com/oauth/authorize?client_id=20a7409ad58db84b8ebf9d84b113e0de&redirect_uri=	
														http://localhost:8282/woodong/oauth&response_type=code">
											       <img src="../resources/img/kakao_login_medium_narrow.png" alt="" />
											</a>
											</div>
											
											<a class="lost_pass" href="../member/pwFind.woo" style="color:#ff4f4f; font-size:1em;font-weight:bold;">비밀번호 찾기</a>
	                                    						<a class="lost_id" href="../member/idFind.woo" style="color:#ff4f4f; font-size:1em;font-weight:bold;margin-left: 60%">아이디 찾기</a>
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================login_part end =================-->

	<!--::footer_part start::-->

	<!--::footer_part end::-->

	<!-- bottom.jsp -->
	<jsp:include page="../include/bottom.jsp" />
</body>

</html>

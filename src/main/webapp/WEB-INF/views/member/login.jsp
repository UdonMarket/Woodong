<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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

	$(function() {
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
		$('#password').blur(function() {
			if (pwJ.test($(this).val())) {
				console.log(pwJ.test($(this).val()));
				$("#pw_check").text('');
			} else {
				$('#pw_check').text('비밀번호를 확인해주세요 :)');
				$('#pw_check').css('color', 'red');
			}
		});
		//최종확인버튼 클릭시 빈값체크
		$('#btn').click(function() {
			/* $(":input").attr("required", true); */

		});

		$('#remember_us').click(function() {
			$.ajax({
				url : "../member/idSave.woo",
				dataType : "json",
				type : "get",
				contentType : "text/html;charset:utf-8",
				data : {
					chk : $('#remember_us').val(),
					id : $('#name').val(),
					num : $('#num').val()
				},
				success : sucFunc, /* sucFunc(data)형태로 사용하지 않는다. */
				error : errFunc
			});
		});

		/*
		 콜백메소드를 외부함수로 정의함.
		 해당 함수 호출시에는 함수명 만으로 호출한다.
		 매개변수는 사용하지 않는다.
		 error : errFunc => 0
		 error : errFunc(data) => X
		 */
		
	});
	function errFunc() {
		alert("쿠키에러");
	}

	/*
	 요청 성공시 호출할 콜백메소드.
	 외부함수로 정의되어 있고 함수명만으로 호출하더라도 콜백데이터는 파라미터로 받을수 있다.
	 */
	function sucFunc(resData) {
		alert(resData)
		var num = resData.num;
		alert(num);
		num = num + 1;
		$('#num').html(num);
	}
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
									action="${loginUrl }" method="post" id="loginFrm">
									<c:if test="${param.error != null} }">
										<p>아이디와 패스워드가 잘못되었습니다.</p>
									</c:if>
									<c:if test="${param.login != null} }">
										<p>로그아웃하였습니다.</p>
									</c:if>

									<div class="col-md-12 form-group p_star">
									
										
										<input type="text" class="single-input-primary" id="name"
											name="name" placeholder="아이디"
											value="${user_id}"
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
												<!-- Cookie가 비어있지 않을 때 checked 속성을 줌 -->
										<input type="hidden" id="num" value=0 />
											
												<input type="checkbox"  id="remember_us" name="remember_userId"  value="y"
												<c:if test="${not empty user_id}"> 
												checked="chekced"
												</c:if>
												> 
												<label	for="remember_us">아이디저장</label>
										 
											</div>
										</div>
										<div style="margin-bottom: 20px;">
											<button type="submit" value="submit" class="btn_3" id="btn">
												로그인</button>

											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />


											<!-- 네이버 로그인 창으로 이동 -->
											<div id="naver_id_login"
												style="text-align: center; display: inline-block;">
												<a href="${url}"> <img width="223"
													src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
											</div>

											<div style="text-align: center; display: inline-block;">
												<a
													href="https://kauth.kakao.com/oauth/authorize?client_id=20a7409ad58db84b8ebf9d84b113e0de&redirect_uri=	
														http://localhost:8282/woodong/oauth&response_type=code">
													<img src="../resources/img/kakao_login_medium_narrow.png"
													alt="" />
												</a>
											</div>

											<a class="lost_pass" href="../member/pwFind.woo"
												style="color: #ff4f4f; font-size: 1em; font-weight: bold;">비밀번호
												찾기</a> <a class="lost_id" href="../member/idFind.woo"
												style="color: #ff4f4f; font-size: 1em; font-weight: bold; margin-left: 60%">아이디
												찾기</a>
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

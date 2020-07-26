<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>
<script>
// 공백 체크 정규식
var empJ = /\s/g;
// 아이디 정규식 - '_'특수문자가 가능하며 중앙에 @ 필수 그리고 뒤에 2~3글자가 필요하다.
var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 비밀번호 정규식 - A~Z, a~z, 0~9로 시작하는 4~12자리 비밀번호를 설정할 수 있다.
var pwJ = /^[A-Za-z0-9]{4,12}$/; 
//휴대폰 번호 정규식 - 01?(3글자)방식으로 나머지 적용해서 보면된다.
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

$(function(){
	// 아이디
	$("#email").blur(function() {
		if (mailJ.test($(this).val())) {
				console.log(mailJ.test($(this).val()));
				$("#id_check").text('');
		} else {
			$('#id_check').text('이메일을 확인해주세요');
			$('#id_check').css('color', 'red');
		}
	});


	// 비밀번호
	$('#pass').blur(function(){
		if(pwJ.test($(this).val())){
			console.log(pwJ.test($(this).val()));
			$("#pw_check").text('');
		} else {
			$('#pw_check').text('비밀번호를 확인해주세요 :)');
			$('#pw_check').css('color', 'red');
		}
	});
	
	// 휴대전화
	$('#mobile').blur(function(){
		if(phoneJ.test($(this).val())){
			console.log(nameJ.test($(this).val()));
			$("#phone_check").text('');
		} else {
			$('#phone_check').text('휴대폰번호를 확인해주세요 :)');
			$('#phone_check').css('color', 'red');
		}
	});
});
</script>
<body>
    <!--::header part start::-->
    <!-- header.jsp --> 
    <jsp:include page="../include/hearder.jsp"/>
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
    <section class="login_part section_padding"style="padding-bottom: 30px;padding-top: 210px;">
        <div class="container" >
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
                <div class="col-lg-9" style="padding-left:300px;">
                    <div class="login_part_form" style="border: 1px solid #d9d9d9;width: 562px; height: 500px;padding-top:50px; padding-bottom: 0px;">
                        <div class="login_part_form_iner">
                        <div style="color:#ff4f4f; font-weight:bold; text-align:center; font-size:2.5em;margin-bottom: 20px;">회원가입</div>
                        
                            <div style="margin-bottom:10px;">
                            <form:form class="row contact_form" action="../member/joinAction.woo" method="post"
									novalidate="novalidate" name="joinFrm" id="joinFrm" onsubmit="return frmCheck(this);">
                                <div class="col-md-12 form-group p_star">
                                    <div class="profile_edit_main">
										<ul>
											<li>
												<div>아이디</div>
												<div style="margin-top: 10px;">
													<input class="form-control" type="email" placeholder="이메일주소입력" name="email" id="email"/>
													
													<div id="id_check"></div>
												</div>
											</li>
											<br>
											<li class="profile_password_area profile_password_area_first">
												<div style="margin-top: 15px;">비밀번호</div>
												<div class="profile_userId_value" style="margin-top: 10px;">
												<input class="form-control" type="password" placeholder="영문, 숫자 4자리 이상" name="pass" id="pass"/>
												
												<div id="pw_check"></div>
												</div>
											</li>
											<br>
											<li>
												<div style="margin-top: 15px;">휴대폰</div>
												<div class="row">
													<div class="col-8" style="margin-top: 10px;margin-left: 16px;">
														<input class="form-control" type="tel" placeholder="숫자만 입력가능" name="mobile" id="mobile"/>
														
														<div id="phone_check"></div>
													</div>
													<div class="form-group mt-3 col-3" style="text-align: right; margin-left: 10px;">
														<button class="btn_my" type="button">인증</button>
													</div>
												</div>
											</li>
											<!-- <li>
												<div>수신설정</div>
												<div class="reception_area">
													<div class="profile_userId_value reception_checkbox">
														<label class="feature_option feature_option_checkbox ">email
															<div class="feature_option_checkbox_indicator checked"></div>
														</label>
													</div>
													<div class="profile_userId_value reception_checkbox">
														<label class="feature_option feature_option_checkbox ">SMS
															<div class="feature_option_checkbox_indicator checked"></div>
														</label>
													</div>
													<div class="profile_userId_value reception_value">회원정보,거래정보 및 서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다.</div>
												</div>
											</li> -->
											<li></li>
										</ul>
									</div>
									 <div style="margin-bottom:20px;">
	                                    <button type="submit" value="submit" class="btn_3">
	                                        가입하기
	                                    </button>
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
    <jsp:include page="../include/bottom.jsp"/>
</body>
    
</html>
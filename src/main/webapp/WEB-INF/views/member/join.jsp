<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>
<script>
//폼값체크
function frmCheck(frm) {
	
	if(!frm.email.value){
		alert("이메일을 입력하세요");
		frm.email.focus();
		return false;
	}
	if(!idAssemble(frm)){
		alert("아이디는 6자 이상 12자 이내의 영문/숫자(@포함)를 조합하여 기입해주세요");
		return false;
	}
	if(!frm.pass.value){
		alert("비밀번호를 입력하세요");
		frm.pass.focus();
		return false;
	}
	if(!passAssemble()){
		alert("비밀번호는 6자 이상 12자 이내의 영문/숫자를 조합하여 기입해주세요");
		return false;
	}
	if(!frm.mobile.value){
		alert("핸드폰번호를 입력하세요");
		frm.mobile.focus();
		return false;
	}
}	
	//아이디 6자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입 및 이메일 형식 체크
	function idAssemble(frm) {
		
		 var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+).{6,12}$/;

			
		var flag = true;
		if(!reg_email.test($('input[id=email]').val())){
			flag = false;
			return false;
		}
		 else{
			return true;
		}  
	}
	
	//비밀번호 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입
	function passAssemble() {
		var frm = document.joinFrm;
		var regex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,12}$/;
		/* var regex = /^[A-Za-z0-9]{4,12}$/; */
			
		var flag = true;
		if(!regex.test($('input[id=pass]').val())){
			flag = false;
			return false;
		}
		 else{
			return true;
		}  
	}

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
                            <form:form class="row contact_form" action="../member/addMember.woo" method="post"
									novalidate="novalidate" name="joinFrm" id="joinFrm" onsubmit="return frmCheck(this);">
                                <div class="col-md-12 form-group p_star">
                                    <div class="profile_edit_main">
										<ul>
											<li>
												<div>아이디</div>
												<div style="margin-top: 10px;">
													<input class="form-control" type="email" placeholder="이메일주소입력" name="email" id="email"/>
												</div>
											</li>
											<br>
											<li class="profile_password_area profile_password_area_first">
												<div style="margin-top: 15px;">비밀번호</div>
												<div class="profile_userId_value" style="margin-top: 10px;">
												<input class="form-control" type="password" placeholder="영문, 숫자 4자리 이상" name="pass" id="pass"/></div>
											</li>
											<br>
											<li>
												<div style="margin-top: 15px;">휴대폰</div>
												<div class="row">
													<div class="col-8" style="margin-top: 10px;margin-left: 16px;">
														<input class="form-control" type="tel" placeholder="숫자만 입력가능" name="mobile" id="mobile"/>
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
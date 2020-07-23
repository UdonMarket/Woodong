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
//폼값체크
function frmCheck(frm) {
	
	if(!frm.name.value){
		alert("아이디를 입력하세요");
		frm.name.focus();
		return false;
	}
	if(!frm.password.value){
		alert("비밀번호를 입력하세요");
		frm.password.focus();
		return false;
	}
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
											name="name" value="" placeholder="아이디"
											style="border-bottom: 1px solid gray;">
									</div>
									<div class="col-md-12 form-group p_star">
										<input type="password" class="single-input-primary"
											id="password" name="password" value="" placeholder="비밀번호"
											style="border-bottom: 1px solid gray;">
									</div>
									<div class="col-md-12 form-group">
										<div style="text-align: right; margin-top: 10px;">
											<div>
												<input type="checkbox" id="f-option1" name="selector">
												<label for="f-option1">아이디저장</label>
											</div>
										</div>
										<div style="margin-bottom: 20px;">
											<button type="submit" value="submit" class="btn_3">
												로그인</button>
												
												
											<!-- 네이버 로그인 창으로 이동 -->
											<div id="naver_id_login" style="text-align: center">
												<a href="${url}"> <img width="223"
													src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
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

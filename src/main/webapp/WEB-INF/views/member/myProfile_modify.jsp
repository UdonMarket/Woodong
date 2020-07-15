<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script>
function pwChange(){
	document.getElementById("pw").focus();
}
</script>
<body>
	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<jsp:include page="../include/mypageLeft.jsp" />
	<section class="left_main" style="padding-top: 100px;">
		<div style="margin-right: 2px;text-align: center;">
			<img src="../resources/img/myPage/회원정보수정.png" alt="" style="width: 280px;"/>
		</div>
		<div class="profile_edit_wrapper" style="border: 1px solid #d9d9d9;padding: 50px;margin-top: 50px;">
			<div class="profile_edit_image">
				<div class="profile_edit_image_box">
					<img src="https://ccimage.hellomarket.com/web/2019/member/img_apply_profile_4x_0419.png"
						alt="n16128097의 프로필 이미지">
				</div>
			</div>
			<form:form class="row contact_form" action="../member/changeInfomation.woo" method="post"
									novalidate="novalidate" name="modifyFrm" id="modifyFrm">
			<div class="profile_edit_main">
				<ul>
					<li>
						<div>아이디</div>
						<div>
							<div class="profile_userId_value">${memberVO.id }</div>
						</div>
					</li>
					<li>
						<div style="margin-top: 15px;">휴대폰</div>
						<div style="margin-top: 10px;">
							<input class="form-control" type="tel"  id="tel" name="tel" value="${memberVO.mobile }"/>
						</div>
						<div class="form-group mt-3" style="text-align: right; margin-left: 10px;">
							<button class="btn_my" type="button">인증</button>
						</div>
					</li>
					<li class="profile_password_area profile_password_area_first">
						<div style="margin-top: 15px;">비밀번호</div>
						<div class="profile_userId_value" style="margin-top: 10px;">
							<input class="form-control" type="password" value="${memberVO.pass }" id="pw" name="pw"/></div>
						<div class="form-group mt-3" style="text-align: right; margin-left: 10px;">
							<button class="btn_my" type="button"  onclick="pwChange();">변경</button>
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
				
				<div class="form-group mt-3" style="text-align: right;">
		              <button type="submit" class="btn_my" >수정하기</button>
	            </div>
			</div>
			
			</form:form>
		</div>
	</section>
	</div>
	</div>
	</div>
	</div>
	</div>
	</section>
	<!--================Blog Area =================-->
	<!-- bottom.jsp -->
	<jsp:include page="../include/bottom.jsp" />
	<jsp:include page="../include/sidebar.jsp" />
</body>

</html>
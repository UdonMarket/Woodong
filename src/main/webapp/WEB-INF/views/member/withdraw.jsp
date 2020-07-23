<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!doctype html>
<html lang="zxx">

<script>
function deleteMember(){
	var x = confirm("정말로 탈퇴하시겠습니까?");
	if(x){
		location.href="deleteMemberAction";
	}
	else
	 	return false;
}
}	
</script>

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />

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
								style="color: #ff4f4f; font-weight: bold; text-align: center; font-size: 3.0em; margin-bottom: 60px;">회원탈퇴</div>

							<div style="margin-bottom: 10px;">
								<form:form class="row contact_form"
									action="../member/deleteMemberAction" method="post"
									novalidate="novalidate" name="deleteFrm" id="deleteFrm"
									onsubmit="return frmCheck(this);">
									<div class="col-md-12 form-group p_star">
										<input type="password" class="single-input-primary" id="pass"
											name="pass" value="" placeholder="비밀번호"
											style="border-bottom: 1px solid gray;" required="required">
									</div>
									<div class="col-md-12 form-group">
										<div style="margin-bottom: 20px;">
											<button type="submit" value="submit" class="btn_3"
												onclick="javascript:deleteMember();">탈퇴하기</button>
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

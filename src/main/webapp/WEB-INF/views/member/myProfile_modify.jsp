<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html lang="zxx">


<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<head>
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
</head>
<script>
function pwChange(){
	document.getElementById("pw").focus();
}
</script>

<script>
  var count = 0; /* 문자 중복을 막기 위한 인증번호 */
   
 $(document).ready(function() {

    $("#send").click(function() {
       
       var number = Math.floor(Math.random() * 100000) + 100000;
          if(number>100000){
             number = number - 10000;
          }

          $("#text").val(number);      /* 난수로 생성된 인증번호를 hidden name : text 에 숨긴다 */
       
       var to = $("#to").val();
       
       if(to == "" || to == null){
          alert("빈칸이나 공백을 채워주세요");
       }
       
       else {
       var con_test = confirm("해당번호로 인증문자를 발송하시겠습니까?");   /* 문자를 보낼껀지 물어본다 */
          
          if(con_test == true){
               
             if(count < 3){      /* 추후 데이터베이스에 컬럼 값을 확인하여 count 값을 비교 할 예정 */
                 
               $.ajax({
                   url:"sendSms.do",
                   type:"post",
                   data:{to: $("#to").val(),
                        text: $("#text").val()
                        },
                 success:function(){
                   alert("해당 휴대폰으로 인증번호를 발송했습니다");
                   count++;
                   
                   alert(count);
                   },
                   error(){
                      
                   }
                   
                });
             } else {
                alert("휴대폰 인증 그만하세요")
             }
          
          }
             else if(con_test == false){
                
             }
         }   
    })
    $("#enterBtn").click(function() {   /* 내가 작성한 번호와 인증번호를 비교한다 */
       alert($("#text").val());
       var userNum = $("#userNum").val();
       
       var sysNum = $("#text").val();         
       
       if(userNum == null || userNum == ""){
          alert("휴대폰으로 발송된 인증번호를 입력해주세요");
       }     
       else{     
          if(userNum.trim() == sysNum.trim()){
              alert("성공");
           }
           else {
              alert("실패");
           }          
       }
    });
    
    $("#butt").click(function() {  
    	location.href="../member/smsSendingStart.woo";
    	 /* $('#mo1').click(); */
    	
     });
    
  
  });
</script>
<body>
	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<jsp:include page="../include/mypageLeft.jsp" />
	<section class="left_main" style="padding-top: 100px;">
		<div style="margin-right: 2px; text-align: center;">
			<img src="../resources/img/myPage/회원정보수정.png" alt=""
				style="width: 280px;" />
		</div>
		<div class="profile_edit_wrapper"
			style="border: 1px solid #d9d9d9; padding: 50px; margin-top: 50px;">
			<div class="profile_edit_image">
				<div class="profile_edit_image_box">
					<img
						src="https://ccimage.hellomarket.com/web/2019/member/img_apply_profile_4x_0419.png"
						alt="n16128097의 프로필 이미지">
				</div>
			</div>
			<form:form class="row contact_form"
				action="../member/changeInfomation.woo" method="post"
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
								<input class="form-control" type="tel" id="tel" name="tel"
									value="${memberVO.mobile }" />
							</div>
							<div class="form-group mt-3"
								style="text-align: right; margin-left: 10px;">
								<button class="btn_my" type="button" id="butt" >인증</button>
							</div>

							<button hidden="hidden" type="button" class="btn btn-primary"
								data-toggle="modal" data-target="#myModal" id="mo1" alt="아이디찾기">
							</button>

						</li>
						<li class="profile_password_area profile_password_area_first">
							<div style="margin-top: 15px;">비밀번호</div>
							<div class="profile_userId_value" style="margin-top: 10px;">
								<input class="form-control" type="password"
									value="${memberVO.pass }" id="pw" name="pw" />
							</div>
							<div class="form-group mt-3"
								style="text-align: right; margin-left: 10px;">
								<button class="btn_my" type="button" onclick="pwChange();">변경</button>
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
						<button type="submit" class="btn_my">수정하기</button>
					</div>
				</div>

			</form:form>
			<!-- The Modal -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header" id="modal_head" value="휴대폰인증">
							<!-- <h4 class="modal-title">아이디 찾기</h4> -->
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body" id="modal_res">

							<%-- <form:form action="#" method="post">
						받는사람 : <input type="text" id="to" name="to" />
								<!-- 인증번호 받을사람 휴대폰 번호 -->
								<input type="button" id="send" value="전송" />
								<br>
								<!-- 문자보내는 전송버튼 -->
						인증번호 : <input type="text" id="userNum">
								<!-- 인증번호 입력창 -->
								<input type="button" id="enterBtn" value="확인">
								<!-- 인증번호와 내가 입력창에 입력한 인증번호 비교하는 창 -->
								<input type="hidden" name="text" id="text">
								<!-- 인증번호를 히든으로 저장해서 보낸다 -->

							</form:form> --%>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>

					</div>
				</div>

			</div>
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
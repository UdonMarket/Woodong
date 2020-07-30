<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />

<script>
function pwChange(){
	document.getElementById("pw").focus();
}
$(function() {
	//최종확인버튼 클릭시 빈값체크
	$('#btn').click(function() {
		$.ajax({
			url : "../member/memberModifyAction.woo",
			dataType : "html",
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset:utf-8;",
			data : {
				tel : $('#to').val(),
				pw : $('#pw').val()
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
	function errFunc() {
		var mobile = $("#to").val();

		if (mobile == "" || mobile == null) {
			$('#mo1').click();
		}
		
	}

	/*
	 요청 성공시 호출할 콜백메소드.
	 외부함수로 정의되어 있고 함수명만으로 호출하더라도 콜백데이터는 파라미터로 받을수 있다.
	 */
	function sucFunc() {
		var userNum = $("#userNum").val();
		if (userNum == null || userNum == "") {
			$('#mo2').click();
		}
	}
});
</script>

<script>

  var count = 0; /* 문자 중복을 막기 위한 인증번호 */
   
	 	
  $(document).ready(function() {
	  
	  var token = $("meta[name='_csrf']").attr("content");
	  var header = $("meta[name='_csrf_header']").attr("content");
	  $(function() {
	  	 $(document).ajaxSend(function(e, xhr, options) {
	   		xhr.setRequestHeader(header, token);
	  	});
	  	 
	  	
	  });
	  
	    $("#butt").click(function() {
	    	
	       var number = Math.floor(Math.random() * 100000) + 100000;
	          if(number>100000){
	             number = number - 10000;
	          }

	          $("#text").val(number);      /* 난수로 생성된 인증번호를 hidden name : text 에 숨긴다 */
	       
	       var to = $("#to").val();
	       
	       if(to == "" || to == null){
	          alert("휴대폰 번호를 입력하세요");
	       }
	       
	       else {
	       var con_test = confirm("해당번호로 인증문자를 발송하시겠습니까?");   /* 문자를 보낼껀지 물어본다 */
	          
	          if(con_test == true){
	             alert("11");
	             if(count < 3){      /* 추후 데이터베이스에 컬럼 값을 확인하여 count 값을 비교 할 예정 */
	               alert("22");
	               $.ajax({
	                   url:"../member/sendSms.do",
	                   type:"post",
	                   data:{to: $("#to").val(),
	                        text: $("#text").val()
	                        },
	                 success:function(){
	                   alert("해당 휴대폰으로 인증번호를 발송했습니다");
	                   count++;
	                   
	                   alert(count);
	                   },
	                   error: function(e){
	                      alert("실패"+e.status);
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
				action="../member/memberModifyAction.woo" method="post"
				 name="modifyFrm" id="modifyFrm">
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
								<input class="form-control" type="text" id="to" name="tel"
									value="${memberVO.mobile }" />
							</div>
							<button hidden="hidden" type="button" class="btn btn-primary" data-toggle="modal"
								data-target="#myModal" id="mo1" alt="휴대폰입력창"></button>
							
							
							<div class="form-group mt-3" style="margin-left: 5px;">
							<button class="btn_my" type="button" id="butt" >인증</button>
							</div>

						</li>
						<li>
							
							
							<div style="margin-top: 15px;">인증번호 </div>
							<div style="margin-top: 10px;">
								 <input class="form-control" type="text" id="userNum">   <!-- 인증번호 입력창 -->
							</div>
								   
							<div class="form-group mt-3" style="margin-left: 5px;">	   
  							<button class="btn_my" type="button" id="enterBtn">확인 </button><!--  인증번호와 내가 입력창에 입력한 인증번호 비교하는 창 -->
  							</div>
  
  							<button hidden="hidden" type="button"
															class="btn btn-primary" data-toggle="modal"
															data-target="#myModal2" id="mo2" alt="인증번호확인"></button>
 							 <input type="hidden" name="text" id="text">   <!-- 인증번호를 히든으로 저장해서 보낸다 -->
						</li>
						<li>
							
						</li>
						<li class="profile_password_area profile_password_area_first">
							<div style="margin-top: 15px;">비밀번호</div>
							<div class="profile_userId_value" style="margin-top: 10px;">
								<input class="form-control" type="password"
									value="${memberVO.pass }" id="pw" name="pw" />
							</div>
							<div class="form-group mt-3"
								style=" margin-left: 5px;">
								<button class="btn_my" type="button" onclick="pwChange();">변경</button>
							</div>
						</li>
						<li></li>
					</ul>

					<div class="form-group mt-3" style="text-align: right;">
						<button type="submit" class="btn_my" id="btn">수정하기</button>
					</div>
					
				</div>

			</form:form>
		</div>
	</section>
	
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header" id="modal_head">
					<h4 class="modal-title">경고</h4>
					<div style="text-align: right; margin-right: 30px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
				</div>

				<!-- Modal body -->
				<div class="modal-body" id="modal_res">휴대폰번호를 입력해주세요</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	
	<!-- The Modal -->
	<div class="modal fade" id="myModal2">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header" id="modal_head">
					<h4 class="modal-title">경고</h4>
					<div style="text-align: right; margin-right: 30px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
				</div>

				<!-- Modal body -->
				<div class="modal-body" id="modal_res">인증번호를 입력해주세요</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	
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
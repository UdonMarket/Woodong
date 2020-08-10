<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
var msg="";
var IMP = window.IMP; // 생략가능
IMP.init('imp95906061'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
IMP.request_pay({
    pg : 'kakaopay', // version 1.1.0부터 지원.
    pay_method : 'card',
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : '${title}',
    amount : '${price}',
    buyer_email : '${buyer_id}',
    buyer_name : '구매자이름',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
    //m_redirect_url : 'https://www.yourdomain.com/payments/complete'
}, function(rsp) {
    if ( rsp.success ) {
    	
    	$('#merchant_uid').val(rsp.merchant_uid);
    	$('#status').val(rsp.status);
    	$('#pay_method').val(rsp.pay_method);
    	
        msg = '결제가 완료되었습니다.';
        msg += '고유ID : ' + rsp.imp_uid;
        msg += '상점 거래ID : ' + rsp.merchant_uid;
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '카드 승인번호 : ' + rsp.apply_num;
        msg += '결제 상태 : ' + rsp.status;
        msg += '카드 결제방법 : ' + rsp.pay_method;
        
    } else {
        var errormsg = '결제에 실패하였습니다.';
        errormsg += '에러내용 : ' + rsp.error_msg;
        //alert(errormsg);
    }
    $('#alertMsg').val(msg);
    var mo = document.getElementById("butt");
	mo.click();
    //alert(msg);
});
</script>

<script>
//최종확인버튼 클릭시 빈값체크
$(document).ready(function() {
	  
	  var token = $("meta[name='_csrf']").attr("content");
	  var header = $("meta[name='_csrf_header']").attr("content");
	  $(function() {
	  	 $(document).ajaxSend(function(e, xhr, options) {
	   		xhr.setRequestHeader(header, token);
  		});
	  });
});

//DB에 결제 업데이트 
$(function() {
	$('#butt').click(function() {
		$.ajax({
			url : "../product/woopayAction.woo",
			dataType : "json",
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset:utf-8;",
			data : {
				merchant_uid : $('#merchant_uid').val(),
				product_name : $('#product_name').val(),
				product_price : $('#product_price').val(),
				board_idx : $('#board_idx').val(),
				seller_id : $('#seller_id').val(),
				status : $('#status').val(),
				pay_method : $('#pay_method').val()
			},
			success : function(d){
				if(d.sucOrFail==1){
				alert($('#alertMsg').val());
				location.href = "../mypage/myPage.woo?mode=deal&dealMode=buy";
				}
				else{
					alert("결제 실패하였습니다");
					location.href = "../product/productView.woo?boardidx="+$('#board_idx').val();
				}
			}, /* sucFunc(data)형태로 사용하지 않는다. */
			error : function errFunc(e) {
				alert(e.success);
				
			}
		});
	});
});
</script>


</head>
<body>


<button type="button" hidden="hidden" id="butt"></button>
<input type="hidden" value="" id="merchant_uid"/> 
<input type="hidden" value="${title}" id="product_name"/>
<input type="hidden" value="${price}" id="product_price"/>
<input type="hidden" value="${boardidx}" id="board_idx"/>
<input type="hidden" value="${seller_id }" id="seller_id"/>
<input type="hidden" value="" id="status"/>
<input type="hidden" value="" id="pay_method"/>
<input type="hidden" value="" id="alertMsg"/>



</body>
</html>
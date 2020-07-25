<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<body>

<!--우동 파일명 : productList.jsp  -->

	<!--::header part start::-->
	<!-- header.jsp -->
	<jsp:include page="../include/hearder.jsp" />
	<!-- Header part end-->

	<!-- breadcrumb part start-->

	<jsp:include page="../include/productLeft.jsp" />
	<script>	
function like_toggle(idx) {
	var like_flag;
	if($("img[name=" + idx + "]").attr('src')=="../resources/img/2.png"){
		like_flag = 1;
	}
	else{
		like_flag = -1;
	}
	var str = "";
	str += idx + "#";
	$.ajax({
		url : "../mypage/like_toggle.woo",
		type:"get",
	    contentType:"text/html;charset:utf-8",
	    data:{idx : idx, like_flag : like_flag, str : str},
 	  	success : function(d) {
 	  		if($("img[name=" + idx + "]").attr('src')=="../resources/img/2.png"){
 	  			$("img[name=" + idx + "]").attr('src', "../resources/img/1.png");
 			}
 			else{
 				$("img[name=" + idx + "]").attr('src', "../resources/img/2.png");
 			}
		},
		error : function(request,status,error) {
	          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	});
}
</script>

 <script>
 var scrollchk = true; //스크롤 체크 여부 플래그  
 var nowPage = 1;//현재페이지 
 var totallist; //ajax로 받아온 rdata를 이 변수에 계속 누적시킴  
 var state="true"; 
 
//1.productList.jsp 로 들어오면 첫 실행되는 함수
$(window).ready(function() {
	 loadlist(); 
});
//2. 
var loadlist = function(){ 
    $.ajax({  
        url : './ajaxList.woo',  
        type : 'get',  
        data : {nowPage : nowPage},
        async: false,
        success : function(rdata) { 
        	
	    scrollchk = false;	
   	     $("input[name='stateflag']").each(function(i){
		   	   if($("input[name='stateflag']").eq(i).val()=='false'){
	  	    			state='false';
		        }
         });
      	    
	       if(state=='true'){ 
				$('#boardHTML').append(rdata);
				totallist += rdata;
				nowPage++;
	      		scrollchk = true; //데이터 로딩이 끝나면 스크롤체크를 풀어준다.  
	        }
		    else if(state=='false'){ 
	   	    	alert("데이터가 없습니다.");
	   	    }
        },                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
	   error : function(request,status,error) {
		console.log("code : "+request.status+"\n"+"message : "
		 + request.responseText+"\n"+"error : "+error);
		}
   });  
}  
//3.
$(window).scroll(function(){ 
   	//새로고침이나 뒤로가기시 스크롤이 밑으로가있으면 로딩체크를하며 알람메시지가뜨므로 페이지를 완전히 세팅후 스크롤체크를 하도록 방어처리  
	if(scrollchk){ 
		if($(window).scrollTop() >= $(document).height() - $(window).height()-30 && state=='true'){  
            loadlist(); 
        }  
    } 
});  
</script>
	<div class="col-md-9" style="padding-top: 37px" >
		<div class="row" id="boardHTML"></div>
	</div>
	
	</div>
	</div>
	</section>

	<jsp:include page="../include/bottom.jsp" />
	
	<jsp:include page="../include/sidebar.jsp" />
</body>
</html>

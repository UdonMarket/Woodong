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
 var scrollchk = true; //스크롤 체크 여부 플래그  
 var mutex = false;  //mutex 플래그
 var nowPage = 1;//현재페이지 
 var totallist; //ajax로 받아온 rdata를 이 변수에 계속 누적시킴  
 var state=""; //ajax로 받아온 rdata를 이 변수에 계속 누적시킴  

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
        success : function(rdata) { 
        	
       	    $("input[name='stateflag']").each(function (i) {
        		  state = $("input[name='stateflag']").eq(i).attr("value"); 
        		  console.log( i + "stateflag : " + $("input[name='stateflag']").eq(i).val() );
  
             });
        	
       	    if(state=='false'){ 
       	    	scrollchk = false;
       	    	alert("데이터가 없습니다. nowPage :"+ nowPage);
       	    	nowPage--;
       	    	
       	    	//페이지 끝에 도달시 스크롤 업! 수정 예정
       	    	$( 'html, body' ).animate( { scrollTop : 100 }, 400 );
       	    	state=''
      	    }
       	    else {
       	   		//console.log(rdata.length);
				//console.log(rdata);
				$('#boardHTML').append(rdata);
				totallist += rdata;
				history.replaceState({total:totallist, page:nowPage},'Page '+ nowPage,'./productList.woo?##'); 
       	    	nowPage++;
       	    }
           	scrollchk = true; //데이터 로딩이 끝나면 스크롤체크를 풀어준다.  
           	mutex = false; //데이터로딩이 끝나면 ajax접근권한을 준다(중복호출 방어) 
        },                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
        error : function(request,status,error) {
			 console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
    });  
}  

//3.
$(window).scroll(function(){ 
    if(scrollchk){ ///새로고침이나 뒤로가기시 스크롤이 밑으로가있으면 로딩체크를하며 알람메시지가뜨므로 페이지를 완전히 세팅후 스크롤체크를 하도록 방어처리  
        if($(window).scrollTop() >= $(document).height() - $(window).height()-30){  
            if(mutex){  
            	//console.log('다음페이지를 로딩중입니다.');
                return;  
            }  
            mutex = true;  
            loadlist(); 
        }  
    }  
});  

//4.
if(location.hash){  //현재 주소에 ##이라는앵커가 박혀있을경우 true가 발생한다.  
    //앵커가 박혔다는것은 새 페이지 진입이아니라 한번이라도 로딩이 있었던 페이지이므로  
    //뒤로가기로 왔다는 뜻이된다.  
	var data = history.state; //아까 데이터로 보낸부분이 history.state에 저장이되어있다.  
	
	if(data){  
		scrollchk = false; //데이터를 세팅하는동안 스크롤 체크를 하지않게하자.  
		nowPage = data.page-1;     //저장되었던 마지막 페이지를 세팅
		alert(nowPage);
		loadlist(); 
		scrollchk = true;  //데이터 세팅 종료 후 스크롤 체크  
	}   
}

</script>

	<div class="col-md-9" style="padding-top: 37px" >
	
		<div class="row" id="boardHTML">
			<div class="col-4">
			</div>
		</div>
	</div>
	
	</div>
	</div>
	</section>

	<jsp:include page="../include/bottom.jsp" />
	
	<jsp:include page="../include/sidebar.jsp" />
</body>

</html>
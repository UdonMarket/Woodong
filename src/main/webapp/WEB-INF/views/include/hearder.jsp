<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script>
   $(window).scroll(function(){
      if($(window).scrollTop()==0){
         $('.main-top').slideDown('slow');
         $('.main-top').show();
      }
      else{
    	  $('.main-top').slideUp('slow');
         $('.main-top').hide();
      }
   });  
</script>	
<header class="main_menu home_menu">
	<div class="container-fluid" style="padding-left: 90px;padding-right: 90px;">
		<!-- 로그인 로그아웃 아이콘  start -->
		<div class="main-top">
	        <div class="container-fluid">
	            <div class="row">
	                <div style="margin-left:85%;">
						<div>
		                    <div class="text-slid-box">
		                        <div class="our-link">
		                        	  	<sec:authorize access="isAnonymous()">
		                        	  	   <ul>
				                            <li><a href="../member/login.woo"><img src="../resources/img/header/login.png" style="width:80px;height:33px;"/></a></li>
				                            <li><a href="../member/join.woo"><img src="../resources/img/header/join.png" style="width:80px;height:33px;"/></a></li>
			                               </ul>
			                             </sec:authorize>
			                              <sec:authorize access="isAuthenticated()">
		                              		<a href="../member/memberModify.woo"><input type="image" src="../resources/img/header/edit.png" style="width:110px;height:33px;" /></a>
			                              <div style="display: inline-block;">
			                              <form:form method="post" action="../member/logout"> 
			                            	<input type="image" src="../resources/img/header/logout.png" style="width:80px;height:33px;" />
			                             </form:form> 
			                             </div>
			                             </sec:authorize>
			                    </div>
		                    </div>
	                    </div>
               		</div>
	            </div>
	        </div>
	    </div>
	<!-- 로그인 로그아웃 아이콘  end -->
		<div class="row align-items-center justify-content-center">
			<div class="col-lg-12">
				<nav class="navbar navbar-expand-lg navbar-light">
					<a class="navbar-brand" href="../main/main.woo">
						<img src="../resources/img/logo.png" alt="logo" style="width: 250px; height: 78; margin-bottom:10px;" />
					</a>
 
					<div class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
						<ul class="navbar-nav">
							<li class="nav-item" style="margin-right: 90px;margin-top:5px;" >
								<a class="nav-link" href="../about/about.woo">
									<img src="../resources/img/header/about.png" alt="소개" />
								</a>
							</li>
							<li class="nav-item" style="margin-right: 60px;margin-top:5px;">
								<a class="nav-link" href="../product/productList.woo">
									<img src="../resources/img/header/ca.png" alt="카테고리" />
								</a>
							</li>
							<li class="nav-item" style="margin-right: 50px;margin-top:5px;">
								<a class="nav-link" href="../mypage/myPage.woo">
									<img src="../resources/img/header/myPage.png" alt="나의우동" />
								</a>
							</li>

							<li class="nav-item" style="margin-top:5px;">
								<a class="nav-link" href="../community/community.woo?bname=공지사항&">
									<img src="../resources/img/header/comm.png" alt="커뮤니티" />
								</a>
							</li>
						</ul>
					</div>
					<div class="hearer_icon d-flex align-items-center" >
	                  	<div class="input-group mb-3">

	              			<input type="text" placeholder="찾는 상품을  #태그 로 검색하세요 !" class="form-control search_input" id="headkeywordInput"
	              			style="border:none; border-bottom: 2px solid #d9d9d9;width: 230px;border-radius: 0;margin-bottom: -5px;">

	                       	<div class="input-group-append" style="margin: 0;padding: 0">
	                    		<button class="btn btn-basic" type="button" id="headsearchBtn">
	                    			<i style="font-size:22px;color: #ff4f4f;" class="ti-search"></i>
	                    		</button>
	                    		<button style="cursor:pointer; border: 0;background: none;color: #ff4f4f;margin: 0;padding: 0" 
			                 	onclick="window.open('http://192.168.219.139:8282/woodong/chatting/chatMain.woo', 'name(우동톡톡)', 'height=640; width=480; top=200; left=150;', true);">
			                     	<i style="font-size:26px;margin: 5px;margin-top: 2px;" class="fa">&#xf0e6;</i>
                  				</button>
	                       	</div>
	                  	</div>
               		</div>
				</nav>
			</div>
		</div>
	</div>
	<script>
$(function(){
	$('#headsearchBtn').click(function() {
	self.location = "../product/productList.woo?"
	 + "&searchField=product_tag&searchTxt=" + encodeURIComponent($('#headkeywordInput').val())+"&";
	});
});   
</script>
</header>
<script>
function checkchat(){
   var id = document.getElementById("id");
   var room = document.getElementById("chat_room");
   
   if(id.value==""){
      alert("로그인 후 이용해 주세요.");
      location.href='../member/login.woo';
   }
   window.open('../chatting/chatMain.woo', '_blank', 'height=600; width=480; top=200; left=150;', true);
}
</script>
<script>
function itemSave(boardidx){
	 $.ajax({
			url : "../product/itemSave.woo",
			data : {boardidx : boardidx},
			dataType : "json",
			type : "get",
			contentType : "text/html;charset:utf-8",
			success : sucFunc, 
	    	error : errFunc
		 });
	 function sucFunc(d) {
		  for(var i=1 ; i<=d.length ; i++){
	  		 $("#img"+i).attr("src","../resources/Upload/"+d[i-1].imagefile);
	  		 $("#title"+i).html(d[i-1].title);
	  		 $('#title'+i).attr('href', "javascript:void(0);")
	  		 $("#title"+i).attr("onclick","ajaxView(" + d[i-1].boardidx + ")");
		   }
	 	}
		  
	
	function errFunc(e){
		 //alert(e);
	}
}

 </script>
<script>
//ajaxView 로 이동
function ajaxView(boardidx){

    $.ajax({  
        url : '../product/ajaxproductView.woo',  
        type : 'get',  
        data : {boardidx : boardidx},
        success : function(data){
        	var test = data.split(' ');
        	if(test[0].indexOf('!!!!!!!')>-1){
        		switch (test[1]){
        			case '4' : 
        				alert('따듯한 튀김우동 이상만 볼 수 있습니다.');
        				break;
        			case '3' : 
        				alert('차가운 튀김우동 이상만 볼 수 있습니다.');
        				break;
        			case '2' : 
        				alert('따듯한 일반우동 이상만 볼 수 있습니다.');
        				break;
        		}
        	}
        	else{
	        	itemSave(boardidx);
	        	$('.modal-body').html("");
	       		$('.modal-body').html(data);
	       		$('#modalview').click();
        	}
        },  
	   	error : function(request,status,error) {
		console.log("code : "+request.status+"\n"+"message : " + request.responseText+"\n"+"error : "+error);
		}
   });
} 
	
</script>
<head>
<link rel="stylesheet" href="../resources/css/3d.css">   
</head>

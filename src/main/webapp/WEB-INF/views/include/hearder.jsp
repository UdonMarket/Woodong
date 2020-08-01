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
			                              <form:form method="post" action="${pageContext.request.contextPath}/logout"> 
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

		<div class="row align-items-center justify-content-center">
			<div class="col-lg-12">
				<nav class="navbar navbar-expand-lg navbar-light">
					<a class="navbar-brand" href="../main/main.woo">
						<img src="../resources/img/logo.png" alt="logo" style="width: 250px; height: 78; margin-bottom:10px;" />
					</a>
 
					<div class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
						<ul class="navbar-nav">
							<li class="nav-item" style="margin-right: 85px;margin-top:5px;" >
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

							<li class="nav-item" style="margin-right: 100px;margin-top:5px;">
								<a class="nav-link" href="../community/community.woo">
									<img src="../resources/img/header/comm.png" alt="커뮤니티" />
								</a>
							</li>
						</ul>
					</div>
					<div class="hearer_icon d-flex align-items-center">
	                  	<div class="input-group mb-3">
	              			<input type="text" placeholder="찾는 상품을  # 태그  로 검색하세요 !" class="form-control search_input" id="headkeywordInput"
	              			style="border:none; border-bottom: 2px solid #d9d9d9;width: 320px;border-radius: 0;margin-bottom: -5px;">

	                       	<div class="input-group-append" style="margin-bottom: -20px;margin-left: 5px;">
	                    		<button class="btn btn-basic" type="button" id="headsearchBtn">
	                    			<i style="font-size:22px;color: #ff4f4f;" class="ti-search"></i>
	                    		</button>
	                    		<button style="cursor:pointer; border: 0;background: none;color: #ff4f4f;" 
			                 	onclick="window.open('../chatting/chatMain.woo', 'name(우동톡톡)', 'height=600; width=480; top=200; left=150;', true);">
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

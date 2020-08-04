<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
 $(document).ready(function(){
	 $.ajax({
		url : "../product/itemSave.woo",
		dataType : "json",
		type : "get",
		contentType : "text/html;charset:utf-8",
		success : sucFunc, 
    	error : errFunc
	 });
 	});
  	function sucFunc(d) {
	  for(var i=1 ; i<=d.length ; i++){
  		 $("#img"+i).attr("src","../resources/Upload/"+d[i-1].imagefile);
  		 $("#title"+i).html(d[i-1].title);
  		 $("#title"+i).attr("href","http://192.168.219.139:8282/woodong/product/productView.woo?boardidx="+d[i-1].boardidx);
	   }
 	}
	function errFunc() {} 
 </script>
	
<div id="floatMenu">
	<div style="text-align: center;margin-left: 5px;margin-bottom: -20px;">
		<img src="../resources/img/sidebar/판매하기로고.png" alt="판매하기" 
		style="width: 200px;cursor:pointer;" onclick="location.href='../product/productWrite.woo'">
	</div>
	<div id="floatMenuBox1" style="background:none;border:1px solid black;padding-top:10px;">
		<div>
			<div>
				<a href="../member/myPlace.woo" style="link:black;">
					<img src="../resources/img/sidebar/location.png" alt="동네인증" width="20" height="20" /> 동네인증
				</a>
			</div>
		</div>
	</div>
	<div id="floatMenuBox1"  style="background:none;border:1px solid black;padding-top:10px;">
		<div>
			<div>
				<a href="../mypage/myPage.woo?mode=like"><img src="../resources/img/sidebar/heart.png" alt="찜상품" width="20" height="20" /> 내가 찜한 상품</a>
			</div>
		</div>
	</div>
	<div id="floatMenuBox1"  style="background:none; height:300px;border:1px solid black;">
		<div style="font-weight:bold;"><h5><small><b>최근 본 상품</b></small></h5></div>
			<div id="floatMenuBox1"  style="background:none;border:none;margin-bottom: 50px; margin-top: -15px;" >
				<img id="img1" src="../resources/img/sidebar/none.png"  style="width: 150px; height: 70px;"/>
				<div style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; margin-left:20px; width: 150px;">
				<a href="http://192.168.219.139:8282/woodong/product/productView.woo?boardidx=" id="title1" ></a></div>
			</div>		
			<div id="floatMenuBox1"  style="background:none;border:none;margin-bottom: 50px; ">
				<img id="img2" src="../resources/img/sidebar/none.png"  style="width:150px; height: 70px;"/>
				<div style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; margin-left:20px; width: 150px;"><a href="../product/productView.woo?boardidx=" id="title2"></a></div>
			</div>
			<div id="floatMenuBox1"  style="background:none;border:none;">
				<img id="img3" src="../resources/img/sidebar/none.png"  style="width: 150px; height: 70px;"/>
				<div style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; margin-left:20px; width: 150px;"><a href="../product/productView.woo?boardidx=" id="title3"></a></div>
			</div>
		</div>
	<a href="">
		<button style="width:205px; height:60px;margin-top:5px;background-color:white;border:1px solid black;" > TOP </button>
	</a>
	</div>
<script>
//Side Bar 설정 
$(function() {
	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($("#floatMenu").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );
	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";
		if(scrollTop<500){
			newPosition = 500 + floatPosition + "px";
		}
		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */
		$("#floatMenu").stop().animate({
			"top" : newPosition
		}, 500);
	}).scroll();
});
</script>

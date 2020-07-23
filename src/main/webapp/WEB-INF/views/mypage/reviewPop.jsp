<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- head.jsp -->
<jsp:include page="../include/head.jsp" />
<script>
$(function() {
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  $('#cal_reviewPoint').val(this.id);
		  $('#aa').text(this.id);
		  return false;
		});
})
	
</script>

<style>
   .starR1{
	background:url("../resources/img/우동수정1.png");/* 왼쪽 빨강 */
	background-repeat: no-repeat;
   
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
    background:url("../resources/img/우동수정2.png");
	background-repeat: no-repeat; 
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:-21px 0;}
.starR2.on{background-position:-20px 0;}

</style>

<script type="text/javascript">
function writeValidate(f)
{
	if(f.contents.value==""){
		alert("내용을 입력하세요");
		f.contents.focus(); 
		return false;
	} 
}

</script>


<body>
   <div class="oViOeBoH3d container" style="padding-top: 10px;">
         <h4>상대방의 거래에 만족하셨나요?</h4>
      <div class="row" style=" padding-bottom: 20px; ">
         <div class="col-1"></div>
        	 <div class="col-3" id="aa" style="font-size: 40px; font-weight: bold;">
				1
         	</div>
            <div class="profile_review_image col-7">
               <div class="profile_review_image_box">
					<div class="starRev" style="margin-top: 18px; ">
						<span class="starR1 on" id="0.5">별1_왼쪽</span> <span class="starR2 on" id="1">별1_오른쪽</span>
						<span class="starR1" id="1.5">별2_왼쪽</span> <span class="starR2" id="2">별2_오른쪽</span>
						<span class="starR1" id="2.5">별3_왼쪽</span> <span class="starR2" id="3">별3_오른쪽</span>
						<span class="starR1" id="3.5">별4_왼쪽</span> <span class="starR2" id="4">별4_오른쪽</span>
						<span class="starR1" id="4.5">별5_왼쪽</span> <span class="starR2" id="5">별5_오른쪽</span>
					</div>
				</div>
            </div>
         </div>
      </div>
   <div class="oViOeBoH3d container" style="padding-top: 20px;">
      <h4>어떤 점이 좋았나요?</h4>
      <form:form  name="writeFrm" method="post" onsubmit="return writeValidate(this);" action="write_review_contents.woo">
         	<input type ="hidden" value="" id="cal_reviewPoint" name="cal_reviewPoint"/>
      <input type="hid den" name ="write_idx" value="${idx}"/>
      <div class="ystMZ36gvH row" style="padding-top: 10px;">
         <div class="_30-j0z23yB col-12">
            <textarea class="_2mqbEheJIc" id="reviewInput"  name ="contents" cols="30"
               style="width: 100%; height: 100px;" placeholder="최소 10글자이상 입력해 주세요."></textarea>
            <div class="_2WdOh6YXC8" style="text-align: right;">
               <em class="_3LoikG0PPT"><span class="blind">입력글자수</span>0</em><span
                  class="_2dV9e5HlSd"></span><span class="blind">최대글자수</span>5,000
            </div>
         </div>
      </div>
      <div class="_3DpEZeFAIG">
         <div class="j7JepWm_pE">
            <button type="submit" class="btn_my" style="margin-top: 20px;">
               <span class="" >작성완료</span>
            </button>
         </div>
      </div>
      </form:form>
   </div>
</body>
</html>
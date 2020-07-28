<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>
<body>
	<!--::header part start::-->
	<!-- header.jsp --> 
    <jsp:include page="../include/hearder.jsp"/>
	<!-- Header part end-->
	<script>
	$( function() {
		$( "#accordion" ).accordion({
			collapsible: true
		});
	} );
	</script>
	<!-- breadcrumb part start-->
		<section class="breadcrumb_part" >
	      <div class="container-fluid">
	         <div class="row top_image"></div>
	         <img src="../resources/img/공지사항.png" alt="" id="main" style="height: 100%; width: 100%">
	      </div>
	   </section>
	<!-- breadcrumb part end-->

	<!--================login_part Area =================-->
	<section class="login_part section_padding" style="padding-top: 30px">
		<!-- 상단과 내용 띄우기 -->
		<div class="container">
			<div class="row">
				<jsp:include page="../include/communityLeft.jsp"/>
				<div class="col-lg-9" style=" margin-top: 50px;">
					<div id="accordion" class="accordion_list">
						<c:forEach items="${lists }" var="row">
						    <h6 style="font-size: 20px">${row.title }</h6>
							<div>
						    	<p>${row.contents }</p>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================login_part end =================-->

	<!-- bottom.jsp -->
    <jsp:include page="../include/bottom.jsp"/>
    <jsp:include page="../include/sidebar.jsp"/>
</body>

</html>

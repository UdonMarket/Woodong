<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					    <h3>Section 1</h3>
						<div>
					    	<p>Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut odio. Curabitur malesuada. Vestibulum a velit eu ante scelerisque vulputate.</p>
						</div>
						<h3>Section 2</h3>
						<div>
				    		<p>Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna. </p>
						</div>
						<h3>Section 3</h3>
						<div>
					    	<p>Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis. Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui. </p>
						    <ul>
							    <li>List item one</li>
							    <li>List item two</li>
							    <li>List item three</li>
					    	</ul>
						</div>
						<h3>Section 4</h3>
						<div>
					    	<p>Cras dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aenean lacinia mauris vel est. </p><p>Suspendisse eu nisl. Nullam ut libero. Integer dignissim consequat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. </p>
					    </div>
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

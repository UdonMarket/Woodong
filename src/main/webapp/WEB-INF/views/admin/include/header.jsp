<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<!-- Navbar -->
<nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
	<div class="container-fluid">
		<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="../admin/admin.woo">관리자페이지</a>
		<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
			<div class="login-box">
				<div style="text-align:right; color: #fff">
					<form:form method="post" action="${pageContext.request.contextPath }/admin/logout">
						<label><input type="image" src="../resources/img/logout.png" style="width:20px;height:20px;"/> 로그아웃</label>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
	
</nav>

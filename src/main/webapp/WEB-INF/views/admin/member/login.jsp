<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />

<body class="bg-default">
	<div class="main-content">
		<!-- Navbar -->
		
		<!-- Header -->
		<div class="header bg-gradient-primary py-7 py-lg-8">
			<div class="container">
				<div class="header-body text-center mb-7">
					<div class="row justify-content-center">
						<div class="col-lg-5 col-md-6">
							<h1 class="text-white">Welcome!</h1>
						</div>
					</div>
				</div>
			</div>
			<div class="separator separator-bottom separator-skew zindex-100">
				<svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none"
					version="1.1" xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
        </svg>
			</div>
		</div>
		<!-- Page content -->
		<div class="container mt--8 pb-5">
			<div class="row justify-content-center">
				<div class="col-lg-5 col-md-7">
					<div class="card bg-secondary shadow border-0">
						
						<div class="card-body px-lg-5 py-lg-5">
							
							 <c:url value="/admin/login" var="loginUrl"/>
							<form:form name="loginFrm" action="${loginUrl}" method="post" novalidate="novalidate">
								
								<c:if test="${param.error != null} }">
									<p>아이디와 패스워드가 잘못되었습니다.</p>
								</c:if>
								<c:if test="${param.login != null} }">
									<p>로그아웃하였습니다.</p>
								</c:if>

								<div class="form-group mb-3">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-email-83"></i></span>
										</div>
										<input class="form-control" placeholder="id" type="email" name="admin_id">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-lock-circle-open"></i></span>
										</div>
										<input class="form-control" placeholder="Password"
											type="password" name="admin_pw">
									</div>
								</div>
								
								<div class="text-center">
									<button type="submit" value="submit" class="btn btn-primary my-4">Sign in</button>
										
										
								</div>
								</form:form>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<footer class="py-5">
			<div class="container">
				<div class="row align-items-center justify-content-xl-between">
					<div class="col-xl-12" style="text-align: center">
						<div class="copyright text-center text-xl-center text-muted">
							© 2020 Woodong
						</div>
					</div>
					
				</div>
			</div>
		</footer>
	</div>
	<!--   Core   -->
	<script src="../resources/admin/js/plugins/jquery/dist/jquery.min.js"></script>
	<script
		src="../resources/admin/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!--   Optional JS   -->
	<!--   Argon JS   -->
	<script src="../resources/admin/js/argon-dashboard.min.js?v=1.1.2"></script>
	<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
	<script>
		window.TrackJS && TrackJS.install({
			token : "ee6fab19c5a04ac1a32a645abde4613a",
			application : "argon-dashboard-free"
		});
	</script>
</body>

</html>
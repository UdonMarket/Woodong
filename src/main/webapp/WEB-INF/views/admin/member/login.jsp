<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<!--

=========================================================
* Argon Dashboard - v1.1.2
=========================================================

* Product Page: https://www.creative-tim.com/product/argon-dashboard
* Copyright 2020 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/argon-dashboard/blob/master/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. -->
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />

<body class="bg-default">
	<div class="main-content">
		<!-- Navbar -->
		<nav
			class="navbar navbar-top navbar-horizontal navbar-expand-md navbar-dark">
			<div class="container px-4">
				<a class="navbar-brand" href="../index.html"> <img
					src="../resources/admin/img/brand/white.png" />
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbar-collapse-main"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbar-collapse-main">
					<!-- Collapse header -->
					<div class="navbar-collapse-header d-md-none">
						<div class="row">
							<div class="col-6 collapse-brand">
								<a href="../index.html"> <img
									src="../resources/admin/img/brand/blue.png">
								</a>
							</div>
							<div class="col-6 collapse-close">
								<button type="button" class="navbar-toggler"
									data-toggle="collapse" data-target="#navbar-collapse-main"
									aria-controls="sidenav-main" aria-expanded="false"
									aria-label="Toggle sidenav">
									<span></span> <span></span>
								</button>
							</div>
						</div>
					</div>
					<!-- Navbar items -->
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a class="nav-link nav-link-icon"
							href="../index.html"> <i class="ni ni-planet"></i> <span
								class="nav-link-inner--text">Dashboard</span>
						</a></li>
						<li class="nav-item"><a class="nav-link nav-link-icon"
							href="../examples/register.html"> <i class="ni ni-circle-08"></i>
								<span class="nav-link-inner--text">Register</span>
						</a></li>
						<li class="nav-item"><a class="nav-link nav-link-icon"
							href="../examples/login.html"> <i class="ni ni-key-25"></i> <span
								class="nav-link-inner--text">Login</span>
						</a></li>
						<li class="nav-item"><a class="nav-link nav-link-icon"
							href="../examples/profile.html"> <i class="ni ni-single-02"></i>
								<span class="nav-link-inner--text">Profile</span>
						</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- Header -->
		<div class="header bg-gradient-primary py-7 py-lg-8">
			<div class="container">
				<div class="header-body text-center mb-7">
					<div class="row justify-content-center">
						<div class="col-lg-5 col-md-6">
							<h1 class="text-white">Welcome!</h1>
							<p class="text-lead text-light">Use these awesome forms to
								login or create new account in your project for free.</p>
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
						<div class="card-header bg-transparent pb-5">
							<div class="text-muted text-center mt-2 mb-3">
								<small>Sign in with</small>
							</div>
							<div class="btn-wrapper text-center">
								<a href="#" class="btn btn-neutral btn-icon"> <span
									class="btn-inner--icon"><img
										src="../resources/admin/img/icons/common/github.svg"></span> <span
									class="btn-inner--text">Github</span>
								</a> <a href="#" class="btn btn-neutral btn-icon"> <span
									class="btn-inner--icon"><img
										src="../resources/admin/img/icons/common/google.svg"></span> <span
									class="btn-inner--text">Google</span>
								</a>
							</div>
						</div>
						<div class="card-body px-lg-5 py-lg-5">
							<div class="text-center text-muted mb-4">
								<small>Or sign in with credentials</small>
							</div>
							<%-- 추가부분 --%>
							 <c:url value="/loginAction" var="loginUrl"/>
							<form:form name="loginFrm" action="${loginUrl }" method="post"
								novalidate="novalidate">
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
										<input class="form-control" placeholder="Email" type="email" name="admin_id">
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
								<div
									class="custom-control custom-control-alternative custom-checkbox">
									<input class="custom-control-input" id=" customCheckLogin"
										type="checkbox"> <label class="custom-control-label"
										for=" customCheckLogin"> <span class="text-muted">Remember
											me</span>
									</label>
								</div>
								<div class="text-center">
									<button type="submit" value="submit" class="btn btn-primary my-4">Sign
										in</button>
										
								</div>
								</form:form>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-6">
							<a href="#" class="text-light"><small>Forgot
									password?</small></a>
						</div>
						<div class="col-6 text-right">
							<a href="#" class="text-light"><small>Create new
									account</small></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<footer class="py-5">
			<div class="container">
				<div class="row align-items-center justify-content-xl-between">
					<div class="col-xl-6">
						<div class="copyright text-center text-xl-left text-muted">
							© 2018 <a href="https://www.creative-tim.com"
								class="font-weight-bold ml-1" target="_blank">Creative Tim</a>
						</div>
					</div>
					<div class="col-xl-6">
						<ul
							class="nav nav-footer justify-content-center justify-content-xl-end">
							<li class="nav-item"><a href="https://www.creative-tim.com"
								class="nav-link" target="_blank">Creative Tim</a></li>
							<li class="nav-item"><a
								href="https://www.creative-tim.com/presentation"
								class="nav-link" target="_blank">About Us</a></li>
							<li class="nav-item"><a href="http://blog.creative-tim.com"
								class="nav-link" target="_blank">Blog</a></li>
							<li class="nav-item"><a
								href="https://github.com/creativetimofficial/argon-dashboard/blob/master/LICENSE.md"
								class="nav-link" target="_blank">MIT License</a></li>
						</ul>
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
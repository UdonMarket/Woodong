<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<body class="">
	<jsp:include page="../include/left.jsp"/>
	<div class="main-content">
		<jsp:include page="../include/header.jsp"/>
		<!-- End Navbar -->
		<!-- Header -->
		<div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
			<div class="container-fluid">
				<div class="header-body">
					<!-- Card stats -->
					
				</div>
			</div>
		</div>
		<div class="container-fluid mt--7">
			<div class="row">
			<div class="col-2"></div>
				<div class="col-8">
					<div class="card shadow">
						<div class="card-header bg-transparent">
							<div class="row align-items-center">
								<div class="col">
								</div>
							</div>
						</div>
						<div class="card-body">
							<!-- Chart -->
							<%-- <div class="chart" style="width: 100%; overflow: auto;">
								<canvas id="myChart" class="chart-canvas" height="100%"></canvas>
							</div> --%>
							<div id="chartContainer" style="height: 370px; width: 100%;"></div>
								
						</div>
					</div>
				</div>
			<div class="col-2"></div>
			</div>
			<div class="row mt-5">
			<div class="col-2"></div>
				<div class="col-xl-8">
					<div class="card shadow">
						<div class="card-header border-0">
							<div class="row align-items-center">
							</div>
						</div>
						<div class="table-responsive">
							<div id="member" style="height: 370px; width: 100%;"></div>
						</div>
					</div>
				</div>
			<div class="col-2"></div>
			</div>
			
			
			<div class="row mt-5">
			<div class="col-2"></div>
				<div class="col-xl-8">
					<form:form action="../admin/prohidition.woo" method="post">
						<div class="card shadow">
							<div class="card-header border-0">
								<div class="row align-items-center">
									<div class="col">
										<h3 class="mb-0">금칙어</h3>
									</div>
									<div class="col text-right">
										<button class="btn btn-sm btn-primary">
											저장
										</button>
									</div>
								</div>
							</div>
							<div class="table-responsive">
								<!-- Projects table -->
								<table class="table align-items-center table-flush">
									<tr>
										<td>
											<textarea class="form-control" rows="15" name="prohiditionList" id="content" placeholder="내용을 입력해 주세요" required="required"><c:forEach items="${prohidition }" var="row">${row },</c:forEach></textarea>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</form:form>
				</div>
			<div class="col-2"></div>
			</div>
		</div>

<script>
	window.onload = function () {
		
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		title: {
			text: "카테고리별 게시글 수"
		},
		axisX: {
			interval: 1
		},
		axisY: {
			title: "",
			includeZero: true,
			scaleBreaks: {
				type: "wavy"
				}
		},
		data: [{
			type: "bar",
			toolTipContent: "<b>{label}</b><br>{count}개",
			dataPoints: [
				<c:forEach items="${bnameLists}" var="row">
					{ label: "${row.bname}", y: ${row.num }, count : ${row.num } },
				</c:forEach>
			]
		}]
	});
	chart.render();
	
	var chart2 = new CanvasJS.Chart("member", {
		animationEnabled: true,
		title: {
			text: "동네별 가입자 수"
		},
		axisX: {
			interval: 1
		},
		axisY: {
			title: "",
			includeZero: true,
			scaleBreaks: {
				type: "wavy"
				}
		},
		data: [{
			type: "bar",
			toolTipContent: "<b>{label}</b><br>{count}개",
			dataPoints: [
				<c:forEach items="${memberList }" var="row">
					{ label: "${row.addr }", y: ${row.cnt }, count : ${row.cnt } },
				</c:forEach>
			]
		}]
	});
	chart2.render();
	
	}
</script>

	<!-- Footer -->
	<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	<jsp:include page="../include/bottom.jsp" />
</body>
<!-- 

 -->
</html>
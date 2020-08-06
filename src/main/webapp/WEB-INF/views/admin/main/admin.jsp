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
									<h2 class="mb-0">카테고리별 게시글 수</h2>
								</div>
							</div>
						</div>
						<div class="card-body">
							<!-- Chart -->
							<div class="chart" style="width: 100%; overflow: auto;">
								<canvas id="myChart" class="chart-canvas" height="100%"></canvas>
							</div>
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
								<div class="col">
									<h3 class="mb-0">동네별 가입자 수</h3>
								</div>
								<div class="col text-right">
									<a href="#!" class="btn btn-sm btn-primary">See all</a>
								</div>
							</div>
						</div>
						<div class="table-responsive">
							<!-- Projects table -->
							<table class="table align-items-center table-flush">
								
								<thead class="thead-light">
									<tr>
										<th scope="col">순위</th>
										<th scope="col">이름</th>
										<th scope="col">가입자수</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row">/argon/</th>
										<td>4,569</td>
										<td>340</td>
									</tr>
								</tbody>
							</table>
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
// 우선 컨텍스트를 가져옵니다. 
var ctx = document.getElementById("myChart").getContext('2d');
/*
- Chart를 생성하면서, 
- ctx를 첫번째 argument로 넘겨주고, 
- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
*/
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [
        	<c:forEach items="${bnameLists}" var="row">
				'${row.bname }',
			</c:forEach>
		],
        datasets: [{
            label: '# of Votes',
            data: [
            	150, 320, 200, 155, 320, 280, 300, 140, 10, 240, 220, 310
            ],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 5
        }]
    },
    options: {
        maintainAspectRatio: false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>
	<!-- Footer -->
	<jsp:include page="../include/bottom.jsp" />
</body>
<!-- 
<c:forEach items="${bnameLists}" var="row">
					'${row.num }',
				</c:forEach>
 -->
</html>
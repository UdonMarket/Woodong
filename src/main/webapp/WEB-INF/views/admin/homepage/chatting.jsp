<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />
<body class="">
	<jsp:include page="../include/left.jsp" />
	<div class="main-content">
		<jsp:include page="../include/header.jsp" />
		<!-- End Navbar -->
		<!-- Header -->
		<div class="header bg-gradient-primary pb-8 pt-5 pt-md-5" style="height: 200px">
			<div class="container-fluid">
				<div class="header-body">
					<div style="text-align: center">
						<img src="../resources/admin/img/homepage.png" alt="" style="width: 200px;"/>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
		<%-- 뷰(View)영역 --%>
		<div class="text-center" style="float: right; margin-top: 30px" >
		
			<form class="form-inline" name="searchFrm"
				action="<c:url value="../admin/memberTable.woo"/>"
				style="margin-bottom: 10px;">

				<div class="form-group">
					<select name="searchField" class="form-control">
						<option value="id">아이디</option>
						<!-- <option value="">작성자</option>
							<option value="content">내용</option> -->
					</select>
				</div>
				<div class="input-group">
					<input type="text" name="searchTxt" class="form-control" />
					<div class="input-group-btn">
						<button type="submit" class="btn btn-warning"
							style="height: 40px;" value="검색">
							<i class='fa fa-search' style='font-size: 20px'></i>
						</button>
					</div>
				</div>
			</form>
		</div>

		<!-- 게시판리스트부분 -->
		<table class="table table-bordered table-hover table-striped" style="width: 100%;">
			<colgroup>
				<col width="20px" />
				<col width="*" />
				<col width="250px" />
				<col width="250px" />
				<col width="200px" />
			</colgroup>

			<thead>
				<tr style="background-color: rgb(133, 133, 133);"
					class="text-center text-white">
					<th><input type="checkbox" name="allCheck" /></th>
					<th class="text-center">제목</th>
					<th class="text-center">판매자</th>
					<th class="text-center">구매자</th>
					<th class="text-center">마지막 채팅</th> 
					<th class="text-center">금칙어 사용횟수</th> 
					

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${lists }" var="row">
					<tr>
						<td><input type="checkbox" name="choiceCheck" value="${row.chatroomidx }"/></td>
						
							<td class="text-center"><a href="../admin/chattingView.woo?chatroomidx=${row.chatroomidx }">${row.title }</a></td>
							<td class="text-center">${row.sellerid }</td>
							<td class="text-center">${row.buyerid }</td>
							<td class="text-center">${row.lastchatdate }</td>
							<td class="text-center">${row.prohiditioncount }</td>
						
					</tr>
				</c:forEach>
			</tbody>
			
		</table>
</div>
	
	<div style="text-align: center">
		<form:form name="editOrDelete">
			<input type="hidden" id="checkId" name="checkId"/>
		</form:form>
		<input type="button" id="allDelete" class="btn btn-danger" style="height: 20px; padding-top: 0px"  value="삭제" />
	</div>
	<!-- 방명록 반복 부분 e -->
	<ul class="pagination justify-content-center">${pagingImg }</ul>
	
	</div>
	</div>
	<!-- Footer -->
	<%-- <jsp:include page="../include/bottom.jsp" /> --%>
</body>
</html>

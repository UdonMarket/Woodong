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
						<img src="../resources/admin/img/멤버관리.png" alt="" style="width: 200px;"/>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
		<%-- 뷰(View)영역 --%>
		<!-- 게시판리스트부분 -->
		<table class="table table-bordered table-hover table-striped" style="width: 100%; margin-top: 50px;">
			<colgroup>
				<col width="20px" />
				<col width="100px" />
				<col width="*" />
				<col width="250px" />
			</colgroup>
			<thead>
				<tr style="background-color: rgb(133, 133, 133);"
					class="text-center text-white">
					<th class="text-center">순서</th>
					<th class="text-center">아이디</th>
					<th class="text-center">내용</th>
					<th class="text-center">채팅 시간</th> 

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${chatList }" var="row">
					<tr>
						<td class="text-center"><a href="../admin/chattingView.woo?chatroomidx">${row.chatroomidx }</a></td>
						<td class="text-center">${row.id }</td>
						<td class="text-center">${row.chatting }</td>
						<td class="text-center">${row.chatDate }</td>
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

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
		<div class="header bg-gradient-primary pb-8 pt-5 pt-md-5">
			<div class="container-fluid">
				<div class="header-body"></div>
			</div>
		</div>


		<%-- 뷰(View)영역 --%>
			<div class="text-center" style="float: right">
				<form class="form-inline" name="searchFrm" action="<c:url value="/admin/memberTable.woo"/>" style="margin-bottom: 10px;">
	
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
							<button type="submit" class="btn btn-warning" style="height: 40px;" value="검색">
								<i class='fa fa-search' style='font-size: 20px'></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		<!-- 게시판리스트부분 -->
		<table class="table table-bordered table-hover table-striped" style="width: 100%;">
			<colgroup>
				<col width="200px" />
				<col width="150px" />
				<col width="*" />
				<col width="120px" />
				<col width="30px" />
				<col width="30px" />
				<col width="30px" />
				<col width="30px" />
				<col width="30px" />
			</colgroup>

			<thead>
				<tr style="background-color: rgb(133, 133, 133);" class="text-center text-white">
					<th class="text-center">아이디</th>
					<th class="text-center">휴대폰번호</th>
					<th class="text-center">주소</th>
					<th class="text-center">가입일</th>
					<th class="text-center">평점</th>
					<th class="text-center">등급</th>
					<th class="text-center">거래횟수</th>
					<th class="text-center">수정버튼</th>
					<th class="text-center">삭제버튼</th>

				</tr>
			</thead>
			<tbody>
				<%-- 방명록 반복 부분 --%>
				<c:forEach items="${lists }" var="row">
					<tr>
						<td class="text-center">${row.id }</td>
						<td class="text-center">${row.mobile }</td>
						<td class="text-center">${row.addr }</td>
						<td class="text-center">${row.regidate }</td>
						<td class="text-center">${row.avg_score }</td>
						<td class="text-center">${row.grade }</td>
						<td class="text-center">${row.trade_count }</td>
						<td class="text-center">
							<input type="button" class="btn btn-primary" value="수정" /></td>
						<td class="text-center">
							<form:form name="deleteFrm">
								<button class="btn btn-danger" onclick="isDelete(this.form);">삭제</button>
								<input type="hid den" name="delete" value="${row.id }"/>
							</form:form>
						</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>

	</div>
	<script>
		function isDelete(frm) {
			var c = confirm("삭제할까요?");
			if (c) {
				frm.method = "post";
				frm.action = "../admin/delete.woo";
				frm.submit();
			}
		}
	</script>

	<!-- 방명록 반복 부분 e -->
	<ul class="pagination justify-content-center">${pagingImg }</ul>
</div>
<!-- Footer -->
<%-- <jsp:include page="../include/bottom.jsp" /> --%>
</body>
</html>

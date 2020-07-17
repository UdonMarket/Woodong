<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />

<head>

</head>

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
		<div class="container">
			<!-- <h3 class="text-center">회원리스트</h3> -->

			<%--검색부분 --%>
			<%-- <div class="text-center">
			<form name="searchFrm" method="get"
				onsubmit="return writeValidate(this);"
				action="<c:url value="/admin/memberTable.woo" />">

				<select name="searchField">
					<option value="id">아이디</option>
				</select> <input type="text" name="searchTxt" /> <input type="submit"
					value="검색" />
			</form>
		</div> --%>
			<div class="text-center" style="margin-left: 350px;">
				<form class="form-inline ml-auto" name="searchFrm"
					action="<c:url value="/admin/memberTable.woo"/>"
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

			<div class="row">
				<!-- 게시판리스트부분 -->
				<table class="table table-bordered table-hover table-striped"
					style="width: 3500px; height: 300px;">
					<colgroup>
						<col width="100px" />
						<col width="100px" />
						<col width="120px" />
						<col width="150px" />
						<col width="60px" />
						<col width="*" />
						<col width="10px" />
						<col width="100px" />
					</colgroup>

					<thead>
						<tr style="background-color: rgb(133, 133, 133);"
							class="text-center text-white">
							<th class="text-center">아이디</th>
							<th class="text-left">패스워드</th>
							<th class="text-center">작성일</th>
							<th class="text-center">휴대번호</th>
							<th class="text-center">평점</th>
							<th class="text-center">주소</th>
							<th class="text-center">등급</th>
							<th class="text-center">거래횟수</th>
							<th class="text-center">수정버튼</th>
							<th class="text-center">삭제버튼</th>

						</tr>
					</thead>
					</div>
					<tbody>
						<%-- 방명록 반복 부분 --%>
						<c:forEach items="${lists }" var="row">
							<div class="border mt-2 mb-2">
								<div class="media">
									<div class="media-body">
										<tr>
											<td class="text-center">${row.id }</td>
											<td class="text-center">${row.pass }</td>
											<td class="text-center">${row.regidate }</td>
											<td class="text-center">${row.mobile }</td>
											<td class="text-center">${row.avg_score }</td>
											<td class="text-center">${row.addr }</td>
											<td class="text-center">${row.grade }</td>
											<td class="text-center">${row.trade_count }</td>

											<td class="text-center"><input type="button"
												class="btn btn-primary" value="수정" /></td>
											<!-- <td class="text-center"><input type="button"
												class="btn btn-danger" id="delete btn" value="삭제"
												onclick="isDelete(this.form);" /></td> -->

											<td class="text-center">
												<form:form name="deleteFrm">
													<button class="btn btn-danger"
														onclick="isDelete(this.form);">삭제</button>
												<input type="hid den" name="delete" value="${row.id }"/>
												</form:form>
											</td>
										</tr>

									</div>
								</div>
							</div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />
<script>
	$(window).ready(function() {
		$('#locationname').val($('#location option:checked').text());
	})
	$(function() {
		$('#location').change(function() {
			$('#locationname').val($('#location option:checked').text());
		})
	})
</script>
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
		<div style="margin-top:20px;margin-left:20px; padding: 20px; width:400px; border: 1px gray solid;" >
			<form:form action="../admin/addBoardAction.woo">
				<input type="hidden" name="requestname" />
				<input type="hidden" name="boardorder" />
				<input type="hidden" id="locationname" name="locationname"/>
				<input type="hidden" name="type" />
				<table>
					<tr>
						<td>게시판 이름 : </td>
						<td>
							<input type="text" name="bname" style="width: 150px"/>
						</td>
					</tr>
					<tr>
						<td>게시판 위치 : </td>
						<td>
							<select id="location" name="location">
								<option value="../product/productList.woo">카테고리</option>
								<option value="../community/community.woo">커뮤니티</option>
							</select>
						</td>
					</tr>
					<tr align="right">
						<td colspan="2">
							<input type="submit" value="게시판생성" />
						</td>
					</tr>
				</table>
			</form:form>
		</div>
			<div class="text-center" style="float: right">
				<form class="form-inline" name="searchFrm" action="<c:url value="/admin/memberTable.woo"/>" style="margin-bottom: 10px;">
	
					<div class="form-group">
						<select name="searchField" class="form-control">
							<option value="blocation">위치</option>
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
		<table class="table table-bordered table-hover table-striped" style="width: 100%;">
			<colgroup>
				<col width="50px" />
				<col width="100" />
				<col width="*" />
				<col width="30px" />
			</colgroup>

			<thead>
				<tr style="background-color: rgb(133, 133, 133);" class="text-center text-white">
					<th class="text-center">순서</th>
					<th class="text-center">위치</th>
					<th class="text-center">이름</th>
					<th class="text-center">유형</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${blists }" var="row">
					<tr>
						<td class="text-center">${row.boardorder }</td>
						<td class="text-center">${row.location }</td>
						<td class="text-center">${row.bname }</td>
						<td class="text-center">${row.requestname }</td>
					</tr>

				</c:forEach>
			</tbody>
		</table>
		<!-- Footer -->
		<jsp:include page="../include/bottom.jsp" />
</body>

</html>
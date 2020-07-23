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
		$('select[name=location]').each(function(index, item) {
			if(index!=0){
				$(item).val($('input[name=loc]:eq(' + (index-1) + ')').val()).prop("selected", true);
			}
		});
		$('select[name=type]').each(function(index, item) {
			$(item).val($('input[name=ty]:eq(' + (index) + ')').val()).prop("selected", true);
		});
		
		$('select[name=boardorder]').each(function(index, item) {
			$(item).val($('input[name=bo]:eq(' + (index) + ')').val()).prop("selected", true);
		});
		
	})
	$(function() {
		$('#location').change(function() {
			$('#locationname').val($('#location option:checked').text());
		});
		$('select[name=location]').change(function() {
			$('select[name=location]').each(function(index, item) {
				$('input[name=locationname]:eq(' + (index) + ')').val($(item).find("option:checked").text());
			});
		});
	});

	function deleteBoard(f) {
		if(confirm("삭제하시겠습니까?")){
			f.action="../admin/deleteBoard.woo";
			f.submit();
		}
	}

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
		<div class="container">
			<div style="margin-top:20px;margin-left:20px; padding: 20px; width:400px; border: 1px gray solid;" >
				<form:form action="../admin/addBoardAction.woo" method="post">
					<input type="hidden" name="idx" />
					<input type="hidden" name="requestname" />
					<input type="hidden" id="locationname" name="locationname"/>
					<input type="hidden" name="type" />
					<input type="hidden" name="boardorder" value="0"/>
					<table>
						<tr>
							<td>게시판 이름 : </td>
							<td>
								<input type="text" name="bname" style="width: 150px" required/>
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
		
		
		<div style="margin-top : 20px">
			<table class="table table-bordered table-hover table-striped">
				<colgroup>
					<col width="100px" />
					<col width="200px" />
					<col width="*" />
					<col width="200px" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
	
				<thead>
					<tr style="background-color: rgb(133, 133, 133);" class="text-center text-white">
						<th class="text-center">순서</th>
						<th class="text-center">위치</th>
						<th class="text-center">이름</th>
						<th class="text-center">유형</th>
						<th class="text-center">수정</th>
						<th class="text-center">삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${blists }" var="row" varStatus="index">
						<input type="hidden" name="loc" value="${row.location }"/>
						<input type="hidden" name="ty" value="${row.type }"/>
						<input type="hidden" name="bo" value="${row.boardorder }"/>
						<form:form action="../admin/editBoard.woo" method="post">
							<input type="hidden" name="idx" value="${row.idx }"/>
							<input type="hidden" name="requestname" value="${row.requestname }"/>
							<input type="hidden" name="locationname" value="${row.locationname }"/>
							<tr>
								<td class="text-center">
									<select name="boardorder" id="">
									<c:forEach items="${locationOrder }" var="end">
										<<c:if test="${end.LOCATIONNAME eq row.locationname }">
											<c:forEach begin="1" end="${end.C }" varStatus="status">
												<option value="${status.count }">${status.count }</option>
											</c:forEach>
										</c:if>
									</c:forEach>
									</select>
								</td>
								<td class="text-center">
									<select name="location">
										<option value="../product/productList.woo">카테고리</option>
										<option value="../community/community.woo">커뮤니티</option>
									</select>
								</td>
								<td class="text-center">
									<input type="text" name="bname" value="${row.bname }" required/>
								</td>
								<td class="text-center">
									<select name="type">
										<option value="commonboard">일반게시판</option>
										<option value="photoboard">사진게시판</option>
									</select>
								</td>
								<td class="text-center">
									<input type="submit" class="btn btn-primary" style="height: 20px; padding-top: 0px" value="수정" />
								</td>
								<td class="text-center">
									<input type="button" class="btn btn-danger" style="height: 20px; padding-top: 0px " value="삭제" onclick="deleteBoard(this.form);" />
								</td>
							</tr>
						</form:form>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
		<!-- Footer -->
		<jsp:include page="../include/bottom.jsp" />
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />
<script>
	/* 체크박스 전체 선택 */
	$(function() {

		$(':checkbox[name=allCheck]').click(function() {

			if ($('input:checkbox[name=allCheck]').is(':checked') == true) {
				$('[name=choiceCheck]').each(function() {
					$(this).attr({
						'checked' : true
					});
				})
			} else {
				$(':checkbox[name=choiceCheck]').each(function() {
					$(':checkbox[name=choiceCheck]').attr({
						'checked' : false
					});
				})
			}
		});
		
		$('#allDelete').click(function() {
			var checkStr = '';
			$('[name=choiceCheck]').each(function() {
				if($(this).is(':checked')==true){
					checkStr += $(this).val() + '//';
				}
			})
			$('#checkBoardIdxList').val(checkStr);
			if(confirm('삭제하시겠습니까?') && $('#checkBoardIdxList').val()!=''){
				$('[name=editOrDelete]').attr('action', '../admin/boardDelete.woo');
				$('[name=editOrDelete]').submit();
			}
		});
	});
	
	function isDelete(idx) {
		var checkStr = idx;
		$('#checkBoardIdxList').val(checkStr + '//');
		if(confirm('삭제하시겠습니까?') && $('#checkBoardIdxList').val()!=''){
			$('[name=editOrDelete]').attr('action', '../admin/boardDelete.woo');
			$('[name=editOrDelete]').submit();
		}
	}
</script>
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
						<img src="../resources/admin/img/게시판 관리.png" alt="" style="width: 200px;"/>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
		<%-- 뷰(View)영역 --%>
		<div class="text-center" style="float: right; margin-top: 30px" >
		
			<form class="form-inline" name="searchFrm"
				action="<c:url value="../admin/boardTable.woo"/>"
				style="margin-bottom: 10px;">
				<input type="hidden" name="mode" value="${param.mode }" />
				<div class="form-group">
					<select name="searchField" class="form-control">
						<option value="title">제목</option>
						<option value="id">작성자</option>
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
				<col width="50px" />
				<col width="50px" />
				<col width="*" />
				<c:if test="${param.mode eq 'product'}">
				<col width="100px" />
				<col width="50px" />
				<col width="150px" />
				<col width="150px" />
				</c:if>
				<col width="100px" />
				<col width="30px" />
			</colgroup>

			<thead>
				<tr style="background-color: rgb(133, 133, 133);"
					class="text-center text-white">
					<th><input type="checkbox" name="allCheck" /></th>
					<th class="text-center">NO</th>
					<th class="text-center">제목</th>
					<c:if test="${param.mode eq 'product'}">
					<th class="text-center">가격</th>
					<th class="text-center">판매상태</th>
					<th class="text-center">작성자</th>
					<th class="text-center">구매자</th>
					</c:if>
					<th class="text-center">작성일</th>
					<th class="text-center">삭제버튼</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${lists }" var="row">
					<tr>
						<td><input type="checkbox" name="choiceCheck" value="${row.boardidx }"/></td>
						<td class="text-center">${row.vNum }</td>
						<td class="text-center"><a href="../admin/boardView.woo?mode=${param.mode }&boardidx=${row.boardidx }">${row.title }</a></td>
						<c:if test="${param.mode eq 'product'}">
						<td class="text-center">${row.price }</td>
						<td class="text-center">${row.deal_type }</td>
						<td class="text-center">${row.id }</td>
						<td class="text-center">${row.buyer_id }</td>
						</c:if>
						<td class="text-center">${row.postdate }</td>
						<td class="text-center">
							<button class="btn btn-danger" style="height: 20px; padding-top: 0px"  onclick="isDelete(${row.boardidx});">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div style="text-align: center">
		<c:if test="${param.mode eq 'community' }">
			<div style="display: inline-block;">
				<input type="button" class="btn btn-info" value="글쓰기" style="height: 20px; width: 80px; padding-top: 0px"  onclick="location.href='../admin/boardWrite.woo'" />
			</div>
		</c:if>
		<div style="display: inline-block;">
			<form:form name="editOrDelete" method="post">
				<input type="hidden" name="mode" value="${param.mode }" />
				<input type="hid-den" id="checkBoardIdxList" name="checkBoardIdxList"/>
			</form:form>
			<input type="button" id="allDelete" class="btn btn-danger" style="height: 20px; width: 80px; padding-top: 0px"  value="삭제" />
		</div>
	</div>
	<!-- 방명록 반복 부분 e -->
	<ul class="pagination justify-content-center">${pagingImg }</ul>
	
	</div>
	</div>
	<!-- Footer -->
	<%-- <jsp:include page="../include/bottom.jsp" /> --%>
</body>
</html>

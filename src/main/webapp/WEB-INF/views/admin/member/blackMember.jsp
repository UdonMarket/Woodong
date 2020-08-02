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
			$('#checkId').val(checkStr);
			if(confirm('삭제하시겠습니까?') && $('#checkId').val()!=''){
				$('[name=editOrDelete]').attr('action', '../admin/memberDelete.woo');
				$('[name=editOrDelete]').submit();
			}
		});
	});
	
	function isDelete(id) {
		var checkStr = id;
		$('#checkId').val(checkStr + "//");
		if(confirm('삭제하시겠습니까?') && $('#checkId').val()!=''){
			$('[name=editOrDelete]').attr('action', '../admin/memberDelete.woo');
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
						<img src="../resources/admin/img/멤버관리.png" alt="" style="width: 200px;"/>
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
				<col width="50px" />
				<col width="150px" />
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
				<tr style="background-color: rgb(133, 133, 133);"
					class="text-center text-white">
					<th><input type="checkbox" name="allCheck" /></th>
					<th class="text-center">아이디</th>
					<th class="text-center">휴대폰번호</th>
					<th class="text-center">주소</th>
					<th class="text-center">가입일</th>
					<c:if test="${param.grade eq 'normal' }">
						<th class="text-center">평점</th>
						<th class="text-center">등급</th>
						<th class="text-center">거래횟수</th>
					</c:if>
					<th class="text-center">수정버튼</th>
					<th class="text-center">삭제버튼</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${lists }" var="row">
					<tr>
						<td><input type="checkbox" name="choiceCheck" value="${row.id }"/></td>
						<td class="text-center">${row.id }</td>
						<td class="text-center">${row.mobile }</td>
						<td class="text-center">${row.addr }</td>
						<td class="text-center">${row.regidate }</td>
						<c:if test="${param.grade eq 'normal' }">
							<td class="text-center">${row.avg_score }</td>
							<td class="text-center">${row.grade }</td>
							<td class="text-center">${row.trade_count }</td>
						</c:if>
						<td class="text-center">
							<form:form action="../admin/edit.woo">
								<input type="hidden" name="id" value="${row.id }" />
								<input type="hidden" name="grade" value="${grade }" />
								<select name="editgrade">
									<option value="admin">관리자</option>
									<option value="normal">회원</option>
								</select>
							<input type="submit" class="btn btn-primary" style="height: 20px; padding-top: 0px"  value="수정" />
							</form:form>
						</td>
						<td class="text-center">
							<button class="btn btn-danger" style="height: 20px; padding-top: 0px"  onclick="isDelete(${row.id });">삭제</button>
					</tr>
				</c:forEach>
			</tbody>
			
		</table>
</div>
	
	<div style="text-align: center">
		<form:form name="editOrDelete">
			<input type="hidden" name="grade" value="${grade }" />
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

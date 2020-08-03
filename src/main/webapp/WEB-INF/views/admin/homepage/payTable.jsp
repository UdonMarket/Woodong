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
				$('[name=editOrDelete]').attr('action', '../admin/payDelete.woo');
				$('[name=editOrDelete]').submit();
			}
		});
	});
	
	function isDelete(idx) {
		var checkStr = idx;
		$('#checkBoardIdxList').val(checkStr + '//');
		if(confirm('삭제하시겠습니까?') && $('#checkBoardIdxList').val()!=''){
			$('[name=editOrDelete]').attr('action', '../admin/payDelete.woo');
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
				action="<c:url value="../admin/payTable.woo"/>"
				style="margin-bottom: 10px;">
				<div class="form-group">
					<select name="searchField" class="form-control">
						<option value="MERCHANT_UID">거래고유번호</option>
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
				<col width="100px" />
				<col width="50px" />
				<col width="50px" />
				<col width="100px" />
				<col width="100px" />
				<col width="50px" />
				<col width="50px" />
			</colgroup>

			<thead>
				<tr style="background-color: rgb(133, 133, 133);"
					class="text-center text-white">
					<th><input type="checkbox" name="allCheck" /></th>
					<th class="text-center">NO</th>
					<th class="text-center">거래고유번호</th>
					<th class="text-center">상품제목</th>
					<th class="text-center">가격</th>
					<th class="text-center">결제일</th>
					<th class="text-center">게시판번호</th>
					<th class="text-center">구매자ID</th>
					<th class="text-center">판매자ID</th>
					<th class="text-center">상품상태</th>
					<th class="text-center">결제방법</th>
					<th class="text-center">삭제버튼</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${lists }" var="row">
					<tr>
						<td><input type="checkbox" name="choiceCheck" value="${row.pay_idx }"/></td>
						<td class="text-center">${row.pay_idx }</td>
						<td class="text-center">${row.merchant_uid }</td>
						<td class="text-center"><a href="../admin/boardView.woo?boardidx=${row.board_idx }">${row.product_name }</a></td>
						<td class="text-center">${row.product_price }</td>
						<td class="text-center">${row.paydate }</td>
						<td class="text-center">${row.board_idx }</td>
						<td class="text-center">${row.buyer_id }</td>
						<td class="text-center">${row.seller_id }</td>
						<td class="text-center">${row.status }</td>
						<td class="text-center">${row.pay_method }</td>
						<td class="text-center">
							<button class="btn btn-danger" style="height: 20px; padding-top: 0px"  onclick="isDelete(${row.pay_idx});">삭제</button>
						</td>
					</tr> 
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div style="text-align: center">
		<div style="display: inline-block;">
			<form:form name="editOrDelete" method="post">
				<input type="hidden" name="mode" value="${param.mode }" />
				<input type="hidden" id="checkBoardIdxList" name="checkBoardIdxList"/>
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

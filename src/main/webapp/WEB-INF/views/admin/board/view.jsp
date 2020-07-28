<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />
<script>
	function editBoard() {
		var f = document.getElementById("frm");
		f.action="../admin/boardEdit.woo";
		f.submit();
	}
	
	function deleteBoard() {
		if(confirm("삭제하시겠습니까?")){
			var f = document.getElementById("frm");
			f.checkBoardIdxList.value = f.checkBoardIdxList.value + '//';
			f.action="../admin/boardDelete.woo";
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

		
		<article>

		<div class="container" role="main" style="margin-top: 50px;">

			<h2>상세보기</h2>
				<div class="row">
				<c:if test="${mode eq 'product' }">
					<div class="col-8">
				</c:if>
				<c:if test="${mode eq 'community' }">
					<div class="col-12">
				</c:if>
						<div class="row">
							<div class="col-6">
								<label for="title">작성자</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.id }">
							</div>
							<div class="col-6">
								<label for="title">위치</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
							</div>
						</div>
						<c:if test="${mode eq 'product' }">
							<div class="row">
								<div class="col-6">
									<label for="title">가격</label>
									<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
								</div>
								<div class="col-6">
									<label for="title">거래장소</label>
									<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
								</div>
							</div>
						</c:if>
						<div class="row">
							<div class="col-12">
								<label for="title">제목</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.title }">
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<label for="contents">내용</label>
								<textarea class="form-control" rows="15" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;">${wooBoardVO.contents }</textarea>
							</div>
						</div>
					</div>
					<c:if test="${mode eq 'product' }">
					<div class="col-4">
						<div class="row">
							<div class="col-4">
							<label for="title">우동페이</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold;" class="form-control" value="${wooBoardVO.woopay }">
							</div>
							
							<div class="col-4">
							<label for="title">판매상태</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold;" class="form-control" value="${wooBoardVO.deal_type }">
							</div>
							<div class="col-4">
							<label for="title">상품상태</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold;" class="form-control" value="${wooBoardVO.product_state }">
							</div>
							<div class="col-4">
								<label for="title">좋아요</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
							</div>
							
							<div class="col-4">
								<label for="title">채팅</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
							</div>
							<div class="col-4">
								<label for="title">방문자</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
							</div>
							<div class="col-12">
								<label for="title">태그</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
							</div>
							<div class="col-12">
								<label for="title">구매자아이디</label>
								<input type="text" readonly="readonly" style="background-color: white; font-weight: bold; font-size: 15px;" class="form-control" value="${wooBoardVO.bname }">
							</div>
						</div>
					</div>
					</c:if>
				</div>
				<div class="row">
					<div class="col-12">
						<c:if test="${mode eq 'community' }">
							<button type="button" class="btn btn-sm btn-primary" onclick="editBoard();">수정</button>
						</c:if>
						<button type="button" class="btn btn-sm btn-primary" onclick="deleteBoard();">삭제</button>
					</div>
				</div>
		</div>

	</article>
	<form:form id="frm" method="post">
		<input type="hidden" name="checkBoardIdxList" value="${wooBoardVO.boardidx }" />
		<input type="hidden" name="mode" value="${mode }" />
	</form:form>
	</div>
	</div>
	</div>
	<!-- Footer -->
	<%-- <jsp:include page="../include/bottom.jsp" /> --%>
</body>
</html>

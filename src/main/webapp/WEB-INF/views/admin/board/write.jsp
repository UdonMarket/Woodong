<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../include/head.jsp" />
<script>
	function check(f) {
		if(!f.title.value.trim()){
			alert("제목을 입력해주세요");
			return false;
		}
		if(!f.contents.value.trim()){
			alert("내용을 입력해주세요");
			return false;
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

			<h2>글쓰기</h2>

			<form:form name="form" id="form" role="form" method="post" action="../admin/boardWriteAction.woo" onsubmit="return check(this)">

				<div class="form-group mb-3">
					<label for="bname">위치</label>
					<select class="form-control" id="bname" name="bname">
						<c:forEach items="${lists }" var="row">
							<option value="${row.bname }">${row.bname }</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="mb-3">

					<label for="title">제목</label>

					<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요" required="required">

				</div>

				<div class="mb-3">

					<label for="contents">내용</label>

					<textarea class="form-control" rows="15" name="contents" id="content" placeholder="내용을 입력해 주세요" required="required"></textarea>

				</div>
				<div >
	
					<button type="submit" class="btn btn-sm btn-primary" id="btnSave">저장</button>
	
					<button type="button" class="btn btn-sm btn-primary" id="btnList" onclick="location.href='../admin/boardTable.woo?mode=community'">목록</button>
	
				</div>

			</form:form>


		</div>

	</article>

	</div>
	</div>
	</div>
	<!-- Footer -->
	<%-- <jsp:include page="../include/bottom.jsp" /> --%>
</body>
</html>

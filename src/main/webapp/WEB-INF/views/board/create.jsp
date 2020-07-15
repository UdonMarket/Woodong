<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<form action="../board/create.woo">
			<input type="hidden" name="requestname" />
			<input type="hidden" name="border" />
			<div class="row">
				<div class="col-3">게시판 이름</div>
				<div class="col-9">
					<input type="text" name="bname" id="" />
				</div>
			</div>
			<div class="row">
				<div class="col-3">게시판 위치</div>
				<div class="col-9">
					<select name="blocation">
						<option value="../product/productList.woo">상품게시판</option>
						<option value="../community/community.woo">커뮤니티</option>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<input type="image" src="../resources/img/120ben.jpg" alt="" />
				</div>
			</div>
			
		</form>
	</div>
</body>
</html>
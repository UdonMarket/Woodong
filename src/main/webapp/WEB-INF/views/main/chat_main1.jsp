<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동톡톡</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="icon" href="../resources/img/main/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">

<body>
<div class="continer" id="chat-wrapper" style="border: 2px solid #d9d9d9;width: 400px;height: 535px;margin: 30px;">
	<header id="chat-header" style="text-align: center;">
		<img src="../resources/img/main/favicon.png" alt="우동톡톡" style="width: 50px;" />
		<span style="font-size: 1.2em;font-weight: bold;padding: 5px;">우동톡톡</span>
	</header>		
	<input type="hidden" id="chat_id" value="${param.chat_id }" style="border:1px dotted red;" />
	<input type="hidden" id="chat_room" value="${param.chat_room }" style="border:1px dotted red;" />
	<ul id="channel-list" class="">
		<li>
			<a href="javascript:void(0);" onclick="window.open('../main/chatting.woo', '_blank', 'height=600; width=480; top=200; left=700;', true);"> 
				<div class="catting_room row">
					<div class="col-3" style="text-align: left;">
						<img src="../resources/img/myPage/nor-blue.png" alt="" width="50px;"/>
					</div>
					<div class="col-6">
						<div style="text-align: left;font-size: 1.4em;font-weight: bold;">우동이</div>
						<div style="text-align: left;font-size: 1em;padding-top: 5px;">안녕하세요.</div>
					</div>
				</div>
			</a>
		</li>
		
	</ul>
</div>
</body>
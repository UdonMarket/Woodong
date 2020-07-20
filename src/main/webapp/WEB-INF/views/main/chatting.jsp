<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동톡톡</title>

<link rel="icon" href="../resources/img/main/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script>
	$(function() {
		$('#sendBtn').click(function() {
			sendMessage();
			$('#inputMessage').val('');
		});
		let sock = new SockJS("http://localhost:8282/woodong/echo");
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		
		// 메시지 전송
		function sendMessage() {
			sock.send($("#inputMessage").val());
			$('#inputMessage').val("");
		}
		// 서버로부터 메시지를 받았을 때
		function onMessage(msg) {
			var data = msg.data;
			$("#chat-container").append(data + "<br/>");
		}
		// 서버와 연결을 끊었을 때
		function onClose(evt) {
			$("#chat-container").append("연결 끊김");

		}
		$("#inputMessage").keyup(function(key){
			if(key.keyCode==13){
				sendMessage();
			}
		});
	});
	
	
	/* function enterkey(){
		
		if(window.event.keyCode==13){
			alert("22222");
			sendMessage();
		}
	} */

</script>

</head>
<body>
	<div id="chat-wrapper" style="border: 2px solid #d9d9d9;">
		<header id="chat-header" style="text-align: center;">
			<img src="../resources/img/main/favicon.png" alt="우동톡톡" style="width: 50px;" />
			<span style="font-size: 1.2em;font-weight: bold;padding: 5px;">우동톡톡 - 판매자와 채팅을 시작하세요.</span>
		</header>		
		<input type="hidden" id="chat_id" value="${param.chat_id }" style="border:1px dotted red;" />
		<input type="hidden" id="chat_room" value="${param.chat_room }" style="border:1px dotted red;" />
		<div id="chat-container" class="chat-area" style="height:340px;width:350px; overflow:auto;">
		
		</div>
		<footer id="chat-footer">
			<p class="text-area">
				<input type="text" id="inputMessage" style="width:310px; height:60px; font-size:1.5em; border:0px;" placeholder="개인정보 공유를 주의바랍니다" autofocus/>
				<button type="button" id="sendBtn">보내기</button>
				
			</p>
		</footer>
	</div>
</body>
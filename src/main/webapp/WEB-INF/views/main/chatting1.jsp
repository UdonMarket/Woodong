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
 
<script>
var messageWindow;
var inputMessage;
var chat_id, chat_room;//채팅아이디, 채팅방 전역변수 선언
var webSocket;

window.onload = function(){
	messageWindow = document.getElementById("chat-container");
	messageWindow.scrollTop = messageWindow.scrollHeight;
	inputMessage = document.getElementById('inputMessage');
	
	chat_id = document.getElementById('chat_id').value;
	chat_room = document.getElementById('chat_room').value;
	
	webSocket = new WebSocket('ws://localhost:8282/K07JSPServlet/ChatServer02');
	webSocket.onopen = function(event){
		wsOpen(event);
	};
	//메세지가 전송될때
	webSocket.onmessage = function(event){
		wsMessage(event);
	};
	//웹소켓이 닫혔을때
	webSocket.onclose = function(event){
		wsClose(event);
	};
	//에러가 발생했을때
	webSocket.onerror = function(event){
		wsError(event);
	};
}
	function wsOpen(event){
		messageWindow.value += "연결성공\n";
	}
	
	//서버로 부터 Echo된 메세지를 클라이언트에서 출력
	function wsMessage(event){
		//메세지 내용을 파이프로 split해서 배열로 만든다.
		var message = event.data.split("|");
		
		var room = message[0];//0번방 : 룸정보
		var sender = message[1];//1번방 : 아이디(대회명)
		var content = message[2];//2번방 : 메세지
		
		if(content==""){
		}
		else{
			//같은룸에 있는 클라이언트에게만 메세지를 디스플레이한다.
			if(chat_room==room){
				if(content.match("/")){
					if(content.match(("/"+chat_id))){
						var temp = content.replace(("/"+chat_id),"[귓속말] :");
						msg = makeBalloon(sender, temp);
						messageWindow.innerHTML += msg;
						messageWindow.scrollTop = messageWindow.scrollHeight;
	
					}
				}
				else{
					msg = makeBalloon(sender, content);
					messageWindow.innerHTML += msg;
					messageWindow.scrollTop = messageWindow.scrollHeight;
				}
			}
		}
	}
	
	function makeBalloon(id, cont){
		var msg = '';
		msg += '<div class="chat chat-left">';
		msg += '	<!--프로필 이미지 -->';
		msg += '	<span class= "profile profile-img-b"></span>';
		msg += '	<div class="chat-box">';
		msg += '		<p style = "font-weight:bold;font-size:1.1em;margin-bottom:5px;">'+id+'</p>';
		msg += '		<p class="bubble">'+cont+'</p>';
		msg += '		<span class="bubble-tail"></span>';
		msg += '	</div>';
		msg += '</div>';
		return msg;
	}
	function wsClosse(event){
		messageWindow.value += "연결끊기\n";
	}
	function wsError(event){
		alert(event.data);
	}
	//웹소켓 서버에 메세지를 보낸다.
	function sendMessage(){
		//메세지 입력후 전송할때 "채팅방+아이디+메세지" 형태로 조립해서 보낸다.
		webSocket.send(chat_room+'|'+chat_id+'|'+inputMessage.value);
		
		var msg ='';
		msg += '<div class="chat chat-right">';
		msg += '	<!--프로필 이미지 -->';
		msg += '	<span class= "profile profile-img-a"></span>';
		msg += '	<div class="chat-box">';
		msg += '		<p class="bubble-me">'+inputMessage.value+'</p>';
		msg += '		<span class="bubble-tail"></span>';
		msg += '	</div>';
		msg += '</div>';
		
		messageWindow.innerHTML += msg;
		inputMessage.value = "";
		
		messageWindow.scrollTop = messageWindow.scrollHeight;
	}
	function enterkey(){
		if(window.event.keyCode==13){
			sendMessage();
		}
	}

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
				<input type="text" id="inputMessage" onkeyup="enterkey();"
					style="width:310px; height:60px; font-size:1.5em; border:0px;"placeholder="개인정보 공유를 주의바랍니다" autofocus/>
				<button type="button" onclick="sendMessage();">보내기</button>
			</p>
		</footer>
	</div>
</body>
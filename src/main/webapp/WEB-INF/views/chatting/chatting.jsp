<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동톡톡</title>

<link rel="icon" href="../resources/img/main/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	
	$(function() {
		
		$("#chat-container").scrollTop($('#chat-container')[0].scrollHeight);
		
		$('#sendBtn').click(function() {
			sendMessage();
			$('#inputMessage').val('');
		});
		let sock = new SockJS("http://192.168.219.142:8282/woodong/echo");
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		sock.onerror = onError;
		
		// 메시지 전송
		function sendMessage() {
			sock.send(${id} + "//" + $("#inputMessage").val());
			saveMessageDB($("#inputMessage").val());
			var msg ='';
			msg += '<div class="chat chat-right">';
			msg += '	<div class="chat-box">';
			msg += '		<p class="bubble-me">'+$("#inputMessage").val()+'</p>';
			msg += '		<span class="bubble-tail"></span>';
			msg += '	</div>';
			msg += '</div>';
			$("#chat-container").append(msg);
			$('#inputMessage').val("");
			$("#chat-container").scrollTop($('#chat-container')[0].scrollHeight);
			
		}
		// 서버로부터 메시지를 받았을 때
		function onMessage(event) {
			var data = event.data;
			
			var id = data.split("//")[0];
			var message = data.split("//")[1];
			
			var msg = '';
			msg += '<div class="chat chat-left">';
			msg += '	<div class="chat-box">';
			msg += '		<p style = "font-weight:bold;font-size:1.1em;margin-bottom:5px;">'+id+'</p>';
			msg += '		<p class="bubble">'+message+'</p>';
			msg += '		<span class="bubble-tail"></span>';
			msg += '	</div>';
			msg += '</div>';
			
			$("#chat-container").append(msg + "<br/>");
			$("#chat-container").scrollTop($('#chat-container')[0].scrollHeight);
		}
		// 서버와 연결을 끊었을 때
		function onClose(evt) {
			$("#chat-container").append("연결 끊김");
			$("#chat-container").scrollTop($('#chat-container')[0].scrollHeight);
		}
		function onError(evt){
			alert("error : " + evt);
		}
		
		$("#inputMessage").keyup(function(key){
			if(key.keyCode==13){
				sendMessage();
			}
		});
	});
	
	function saveMessageDB(msg){
		$.ajax({
			url : "../chatting/saveMessageDB.woo",
			type:"get",
		    contentType:"text/html;charset:utf-8",
		    data:{chatting : msg, chatroomidx : ${chatroomidx }, id : ${id }},
		    dataType : "json" ,
	 	  	success : function(d) {
			},
			error : function(request,status,error) {
		    }
		});
	}
	
	
	/* function enterkey(){
		
		if(window.event.keyCode==13){
			alert("22222");
			sendMessage();
		}
	} */

</script>

<script>
	$(function() {
		$("input:radio").checkboxradio({
			icon:false
		});
	});
</script>
</head>
<body>
	<div id="chat-wrapper" style="border: 2px solid #d9d9d9;">
		<header id="chat-header" style="text-align: center;">
			<img src="../resources/img/main/favicon.png" alt="우동톡톡" style="width: 50px;" />
			<span style="font-size: 1.2em;font-weight: bold;padding: 5px;">우동톡톡 - 우동이에게 물어보세요</span>
		</header>	
		
		
		<div id="chat-container" class="chat-area" style="height:340px;width:350px; overflow-x:hidden; overflow-y:auto;">
		<c:if test="${not empty chatList }">
			<c:forEach items="${chatList}" var="row">
				<c:if test="${userid eq row.id}">
					<div class="chat chat-right">
						<div class="chat-box">
							<p class="bubble-me">${row.chatting }</p>
							<span class="bubble-tail"></span>
						</div>
					</div>
				</c:if>
				<c:if test="${userid ne row.id}">
					<div class="chat chat-left">
						<div class="chat-box">
							<p style = "font-weight:bold;font-size:1.1em;margin-bottom:5px;">${row.id }</p>
							<p class="bubble">${row.chatting }</p>
							<span class="bubble-tail"></span>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</c:if>
		</div>
		
		<footer id="chat-footer">
		<div style="text-align: right;">
		    <label for="radio-1">판매전</label>
		    <input type="radio" name="radio-1" id="radio-1">
		    <label for="radio-2">판매중</label>
		    <input type="radio" name="radio-1" id="radio-2">
		    <label for="radio-3">판매완료</label>
		    <input type="radio" name="radio-1" id="radio-3">
		</div>
			<p class="text-area">
				<input type="text" id="inputMessage" style="width:310px; height:60px; font-size:1.5em; border:0px;" placeholder="개인정보 공유를 주의바랍니다" autofocus/>
				<button type="button" id="sendBtn">보내기</button>
				
			</p>
		</footer>
	</div>
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동톡톡</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="icon" href="../resources/img/main/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">

<body>

<div class="continer" id="chat-wrapper" style="border: 2px solid #d9d9d9;height: 535px;margin: 30px; overflow-x:hidden; overflow-y: auto">
	<header id="chat-header" style="text-align: center;">
		<img src="../resources/img/main/favicon.png" alt="우동톡톡" style="width: 50px;" />
		<span style="font-size: 1.2em;font-weight: bold;padding: 5px;">우동톡톡</span>
	</header>		
	<input type="hidden" id="chat_id" value="${param.chat_id }" style="border:1px dotted red;" />
	<input type="hidden" id="chat_room" value="${param.chat_room }" style="border:1px dotted red;" />
	<ul id="channel-list" class="">
			
		<c:forEach items="${roomList }" var="row">
			<li>
				<c:if test="${id eq row.sellerid }">
				<a href="javascript:void(0);" onclick="window.open('../chatting/chatting.woo?chatroomidx=${row.chatroomidx}', 'name(${row.buyerid })', 'height=640; width=480; top=200; left=700;', true);">
				</c:if>
				<c:if test="${id ne row.sellerid }">
				<a href="javascript:void(0);" onclick="window.open('../chatting/chatting.woo?chatroomidx=${row.chatroomidx}', 'name(${row.sellerid })', 'height=640; width=480; top=200; left=700;', true);">
				</c:if>

					<div class="catting_room row">
						<div class="col-3" style="text-align: left;">
							<img src="../resources/img/myPage/nor-blue.png" alt="" width="50px;"/>
						</div>
						<div class="col-6">
							<c:if test="${id eq row.sellerid }">
								<div style="text-align: left;font-size: 1.4em;font-weight: bold;">${row.buyerid }</div>
							</c:if>
							<c:if test="${id ne row.sellerid }">
								<div style="text-align: left;font-size: 1.4em;font-weight: bold;">${row.sellerid }</div>
							</c:if>
								<div style="text-align: left;font-size: 1em;padding-top: 5px;">${row.lastChat }</div>
						</div>
					</div>
				</a>
			</li>
		</c:forEach>
	</ul>
	<!-- 우동이 -->
	<div style="position: absolute;top: 500px;left: 350px;" id="frogue-container" class="position-right-bottom"
      data-chatbot="343db279-fccf-4543-8016-74a5d0808807"
      data-user="사용자ID"
      data-init-key="value">
      </div>
	<!-- data-init-식별키=값 으로 셋팅하면 챗플로우에 파라미터와 연동가능. 식별키는 소문자만 가능 -->
	<script>
	(function(d, s, id){
	    var js, fjs = d.getElementsByTagName(s)[0];
	    if (d.getElementById(id)) {return;}
	    js = d.createElement(s); js.id = id;
	    js.src = "https:\/\/danbee.ai/js/plugins/frogue-embed/frogue-embed.min.js";
	    fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'frogue-embed'));
	</script>
</div>
</body>
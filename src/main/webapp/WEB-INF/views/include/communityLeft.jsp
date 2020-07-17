<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-3">
   <div class="my_profile_nav">
	<ul style="background-color:#FFF;border:1px solid #d9d9d9;margin-top: 50px;">
		<c:forEach items="${blists }" var="row">
				<li>
		 			<a class="active" id="scrollMain1"href="${row.requestname }"><span style="font-size:1.4em;color:#ff4f4f;">${row.bname }</span></a>
				</li>
		</c:forEach>
		</ul>
	</div>
</div>
    
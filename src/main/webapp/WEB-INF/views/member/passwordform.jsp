<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>

<body>
    <jsp:include page="../include/hearder.jsp"/>
    <section class="login_part section_padding"style="padding-bottom: 30px;padding-top: 210px;">
        <div class="container" >
            <div class="row align-items-center">
                <div class="col-3"></div>
                <div class="col-5">
                    <div style="border: 1px solid #d9d9d9; padding: 80px 70px;">
                        <div class="login_part_form_iner">
                        <div style="color:#ff4f4f; font-weight:bold; text-align:center; font-size:3.0em;margin-bottom:60px;">본인확인</div>
                            
                            <div style="margin-bottom:10px;">
                           	<form:form class="row contact_form" action="../member/passwordAction.woo" method="post"
								novalidate="novalidate">
                                <div class="col-md-12 form-group p_star">
                                    <input type="password" class="single-input-primary" id="password" name="password" value="" placeholder="비밀번호" style="border-bottom: 1px solid gray;">
                                </div>
                                <div class="col-md-12 form-group">
	                                 <div style="margin-bottom:20px;">
	                                    <button type="submit" value="submit" class="btn_3">본인확인</button>
                                    </div>
                                </div>
                           </form:form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3"></div>
            </div>
        </div>
    </section>
    <jsp:include page="../include/bottom.jsp"/>
</body>
    
</html>
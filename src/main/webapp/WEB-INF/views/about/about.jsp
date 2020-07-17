<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="zxx">

<!-- head.jsp -->
<jsp:include page="../include/head.jsp"/>

<body>
    <!--::header part start::-->
    <!-- header.jsp --> 
    <jsp:include page="../include/hearder.jsp"/>
    <!-- Header part end-->
 
    <!-- breadcrumb part start-->
		<section class="breadcrumb_part" >
	      <div class="container-fluid">
	         <div class="row top_image"></div>
	         <img src="../resources/img/소개.png" alt="" id="main" style="height: 100%; width: 100%">
	      </div>
	   </section>
    <!-- breadcrumb part end-->
    
    <!-- product list part start-->
    <section class="about_us padding_top" style="padding-top: 50px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12" style="margin-right: 200px;">
                    <img src="../resources/img/about/소개페이지1.png" alt="소개" />
                </div>
            </div> 
        </div>
    </section>
    <!-- product list part end-->

    <!-- feature part here -->
    <section class="feature_part section_padding" style="padding-top: 70px; padding-bottom: 50px; margin-right: 20px">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-12">
                    <img src="../resources/img/about/소개페이지2.png" alt="소개" />
                </div>
            </div>
        </div>
    </section>
    <!-- feature part end -->
    <!-- bottom.jsp -->
    <jsp:include page="../include/bottom.jsp"/>
    <jsp:include page="../include/sidebar.jsp"/>
    
</body>

</html>


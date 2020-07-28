<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8" id="_csrf" name="_csrf" content="${_csrf.token}">
    <!-- default header name is X-CSRF-TOKEN -->
	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>우동마켓</title>
    <link rel="icon" href="../resources/img/main/favicon.png">
    
        <!-- Required meta tags -->
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- (추가)부트스트랩 검색창 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/all.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/themify-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/magnific-popup.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slick.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <!-- fontawesome CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gijgo.min.css">
	<!-- niceselect CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nice-select.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/asd.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper4.2.2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="../resources/js/jquery-1.12.1.min.js"></script>
    
        <!-- (추가) Slider Bar jquery - ui  -->
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css" type="text/css">
     <!-- (추가) 부트스트랩 아이콘 CDN place-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
     <!-- (추가) 부트스트랩 아이콘 CDN 네모네모 -->
     <script src='https://kit.fontawesome.com/a076d05399.js'></script>
      <!-- (추가)부트스트랩 아이콘 CDN 채팅 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



    <style type="text/css">
    .ui-state-active,
	.ui-button.ui-state-active:hover {
		border: 1px solid #ff4f4f;
		background: #ff4f4f;
		font-weight: normal;
		color: #ffffff;
	}
<!-- 팝업용 CSS 추가 -->


#popup{overflow:hidden; height:auto; display:block; border-radius:3px; box-shadow:0px 1px 1px #333; width:260px; z-index:100; position:absolute;  top:20%; left:10%;}
#popup h4{background:#659fd5; font-size:15px; height:24px;  padding:8px 0 2px 15px ; color:#FFF; font-weight:normal;}
#popup h4 a.close{float:right; padding-right:8px; color:#FFF; font-family:verdana}
  .popCont{display:block; background: #FFF; border:2px solid #659fd5; padding:15px 20px;  }
  .popCont li{height:24px; width:100%; display:inline-block; margin:0; border-top:1px solid #eaeaea;  font-size:12px; }
  .popCont li:last-child{border-bottom:1px solid #eaeaea; padding-bottom:3px;}
  .popCont strong{float:left; width:30%; background: #aaa; color:#FFF; padding:7px 0; text-align:center; border-right:1px solid #eaeaea; }
  .popCont span{display:block; float:left; padding:7px 0  7px 8px;}


<!-- //팝업용 CSS 추가 -->



    </style>
	 <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
</head>

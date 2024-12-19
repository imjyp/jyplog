<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css">
<style >

.sub-menu{
	width: 1590px !important;
	margin:0 auto !important; 
}
.sub-menu > ul>li>a{
font-weight: 600 !important;
}
</style>
</head>
<body>

	<div id="footerMenu" class="footer-menu" style="display: none;">
			<ul>
				<li><a href="${contextPath}/mypage?action=mypage">마이페이지</a></li>
				<li><a href="${contextPath}/board/question.do">고객센터</a></li>
			</ul>
		</div>
<div class="smenu">
		<nav class="sub-menu">
			<ul>
				<li><a href="${contextPath}/prod/prodlist.do" class="sphome">쇼핑 홈</a></li>
			</ul>
		</nav>
</div>


<script src="${pageContext.request.contextPath}/resource/js/main.js"></script> 
</body>
</html>
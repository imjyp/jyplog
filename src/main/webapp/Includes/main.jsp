<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sweet Home 중간 프로젝트</title>

<!-- css파일  -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"> 
<style >

.home {
	color: rgb(253, 78, 2) !important;
	font-weight: 500 !important;
}
.comm{
	color: rgb(253, 78, 2) !important;
	font-weight: 500 !important;

}
</style>
</head>
<body>
<div class="body">

	<%@include file="./headermenu.jsp" %>
	<%@include file="./middlemenu.jsp" %>
	<%@include file="./maincontent.jsp" %>
	<%@include file="./footer.jsp" %>
	
</div>

<!-- js파일  -->
<script src="${pageContext.request.contextPath}/resource/js/main.js"></script> 
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.member.vo.MemberVo"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의하기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"> 
    
    <style>
 * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

.header-spacing {
    margin-bottom: 30px;
}
  

.register-btn,
.cancle-btn{
/* 	float: right; */
    margin-right: 20px;
    padding: 6px 10px;
	border: none;
	background-color: #000000;
	color: white;
	border-radius: 3px;
	cursor: pointer;
	font-size: 1rem;
}

/* 
.cancle-btn{
	background-color: #6c757d;
}
 */
 
.register-btn:hover,
.cancle-btn:hover{
	background-color: rgb(253, 78, 2);
}

.header-spacing {
    margin-bottom: 30px;
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

.form {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 600px;
	margin: 0 auto; /* 폼 자체 가운데 정렬 */
	text-align: center; /* 폼 내부 요소들 가운데 정렬 */
}

label {
    display: block;
    margin-bottom: 10px;
    font-size: 1.1rem;
    color: #333;
    text-align: left;
    font-weight: bold;
}


.textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1rem;
    box-sizing: border-box;
    margin-top: 10px;
    margin-bottom: 30px; 
}


.dmbox{
	max-width:1590px;
	margin:0 auto;
}
    </style>
</head>
<body>
<div class="body">
		<%@include file="/Includes/headermenu.jsp"%>
		<%@include file="/Includes/middlemenu.jsp" %>
		
	<div class="dmbox">
    	<div class="content header-spacing"></div>
        <h2>1:1 문의</h2>
        <form class="form" action="${pageContext.request.contextPath}/member/inquirySubmit.do" method="post">
            <label for="title">&nbsp; 제목</label>
            <input class="textarea" type="text" id="title" name="title" required>

            <label for="content">&nbsp; 내용</label>
            <textarea class="textarea" id="content" name="content" rows="10" cols="50" required></textarea>

                <button class="register-btn" type="submit">등록</button>
                <a href="${pageContext.request.contextPath}/member/customer.do?inquiry=1" class="cancle-btn">취소</a>
        </form>
        
        <%@include file="/Includes/footer.jsp" %>
       
    </div>
</div>
</body>
</html>

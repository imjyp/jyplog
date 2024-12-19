<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.member.vo.MemberVo"%>
<%@ page import="kr.or.ddit.board.vo.QABoardVo"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>

<html>
<head>
    <title>공지사항 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"> 
    
<style>

.tabs {
	display: flex;
	justify-content: flex-start;
	padding: 20px;
	padding-left: 20px;
	background-color: #ffffff;
}

.tabs ul {
	display: flex;
	list-style: none;
}

.tabs ul li {
	margin-right: 20px;
}

.tabs ul li a {
	text-decoration: none;
	color:rgb(44, 45, 50);
	font-size: 1.1rem;
}

.tabs ul li a.active, .tabs ul li a:hover, .tabs ul li a:focus {
	color: rgb(253, 78, 2);
	font-weight: bold;
}

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


h2 {
    text-align: center;
    margin-bottom: 20px;
}

.form {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 800px;
	margin: 0 auto; /* 폼 자체 가운데 정렬 */
	text-align: center; /* 폼 내부 요소들 가운데 정렬 */
}

label {
    display: block;
    margin-bottom: 15px;
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
    margin-top: 15px;
}

textarea {
    resize: vertical;
}

.nfcontainer {
	max-width: 1590px;
	margin: 0 auto;
}

.nftab {
	border-bottom: 1px solid #ddd;
	width: 100%;
}

.tabs {
	max-width: 1590px;
	margin: 0 auto;
	border: none !important;
} 
       
</style>
</head>
<body>
    
    <div class="body">

	<%@include file="/Includes/headermenu.jsp" %>
	<%@include file="/Includes/middlemenu.jsp" %>
	
	<div class="nftab">
	<c:if test="${sessionScope.loginAdmin != null}">
	
		<div class="tabs">
		    <ul>
		        <li><a href="${contextPath}/admin/memList.do" >회원 관리</a></li>
		        <li><a href="${contextPath}/member/customer.do" class="active">고객센터</a></li>
		        <li><a href="${contextPath}/admin/prodmanagement.do" >상품 관리</a></li>
		    </ul>
		</div>
	</c:if>
	<div class="nfcontainer">
	<div class="content header-spacing"></div>
	<h2>공지사항 등록</h2>
	<form  class="form" action="${pageContext.request.contextPath}/notice/insert.do" method="post">
        <label>&nbsp; 제목 <input class="textarea" type="text" name="title" required/></label><br/>
        <label>&nbsp; 내용 <textarea class="textarea" name="content" rows="10" cols="50" required></textarea></label><br/>
        <button class="register-btn" type="submit">등록</button>
        <a href="${pageContext.request.contextPath}/member/customer.do?boardcode=1" class="cancle-btn">취소</a>
    </form>
    
    <%@include file="/Includes/footer.jsp" %>
       
    </div>
    </div>
    </div>
</body>
</html>



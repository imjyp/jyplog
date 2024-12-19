<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<%@ page import="kr.or.ddit.admin.vo.AdminVo"%>
<%@ page import="kr.or.ddit.board.vo.QABoardVo"%>
<%@ page import="kr.or.ddit.board.vo.AnswerVo"%>

<%
    // 관리자 로그인 여부 확인
    AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");
    if (loginAdmin == null) {
        // 로그인되어 있지 않으면 로그인 페이지로 리다이렉트
        response.sendRedirect("${pageContext.request.contextPath}/member/login.do");
        return;
    }

    // 전달된 question 객체와 answer 객체를 가져옵니다.
    QABoardVo question = (QABoardVo) request.getAttribute("question");
    AnswerVo answer = (AnswerVo) request.getAttribute("answer");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 답변</title>
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

.button-group {
    display: flex;
    justify-content: center;
    margin-top: 20px;
} 

.registerbtn,
.canclebtn{
    margin-right: 20px;
    padding: 6px 10px;
	border: none;
	background-color: #000000;
	color: white;
	border-radius: 3px;
	cursor: pointer;
	font-size: 1rem;
}

 
.registerbtn:hover,
.canclebtn:hover{
	background-color: rgb(253, 78, 2);
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

.form{
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 800px;
	margin: 0 auto; /* 폼 자체 가운데 정렬 */
	text-align: center; /* 폼 내부 요소들 가운데 정렬 */
}
.qfrom {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 800px;
	margin: 0 auto; /* 폼 자체 가운데 정렬 */
	text-align: left; 
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

.afcontainer {
	max-width: 1590px;
	margin: 0 auto;
}

.aftab {
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
	
	<div class="aftab">
	<c:if test="${sessionScope.loginAdmin != null}">
	
		<div class="tabs">
		    <ul>
		        <li><a href="${contextPath}/admin/memList.do" >회원 관리</a></li>
		        <li><a href="${contextPath}/member/customer.do" class="active">고객센터</a></li>
		        <li><a href="${contextPath}/admin/prodmanagement.do" >상품 관리</a></li>
		    </ul>
		</div>
	</c:if>
	</div>
	<div class="afcontainer">
	<div class="content header-spacing"></div>
        <h2>1:1 문의 답변</h2>
        <form class="qfrom">
        <p><strong>문의 제목</strong> <br> &nbsp;&nbsp;${question.question_title} </p> <br>
        <p><strong>문의 내용</strong> <br> &nbsp;&nbsp;${question.question_content}</p>
        </form>
        <br>
        
        <c:if test="${sessionScope.loginAdmin != null}">
		    <form class="form" action="${pageContext.request.contextPath}/admin/answerSubmit.do" method="post">
		        <input type="hidden" name="question_no" value="${question.question_no}">
		        <label for="content">답변 내용</label>
		        <textarea class="textarea" id="content" name="content" rows="10" cols="50" required>${answer != null ? answer.answer_content : ''}</textarea>
		
		        <div class="button-group">
		            <button class="registerbtn" type="submit">등록</button>
		            <a href="${pageContext.request.contextPath}/member/customer.do?inquiry=1" class="canclebtn">취소</a>
		        </div>
		    </form>
		</c:if>
        
    </div>
<%@include file="/Includes/footer.jsp" %>
</div>

</body>
</html>

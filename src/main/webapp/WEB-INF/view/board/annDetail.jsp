<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.board.vo.BoardVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세보기</title>
    <style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

body {
    background-color: #f8f8f8;
    color: #333;
}

.container {
    max-width: 800px;
    margin: 50px auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    border: 1px solid #ddd;
    position: relative; /* 위치 설정을 위해 추가 */
    display: flex;
    flex-direction: column; /* 세로 방향으로 정렬 */
    justify-content: space-between; /* 요소 사이의 공간을 균등하게 */
}

.post-header {
    border-bottom: 2px solid #ddd; /* 경계선을 회색으로 변경 */
    margin-bottom: 20px;
    padding-bottom: 10px;
    width: 100%; /* 헤더 너비를 100%로 설정하여 컨테이너에 맞춤 */
}

.post-title {
    font-size: 1.8rem;
    margin-bottom: 10px;
}

.post-meta {
    font-size: 0.9rem;
    color: #888;
    text-align: right; /* 오른쪽 정렬 */
    margin-bottom: 20px; /* 위쪽 여백 추가 */
}

.post-content {
    font-size: 1rem;
    line-height: 1.6;
    margin-bottom: 30px;
    text-align: left; /* 내용 왼쪽 정렬 */
}

.btn-back-container {
    margin-top: 20px; /* 위쪽 여백 추가 */
    text-align: right; /* 오른쪽 정렬 */
}

.btn-back {
    display: inline-block; /* 블록으로 변경하여 스타일 적용 */
    padding: 10px 20px; /* 버튼 크기 조정 */
    border: none;
    background-color: #000000;
    color: white;
    border-radius: 5px; /* 더 둥글게 */
    cursor: pointer;
    font-size: 1rem;
    text-align: center; /* 텍스트 중앙 정렬 */
}

.btn-back:hover {
    background-color: rgb(253, 78, 2);
}

.embox {
    max-width: 1590px;
    margin: 0 auto;
}

footer {
    margin-top: 20px; /* 푸터와의 간격 조정 */
}
    </style>
</head>
<body>
    <div class="body">
        <%@include file="/Includes/headermenu.jsp"%>
        <%@include file="/Includes/middlemenu.jsp" %>
        
        <div class="embox">
            <div class="content header-spacing"></div>
            <%-- 게시글 객체를 가져옵니다. --%>

            <c:set var="post" value="${requestScope.detailBoard}" />
            <%-- 게시글이 존재하는지 확인합니다. --%>
            <div class="container ">
                <c:if test="${not empty post}">
                    <div class="post-header">
                        <h1 class="post-title">${post.title}</h1>
                        <p class="post-meta">
                            작성자: ${post.writer} | 작성일: ${post.date_of_pre}
                        </p>
                    </div>
                    <div class="post-content">
                        <p>${post.detail}</p>
                    </div>
                </c:if>

                <%-- 게시글이 존재하지 않을 경우 --%>
                <c:if test="${empty post}">
                    <p>해당 게시글이 존재하지 않습니다.</p>
                </c:if>
                
                <!-- 버튼을 컨테이너 아래에 위치 -->
                <div class="btn-back-container"> 
                    <a href="${contextPath}/member/customer.do" class="btn-back">목록</a>
                </div>
            </div>
            <%@include file="/Includes/footer.jsp" %>
        </div>
    </div>
</body>
</html>

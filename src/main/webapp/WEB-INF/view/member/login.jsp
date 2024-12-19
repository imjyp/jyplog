<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>    

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
    /* 기본 스타일 초기화 */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Noto Sans KR', sans-serif;
    }

    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f5f5f5;
    }

    .login-container {
        background-color: #fff;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 300px;
    }

    .login-container img {
        width: 60px;
        margin-bottom: 20px;
    }

    .login-container h1 {
        font-size: 1.2rem;
        margin-bottom: 20px;
        font-weight: bold;
    }

    .input-field {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 0.9rem;
    }

    .login-button {
        width: 100%;
        padding: 12px;
        background-color: #000000;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1rem;
        margin-top: 15px;
        margin-bottom: 20px;
    }

    .login-button:hover {
        background-color: #000000;
    }

    .link-container {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
        font-size: 0.8rem;
    }

    .link-container a {
        text-decoration: none;
        color: #000000;
        font-weight: bold;
        font-size: 0.8rem;
    }

    .social-login {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 20px;
        margin-top: 10px;
        font-family: 'Noto Sans KR', sans-serif;
        font-size: 0.9rem;
        font-weight: bold;
    }

    .social-login img {
        width: 30px;
        height: 30px;
        cursor: pointer;
        margin-top: 5px;
        margin-bottom: 20px;
    }

    .bottom-link {
        font-size: 0.8rem;
        color: #666;
        text-decoration: none;
        margin-top: 20px;
        display: block;
    }
    
    .error-message {
        color: red;
        margin-top: 15px;
        font-size: 0.8rem;
        font-weight: bold;
        margin-bottom: 20px;
    }
    
</style>
</head>
<body>
    <div class="login-container">
        <a href="${contextPath}/main/main.do" class="logo">
            <img alt="" src="${contextPath}/images/logo.png">
        </a>
        <h1>SWEET HOME</h1>
        
        <form action="${contextPath}/member/login.do" method="post" >
            <input type="text" id="id" name="id" class="input-field" placeholder="아이디" required>
            <input type="password" id="pw" name="pw" class="input-field" placeholder="비밀번호" required>
            <input type="submit" value="로그인" class="login-button">
        </form>
        
        <!-- 로그인 실패 시 메시지 표시 -->
        <c:if test="${not empty message}">
            <div class="error-message">${message}</div>
        </c:if>
        
        <div class="link-container">
            <a href="${contextPath}/member/findId.do">아이디 찾기 </a>
            <a href="${contextPath}/member/findPw.do">비밀번호 찾기</a>
            <a href="${contextPath}/member/join.do">회원가입</a>
        </div>
       
    </div>
</body>
</html>

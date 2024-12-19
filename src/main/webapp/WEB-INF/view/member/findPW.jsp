<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>    

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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

    .find-pw-container {
        background-color: #fff;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 300px;
    }

    .find-pw-container img {
        width: 60px;
        margin-bottom: 20px;
    }

    .find-pw-container h1 {
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

    .submit-button {
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

    .submit-button:hover {
        background-color: #000000;
    }

    .message {
        color: red;
        margin-top: 15px;
        font-size: 0.8rem;
        font-weight: bold;
        margin-bottom: 20px;
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
    
    .phone-inputs {
	    display: flex;
	    gap: 10px;
		}
	
	.input-field-phone {
	    width: calc(25% - 10px); /* 필드 간 적절한 간격을 주기 위해 너비 조정 */
	    padding: 10px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    font-size: 0.9rem;
		}
		
</style>    
</head>
<body>
    <div class="find-pw-container">
        <a href="${contextPath}/main/main.do" class="logo">
		<img alt="" src="${contextPath}/images/logo.png">
		</a>
        <h1>비밀번호 찾기</h1>
        <form action="<c:url value='/member/findPw.do'/>" method="post">
            <input type="text" name="mem_name" class="input-field" placeholder="이름" required>
            <input type="text" name="mem_id" class="input-field" placeholder="아이디" required>
            <div class="phone-inputs">
	            <input type="text" name="phone1" class="input-field" placeholder="010" maxlength="3" required>
	            <input type="text" name="phone2" class="input-field" placeholder="1234" maxlength="4" required>
	            <input type="text" name="phone3" class="input-field" placeholder="5678" maxlength="4" required>
            </div>
            <button type="submit" class="submit-button">회원 정보 확인</button>
        </form>
        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>
        <div class="link-container">
            <a href="${contextPath}/member/findId.do">아이디 찾기</a> 
            <a href="${contextPath}/member/login.do">로그인</a>
        </div>
    </div>
</body>
</html>

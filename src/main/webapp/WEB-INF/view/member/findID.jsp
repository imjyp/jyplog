<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>    

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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

    .find-id-container {
        background-color: #fff;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 300px;
    }

    .find-id-container img {
        width: 60px;
        margin-bottom: 20px;
    }

    .find-id-container h1 {
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

    .find-button {
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

    .find-button:hover {
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
    <div class="find-id-container">
       <a href="${contextPath}/main/main.do" class="logo">
		<img alt="" src="${contextPath}/images/logo.png">
		</a>
        <h1>아이디 찾기</h1>
        <form action="${contextPath}/member/findId.do" method="post">
            <input type="text" id="mem_name" name="mem_name" class="input-field" placeholder="이름" required>
            <div class="phone-inputs">
                <input type="text" name="phone1" maxlength="3" class="input-field" style="width: 30%;" placeholder="010" required>
                <input type="text" name="phone2" maxlength="4" class="input-field" style="width: 30%;" placeholder="1234" required>
                <input type="text" name="phone3" maxlength="4" class="input-field" style="width: 30%;" placeholder="5678" required>
            </div>
            <input type="submit" value="아이디 찾기" class="find-button">
        </form>

        <!-- 결과 메시지 출력 -->
        <div class="message">
            <c:choose>
                <c:when test="${not empty findId}">
                    ${findId}
                </c:when>
                <c:otherwise>
                    <c:out value="${message}" />
                </c:otherwise>
            </c:choose>
        </div>

        <div class="link-container">
            <a href="${contextPath}/member/findPw.do">비밀번호 찾기</a> 
            <a href="${contextPath}/member/login.do">로그인</a>
        </div>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이메일 인증 및 임시 비밀번호 발급</title>
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
        
        .logo {
		    text-align: center; /* 로고를 가운데 정렬 */
		    margin-bottom: 20px; /* 아래 여백 추가 */
		}
		
		.logo img {
		    width: 60px; /* 로고 크기 설정 */
		    height: auto; /* 비율을 유지하며 크기 조정 */
		}
		
        .find-pw-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 320px;
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
        
        .find-button, .send-code-button, .verify-button {
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
        
        .message {
        color: red;
        margin-top: 15px;
        font-size: 0.8rem;
        font-weight: bold;
        margin-bottom: 20px;
    }
    
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
    <div class="find-pw-container">
	<div class="logo">
	    <a href="${contextPath}/main/main.do" class="logo">
		<img alt="" src="${contextPath}/images/logo.png">
		</a>
	</div>
        <h1>이메일 인증</h1>
        <form id="findForm" action="${contextPath}/member/verifyEmail.do" method="post" onsubmit="event.preventDefault(); submitForm();">
            <input type="text" id="email" name="email" class="input-field" placeholder="이메일" required autocomplete="email">
            <button type="button" class="send-code-button" onclick="sendAuthCode()">이메일로 인증코드 받기</button>
            <input type="text" id="authCode" name="authCode" class="input-field" placeholder="인증코드 입력" autocomplete="one-time-code">
            <button type="button" class="verify-button" onclick="verifyAuthCode()">인증</button>
            <input type="submit" value="임시 비밀번호 발급받기" class="find-button">
        </form>
        <div class="message" id="message"></div>
        <div class="link-container">
            <a href="${contextPath}/member/findId.do">아이디 찾기</a> 
            <a href="${contextPath}/member/login.do">로그인</a>
        </div>
    </div>
    
    <script>
    // 이메일 인증코드 전송 함수
    function sendAuthCode() {
    var email = document.getElementById('email').value;
    console.log("email: ", email); // 디버깅용 출력

    $.ajax({
        url: '${contextPath}/member/verifyEmail.do', // URL에 맞게 수정
        type: 'POST',
        data: {
            email: email,
            action: 'sendAuthCode'
        },
//         contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        success: function(response) {
            console.log("인증코드가 이메일로 발송되었습니다.");
            document.getElementById('message').innerText = "인증코드가 이메일로 발송되었습니다.";
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
            document.getElementById('message').innerText = "인증코드 발송 중 오류가 발생했습니다.";
        }
    });
}

	//인증 코드 확인 함수
	function verifyAuthCode() {
    const authCode = document.getElementById('authCode').value.trim(); // 공백 제거

    if (!authCode) {
        console.error("인증코드가 입력되지 않았습니다.");
        document.getElementById('message').innerText = "인증코드를 입력해 주세요.";
        return;
    }

    console.log("Verifying authCode: ", authCode);
    
    $.ajax({
        url: '${contextPath}/member/verifyEmail.do',
        type: 'POST',
        data: {
            action: 'verifyAuthCode',
            authCode: authCode // 서버에 전송할 인증코드
        },
        success: function (response) {
            console.log("인증코드가 확인되었습니다.");
            document.getElementById('message').innerText = "인증번호가 확인되었습니다.";
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
            document.getElementById('message').innerText = "인증번호가 일치하지 않습니다.";
        }
    });
}

    // 폼 제출 시 임시 비밀번호 발급 요청
    function submitForm() {
        const email = document.getElementById('email').value;
        
        // 서버로 임시 비밀번호 발급 요청
        $.ajax({
            url: '${contextPath}/member/verifyEmail.do',
            type: 'POST',
            data: {
                action: 'issueTempPassword',
                email: email
            },
            success: function (response) {
            	console.log("임시 비밀번호 발급 성공");
                document.getElementById('message').innerText = "임시 비밀번호가 이메일로 발급되었습니다.";
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                document.getElementById('message').innerText = "임시 비밀번호 발급 중 오류가 발생했습니다.";
            }
        });
    }
    </script>
</body>
</html>

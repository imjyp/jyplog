<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 조회 및 수정</title>
    <link rel="stylesheet" href="${contextPath}/resource/css/main.css">
    <link rel="stylesheet" href="${contextPath}/resource/css/tabs.css">
    <style>
    
        /* 공통 스타일 */
        body {
            margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: "Noto Sans KR","roboto" !important;
        }


        /* 탭 메뉴 스타일 */
        .tabs,
        .sub-tabs {
            display: flex;
			justify-content: flex-start;
			padding: 20px;
			padding-left: 20px;
			background-color: #ffffff;
			max-width: 1590px;
			margin: 0 auto;
        }

        .tabs ul,
        .sub-tabs ul {
            display: flex;
			list-style: none;
        }

        .tabs ul li,
        .sub-tabs ul li {
            margin-right: 20px;
        }

        .tabs ul li a,
        .sub-tabs ul li a {
            text-decoration: none;
			color: rgb(44, 45, 50);
			font-size: 1.1rem;
        }

        .tabs ul li a.active,
        .tabs ul li a:hover,
        .tabs ul li a:focus,
        .sub-tabs ul li a.active,
        .sub-tabs ul li a:hover,
        .sub-tabs ul li a:focus {
            color: 
rgb(253, 78, 2);
            font-weight: bold;
        }

        
        /* 회원정보 조회 및 수정 폼 스타일 */
        .form-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .form-container h2 {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .form-group .input-group {
            display: flex;
            gap: 10px;
        }

        .form-group .input-group input {
            flex: 1;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background-color: #000000;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }


        .success-message {
            display: none;
            background-color: #e0f7fa;
            color: #00796b;
            padding: 10px;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .success-message.show {
            display: block;
        }
        .meminfo{
        
        	max-width: 1590px;
        	margin: 0 auto;
        }
        .mptab{
        border-bottom: 1px solid #ddd;
	width: 100%;
        }
        .submit-btn:active{
background-color:
rgb(253, 78, 2); 

}
        
    </style>
    <script>
        function updateEmail() {
            var emailPart = document.getElementById("email").value;
            var emailDomain = document.getElementById("email-domain").value;
            document.getElementById("email-full").value = emailPart + "@" + emailDomain;
        }

        function updatePhone() {
            var phonePart1 = document.getElementById("phone-part1").value;
            var phonePart2 = document.getElementById("phone-part2").value;
            var phonePart3 = document.getElementById("phone-part3").value;
            document.getElementById("phone-full").value = phonePart1 + "-" + phonePart2 + "-" + phonePart3;
        }
    </script>
</head>
<body>
	<div class="body">
    <%@include file="/Includes/headermenu.jsp" %>

<div class="mptab" >
	<div class="tabs">
    <ul>
        <li><a href="mypage?action=mypage" >프로필</a></li>
        <li><a href="mypage?action=order">나의 쇼핑</a></li>
        <li><a href="mypage?action=meminfo" class="active">설정</a></li>
	</ul>     
	</div>
</div>
<div class="mptab" >
    <div class="sub-tabs">
    <ul>
        <li><a href="mypage?action=meminfo" class="${param.action == 'meminfo' ? 'active' : ''}">회원정보 조회 및 수정</a></li>
        <li><a href="mypage?action=password" class="${param.action == 'password' ? 'active' : ''}">비밀번호변경</a></li>
        <li><a href="mypage?action=withdraw" class="${param.action == 'withdraw' ? 'active' : ''}">회원 탈퇴</a></li>
    </ul>
	</div>
</div>

<div class="meminfo">
    <!-- 성공 메시지 표시 영역 -->
    <c:if test="${not empty param.success and param.success == 'true'}">
        <div class="success-message show">수정이 완료되었습니다</div>
    </c:if>

    <section class="form-container">
        <h2>회원정보 조회 및 수정</h2>
        <form method="post" action="${pageContext.request.contextPath}/mypage/updateMember">
            <div class="form-group">
                <label for="user-id">아이디</label>
                <input type="text" id="user-id" value="${sessionScope.loginUser.mem_id}" disabled>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="mem_name" value="${sessionScope.loginUser.mem_name}">
            </div>
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="mem_nick" value="${sessionScope.loginUser.mem_nick}">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <div class="input-group">
                    <input type="text" id="email" name="email_part" value="${fn:substringBefore(sessionScope.loginUser.email, '@')}" oninput="updateEmail()">
                    <select id="email-domain" name="email_domain" onchange="updateEmail()" style="width: 50%;">
                        <option value="">@ 선택해주세요</option>
                        <option value="naver.com" ${fn:substringAfter(sessionScope.loginUser.email, '@') == 'naver.com' ? 'selected' : ''}>naver.com</option>
                        <option value="gmail.com" ${fn:substringAfter(sessionScope.loginUser.email, '@') == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
                        <option value="daum.net" ${fn:substringAfter(sessionScope.loginUser.email, '@') == 'daum.net' ? 'selected' : ''}>daum.net</option>
                    </select>
                    <input type="hidden" id="email-full" name="email" value="${sessionScope.loginUser.email}">
                </div>
            </div>
            <div class="form-group">
                <label for="phone">휴대폰 번호</label>
                <div class="input-group">
                    <input type="text" id="phone-part1" name="phone_part1" maxlength="3" value="${fn:substring(sessionScope.loginUser.phone, 0, 3)}" oninput="updatePhone()">
                    <input type="text" id="phone-part2" name="phone_part2" maxlength="4" value="${fn:substring(sessionScope.loginUser.phone, 4, 8)}" oninput="updatePhone()">
                    <input type="text" id="phone-part3" name="phone_part3" maxlength="4" value="${fn:substring(sessionScope.loginUser.phone, 9,14)}" oninput="updatePhone()">
                    <input type="hidden" id="phone-full" name="phone" value="${sessionScope.loginUser.phone}">
                </div>
            </div>
            <button type="submit" class="submit-btn">수정하기</button>
        </form>
    </section>
</div>
	<%@include file="/Includes/footer.jsp" %>
	</div>
</body>
</html>

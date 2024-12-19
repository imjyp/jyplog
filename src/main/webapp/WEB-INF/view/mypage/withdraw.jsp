<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 탈퇴</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<style>

/* 공통 스타일 */
body {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Noto Sans KR", "roboto" !important;
}

/* 탭 메뉴 스타일 */
.tabs, .sub-tabs {
	display: flex;
	justify-content: flex-start;
	padding: 20px;
	padding-left: 20px;
	background-color: #ffffff;
	max-width: 1590px;
	margin:0 auto;
}

.tabs ul, .sub-tabs ul {
	display: flex;
	list-style: none;
}

.tabs ul li, .sub-tabs ul li {
	margin-right: 20px;
}

.tabs ul li a, .sub-tabs ul li a {
	text-decoration: none;
	color:rgb(44, 45, 50) ;
	font-size: 1.1rem;
}

.tabs ul li a.active, .tabs ul li a:hover, .tabs ul li a:focus,
	.sub-tabs ul li a.active, .sub-tabs ul li a:hover, .sub-tabs ul li a:focus
	{
	color: rgb(253, 78, 2);
	font-weight: bold;
}

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

.info-box {
	border: 1px solid #ddd;
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 20px;
	background-color: #f4f4f4;
}

.info-box p {
	margin: 0 0 10px;
	font-size: 14px;
	color: #333;
	line-height: 1.5;
}

.form-group {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 20px;
}

.form-group input[type="checkbox"] {
	margin: 0;
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

.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
}

.modal-content {
	background: white;
	padding: 20px;
	border-radius: 8px;
	text-align: center;
	width: 300px;
}

.modal-content h3 {
	margin-bottom: 20px;
	font-size: 18px;
}

.close-btn {
	padding: 10px 20px;
	background-color: black;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.error-message {
	color: red;
	font-size: 14px;
	margin-bottom: 10px;
	display: none;
}

.mptab {
	border-bottom: 1px solid #ddd;
	width: 100%;
}
</style>
</head>
<body>
	<div class="body">
		<%@include file="/Includes/headermenu.jsp"%>
		<div class="mptab">
			<div class="tabs">
				<ul>
					<li><a href="mypage?action=mypage">프로필</a></li>
					<li><a href="mypage?action=order">나의 쇼핑</a></li>
					<li><a href="mypage?action=meminfo" class="active">설정</a></li>
				</ul>
			</div>

		</div>
		<div class="mptab">
			<div class="sub-tabs">
				<ul>
					<li><a href="mypage?action=meminfo"
						class="${param.action == 'meminfo' ? 'active' : ''}">회원정보 조회 및
							수정</a></li>
					<li><a href="mypage?action=password"
						class="${param.action == 'password' ? 'active' : ''}">비밀번호변경</a></li>
					<li><a href="mypage?action=withdraw"
						class="${param.action == 'withdraw' ? 'active' : ''}">회원 탈퇴</a></li>
				</ul>
			</div>
		</div>

		<section class="form-container">
			<h2>회원 탈퇴 신청</h2>
			<div class="info-box">
				<p>
					<strong>회원 탈퇴 시 처리 내용</strong>
				</p>
				<p>- 포인트 소멸, 구매 정보 삭제 등</p>
				<p>
					<strong>회원 탈퇴 시 게시글 관리</strong>
				</p>
				<p>- 게시물 및 댓글은 삭제되지 않으며, 본인 확인 불가</p>
			</div>

			<div class="form-group">
				<input type="checkbox" id="confirm"> <label for="confirm">위
					내용을 모두 확인하였습니다.</label>
			</div>

			<p id="error-message" class="error-message">위 내용을 확인해주세요.</p>
			<button type="button" class="submit-btn" onclick="handleSubmit()">회원
				탈퇴</button>
		</section>

		<div class="modal" id="completeModal">
			<div class="modal-content">
				<h3>탈퇴가 완료되었습니다.</h3>
				<button class="close-btn" onclick="redirectToLogin()">로그인
					페이지로 이동</button>
			</div>
		</div>

		<%@include file="/Includes/footer.jsp"%>

		<script>
        function handleSubmit() {
            const checkbox = document.getElementById('confirm');
            const errorMessage = document.getElementById('error-message');

            if (!checkbox.checked) {
                errorMessage.style.display = 'block';
            } else {
                errorMessage.style.display = 'none';

                // AJAX 요청으로 회원 탈퇴
                fetch('${pageContext.request.contextPath}/mypage/withdraw', {  // 요청 경로를 WithDrawController로 변경
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'action=withdraw' // 필요한 데이터 전송
                }).then(response => {
                    if (response.ok) {
                        openModal(); // 모달 열기
                    } else {
                        alert('회원 탈퇴 실패: 확인 후 다시 시도해주세요.'); // 오류 처리
                    }
                });
            }
        }

        function openModal() {
            document.getElementById('completeModal').style.display = 'flex';
        }

        function redirectToLogin() {
            var contextPath = '<%=request.getContextPath()%>';  // JSP에서 contextPath를 가져옴
            window.location.href = contextPath + '/member/login.do';  // 로그인 페이지로 리다이렉트
        }
    </script>
	</div>
</body>
</html>


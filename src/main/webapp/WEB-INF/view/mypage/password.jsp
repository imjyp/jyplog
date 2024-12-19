<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 변경</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<style>
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
	margin: 0 auto;
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
	color: rgb(44, 45, 50);
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
	height: 500px;
}

.form-container h2 {
	font-size: 20px;
	margin-bottom: 30px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.form-group input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
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

.submit-btn:active {
	background-color: rgb(253, 78, 2);
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 400px;
	text-align: center;
	border-radius: 5px;
}

.modal-button {
	padding: 10px 15px;
	border: none;
	background-color: #000000;
	color: white;
	border-radius: 3px;
	cursor: pointer;
	margin: 5px;
}

.mptab {
	border-bottom: 1px solid #ddd;
	width: 100%;
}

.submit-btn:active {
	background-color: rgb(253, 78, 2);
}
#submit-btn:active {
	background-color: rgb(253, 78, 2);
}
</style>
<script>
        function openModal() {
            document.getElementById("myModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("myModal").style.display = "none";
        }

        function submitForm(event) {
            event.preventDefault(); // 기본 제출 방지
            const currentPassword = document.getElementById("current-password").value;
            const newPassword = document.getElementById("new-password").value;
            const confirmPassword = document.getElementById("confirm-password").value;

            // 비밀번호와 비밀번호 확인이 일치하는지 확인
            if (newPassword !== confirmPassword) {
                alert('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                return;
            }

            // 쿼리 문자열을 생성
            const queryParams = new URLSearchParams({
                currentPassword: currentPassword,
                newPassword: newPassword
            });

            // AJAX 요청 (fetch API 사용)
            fetch('${pageContext.request.contextPath}/mypage/changePassword', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: queryParams.toString()
            }).then(response => {
                return response.text(); // 응답을 텍스트로 반환
            }).then(data => {
                if (data.includes("성공적으로 변경")) {
                    openModal(); // 성공 시 모달 열기
                } else {
                    alert('비밀번호 변경 실패: ' + data); // 실패 시 오류 메시지
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('비밀번호 변경 중 오류가 발생했습니다.');
            });
        }
    </script>
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
					<li id="submit-btn"><a href="mypage?action=withdraw"
						class="${param.action == 'withdraw' ? 'active' : ''}"  >회원 탈퇴</a></li>
				</ul>
			</div>
		</div>

		<section class="form-container">
			<h2>비밀번호 변경</h2>
			<form method="post"
				action="${pageContext.request.contextPath}/mypage/changePassword"
				onsubmit="submitForm(event)">
				<div class="form-group">
					<label for="current-password">현재 비밀번호</label> <input
						type="password" id="current-password" name="currentPassword"
						placeholder="사용 중인 비밀번호를 입력해주세요." required>
				</div>
				<div class="form-group">
					<label for="new-password">새 비밀번호</label> <input type="password"
						id="new-password" name="newPassword" placeholder="새 비밀번호를 입력해주세요."
						required>
				</div>
				<div class="form-group">
					<label for="confirm-password">비밀번호 확인</label> <input
						type="password" id="confirm-password" name="confirmPassword"
						placeholder="비밀번호를 한 번 더 입력해주세요." required>
				</div>
				<button type="submit" class="submit-btn">완료</button>
			</form>
		</section>

		<!-- 모달 -->
		<div id="myModal" class="modal">
			<div class="modal-content">
				<p>변경 완료되었습니다.</p>
				<button class="modal-button" onclick="closeModal()">확인</button>
			</div>
		</div>

		<%@include file="/Includes/footer.jsp"%>
	</div>
</body>
</html>

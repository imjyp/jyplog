<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/516da99189.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/main.css">
<title>Sweet Home 중간 프로젝트</title>
<style >
/* .home {
	color: rgb(253, 78, 2) ;
	font-weight: 500 ;
} */

</style>
</head>

<body>
<div class="topmnbox">
	<div class="menu">
		<div class="mainmenu">
			<header class="header">
				<div class="header-left">
					<nav class="nav-menu">
						<ul>
							<li><a href="${contextPath}/main/main.do" class="logo">
									<img alt="" src="${contextPath}/images/logo.png">
							</a></li>
							<li ><a href="${contextPath}/gg.do" class="comm">커뮤니티</a></li>
							<li><a href="${contextPath}/prod/prodlist.do" class="msp">쇼핑</a></li>
						</ul>
					</nav>
				</div>
				<div class="header-center">
					<form action="${contextPath}/search/search.do" method="GET"
						style="display: flex; align-items: center;">
						<input type="text" class="search-bar" name="query"
							placeholder="통합검색" value="${param.query}" style="width: 300px;">
						<input type="hidden" name="category"
							value="${param.category != null && !param.category.isEmpty() ? param.category : 'all'}">
						<button type="submit" class="sbt">검색</button>
					</form>
				</div>
				<div class="header-right">
					<c:choose>

						<c:when test="${not empty sessionScope.loginUser}">
						
<%-- 							<a href="${contextPath}/wishlist.do" id="wishlist-icon" --%>
<!-- 								class="wishlist-btn"> <i class="fa-regular fa-heart"></i> -->
<!-- 							</a> -->
							
							<!-- 알림 아이콘 및 배지 -->
							<div class="notification-icon" id="notificationIcon">
								<img src="${contextPath}/images/icon2.png" class="icon"
									alt="알림">
								<!-- 기본적으로 배지를 숨김 상태로 두고, 알림이 오면 JavaScript에서 표시 -->
								<span class="notification-badge" id="notificationBadge"
									style="display: none;">0</span>
								<!-- 알림 개수 -->
							</div>
							<a href="${contextPath}/wishlist.do" id="wishlist-icon">
							<img src="${contextPath}/images/cart.png" class="icon" alt="장바구니">
							</a>
							<div class="id" id="userButton"
								onclick="toggleUserDropdown('userDropdownMenuUser')">
								${sessionScope.loginUser.mem_nick} 님 <a
									href="${contextPath}/member/logout.do">
									<button class="btnone">로그아웃</button>
								</a>
								<div id="userDropdownMenuUser" class="dropdown-menu">
									<ul>
										<li><a href="${contextPath}/mypage?action=mypage">마이페이지</a></li>
										<li><a href="${contextPath}/member/customer.do">고객센터</a></li>
									</ul>
								</div>
							</div>
						</c:when>

						<c:when test="${not empty sessionScope.loginAdmin}">
							<a href="${contextPath}/admin/memList.do" class="admin-button">통합 관리</a>
							<div class="id" id="adminButton"
								onclick="toggleUserDropdown('userDropdownMenuAdmin')">
								${sessionScope.loginAdmin.admin_nick} 님 <a
									href="${contextPath}/member/logout.do">
									<button class="btnone">로그아웃</button>
								</a>
								<div id="userDropdownMenuAdmin" class="dropdown-menu">
									<ul>
										<li><a href="${contextPath}/admin/memList.do">회원 관리</a></li>
										<li><a href="${contextPath}/member/customer.do?inquiry=1">1:1
												문의 답변</a></li>
									</ul>
								</div>
							</div>
						</c:when>

						<c:otherwise>
							<a href="${contextPath}/member/customer.do">
								<button class="btnone">고객센터</button>
							</a>
							<a href="${contextPath}/member/login.do">
								<button class="btnone">로그인</button>
							</a>
							<a href="${contextPath}/member/join.do">
								<button class="btnone">회원가입</button>
							</a>
						</c:otherwise>
					</c:choose>

					<div class="write">
						<button id="writeButton">글쓰기</button>
						<div id="writeDropdown" class="writedropdown-menu"
							style="display: none;">
							<ul>
								<li><a href="${contextPath}/postupload.do">집들이 작성</a></li>
							</ul>
						</div>
					</div>
				</div>
			</header>
		</div>
	</div>
</div>
	<script>
   document.addEventListener("DOMContentLoaded", function() {

	   // JSP에서 로그인 상태를 JavaScript 변수로 가져오기
	   const isLoggedIn = ${not empty sessionScope.loginUser || not empty sessionScope.loginAdmin ? 'true' : 'false'};

	   // 글쓰기 드롭다운 토글 함수
	   function toggleWriteDropdown() {
	       var dropdownMenu = document.getElementById('writeDropdown');
	       if (isLoggedIn) {
	           // 로그인 상태면 드롭다운 토글
	           if (dropdownMenu) {
	               dropdownMenu.style.display = dropdownMenu.style.display === 'none' || dropdownMenu.style.display === '' ? 'block' : 'none';
	           }
	       } else {
	           // 로그아웃 상태면 경고창 표시
	           alert("login해주세요~");
	       }
	   }

	   // 글쓰기 버튼 클릭 이벤트
	   var writeButton = document.getElementById("writeButton");
	   if (writeButton) {
	       writeButton.onclick = toggleWriteDropdown;
	   }
	});

    </script>

	<script src="${pageContext.request.contextPath}/resource/js/main.js"></script>

</body>
</html>

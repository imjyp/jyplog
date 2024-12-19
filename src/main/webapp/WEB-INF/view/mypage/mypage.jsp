<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로필 - 모두보기</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/tabs.css">

<style>
.profile-container {
	display: flex;
	margin: 20px;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.profile-info {
	width: 250px;
	border-right: 1px solid #ddd;
	padding: 20px;
	text-align: center;
}

.profile-info img {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	margin-bottom: 10px;
	object-fit: cover;
}

.profile-info h3 {
	margin: 10px 0;
	font-size: 1.2rem;
	color: #333;
}

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

.houses {
	 display: flex;
   flex-direction: column;
   padding: 60px;
   flex: 1;
   justify-content: flex-end;

}

.houses-title {
	font-size: 1.5rem;
	margin-bottom: 20px;
	font-weight: bold;
	color: #333;
}

.houses-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.house-item {
	flex: 1 1 calc(33.333% - 20px);
	background-color: #fff;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s, box-shadow 0.2s;
}

.house-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

.house-thumbnail img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.house-title {
	padding: 15px;
	text-align: center;
}

.house-title a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
	font-size: 1.1rem;
	display: block;
	height: 2.4em; /* 두 줄 높이 */
	line-height: 1.2em;
	overflow: hidden;
}

.item-writer {
	padding: 0 15px 15px 15px;
	text-align: center;
	font-size: 0.9rem;
	color: #666;
}

/* 반응형 디자인 */
@media ( max-width : 1200px) {
	.house-item {
		flex: 1 1 calc(50% - 20px);
	}
}

@media ( max-width : 768px) {
	.profile-container {
		flex-direction: column;
	}
	.profile-info {
		width: 100%;
		border-right: none;
		border-bottom: 1px solid #ddd;
	}
	.house-item {
		flex: 1 1 100%;
	}
}

.mpcontainer {
	max-width: 1590px;
	margin: 0 auto;
}

.mptab {
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
		<%@include file="/Includes/headermenu.jsp"%>
		<div class="mptab">
			<div class="tabs">
				<ul>
					<li><a href="mypage?action=mypage&mem_id=${member.mem_id}"
						class="${param.action == 'mypage' ? 'active' : ''}">프로필</a></li>
					<c:if test="${member.mem_id == loginUser.mem_id}">
						<!-- '나의 쇼핑' 링크가 orders 컨트롤러로 요청되도록 수정 -->
						<li><a href="${contextPath}/orders?action=list"
							class="${pageContext.request.servletPath == '/orders' ? 'active' : ''}">나의
								쇼핑</a></li>
						<li><a href="mypage?action=meminfo"
							class="${param.action == 'meminfo' ? 'active' : ''}">설정</a></li>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="mpcontainer">

			<div class="profile-container">
				<div class="profile-info">
					<img src="${contextPath}/images/profile.PNG" class="member-image">
					<h3 id="profileNickname">${member.mem_nick}</h3>
					<!-- 로그인한 사용자가 아닌 다른 사용자의 닉네임 표시 -->
				</div>

				<div class="houses">
					<div class="houses-title">${member.mem_nick} 님의 집들이 게시글</div>
					<!-- 다른 사용자의 닉네임 표시 -->
					<div class="houses-list">
						<c:choose>
							<c:when test="${not empty myPosts}">
								<c:forEach var="post" items="${myPosts}">
									<div class="house-item">
										<div class="house-thumbnail">
											<c:choose>
												<c:when test="${not empty post.path}">
													<img src="${contextPath}${post.path}" class="post-image"
														alt="게시글 이미지" loading="lazy">
												</c:when>
												<c:otherwise>
													<img src="${contextPath}/images/upload_files/img11.jpg"
														class="post-image" alt="기본 썸네일" loading="lazy">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="house-title">
											<a
												href="${contextPath}/boardDetail?board_no=${post.board_no}">
												${post.title} </a>
										</div>
										<div class="item-writer">${post.writer}</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<p>작성한 게시글이 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>

		<%@include file="/Includes/footer.jsp"%>
	</div>
</body>
</html>

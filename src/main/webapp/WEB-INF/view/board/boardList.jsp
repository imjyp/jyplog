<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Interior Design Listings</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">

<style>
.blwrapper {
	width: 100%;
	margin: 0 auto;
}

.wraptotal {
	margin-top: 20px;
	font-size: 18px;
	font-weight: bold;
	color: #333;
	text-align: center;
}

.board-listings {
	display: grid;
	grid-template-columns: repeat(3, 1fr); /* 3열 레이아웃 */
	gap: 20px;
	justify-content: center; /* 가운데 정렬 */
	margin-top: 10px;
}

.listing-card {
	width: 430px;
	border-radius: 5px;
	transition: transform 0.3s ease;
	text-align: center; /* 카드 내 텍스트 가운데 정렬 */
}

.listing-card:hover {
	transform: scale(1.02);
}

.board-info img {
	width: 100%;
	height: 280px;
	object-fit: cover;
	border-radius: 8px;
	margin-bottom: 10px; /* 이미지와 텍스트 간격 */
}

.board-title {
	font-size: 16px;
	font-weight: bold;
	color: #333;
	margin-top: 10px;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}

.board-writer {
	font-size: 14px;
	color: #666;
	margin-top: 5px;
}

.board-view-count {
	font-size: 14px;
	color: #999;
	margin-top: 5px;
}

.blist-description {
	font-size: 13px;
	color: #555;
	margin-top: 5px;
	height: 40px;
	overflow: hidden;
	text-overflow: ellipsis;
}

.line {
	margin: 10px 0;
	border: 0;
}

/* 텍스트와 이미지 모두 가운데 정렬 */
.listing-card div {
	text-align: center;
}

.deletepost {
	font-size: 20px;
}

.wraptotal {
	
}

.boardsort {
	text-align: left;
}

.posttotal {
	text-align: left;
	font-weight: 400;
	margin-bottom: 10px;
	font-size: 15px;
	color: rgb(66, 66, 66);
}

.blist {
	max-width: 1300px;
	margin: 0 auto;
}

.blmenu {
	width: 100%;
}

#sortOrder {
	outline: none;
	border: none;
	padding: 7px 4px 7px 3px;
	border-radius: 6px;
	margin: 20px 0 40px;
	width: max-content;
	background: #f3f3f3;
	color: #828C94;
	border-radius: 4px;
	font-size: 15px;
	line-height: 24px;
	font-size: 15px;
	font-weight: 700;
	height: 34px;
	padding: 0 3px;
}

#sortOrder::-ms-expand {
	display: none; /* Internet Explorer 기본 화살표 제거 */
}

.home {
	color: black !important;
}

.co {
	color: rgb(253, 78, 2) !important;
	font-weight: bold !important;
}
.comm{
color: rgb(253, 78, 2) !important;
	font-weight: bold !important;
}
</style>
</head>
<body>
	<div class="blwrapper">
		<%@ include file="/Includes/headermenu.jsp"%>
		<div class="blmenu">
			<%@ include file="/Includes/middlemenu.jsp"%>
		</div>
		<div class="blist">
			<div class="wraptotal">
				<div class="boardsort">
					<form action="${contextPath}/boardList" method="get" id="sortForm">
						<label for="sortOrder"></label> <select id="sortOrder"
							name="sortOrder" onchange="this.form.submit()">
							<option value="" disabled selected>정렬</option>
							<option value="date"
								<c:if test="${param.sortOrder == 'date'}">selected</c:if>>최신순</option>
							<option value="count"
								<c:if test="${param.sortOrder == 'count'}">selected</c:if>>조회수순</option>
						</select> <input type="hidden" name="boardcode_no" value="4"> </span>
					</form>
				</div>
				<div class="posttotal">전체 ${fn:length(boardList)} 개의 게시글</div>
			</div>

			<div class="board-listings">





				<c:choose>
					<c:when test="${not empty boardList}">
						<c:forEach var="board" items="${boardList}">
							<div class="listing-card">
								<div class="board-info">
									<c:if test="${not empty board.images}">
										<c:forEach var="imgpath" items="${board.images}">
											<img src="${contextPath}${imgpath}" alt="Board Image">
										</c:forEach>
									</c:if>
									<c:if test="${empty board.images}">
										<img src="${contextPath}/resource/images/no-image.png"
											alt="No Image">
									</c:if>
								</div>
								<div class="board-title">
									<a href="${contextPath}/boardDetail?board_no=${board.board_no}">${board.title}</a>
								</div>
								<div class="board-writer">작성자: ${board.writer}</div>
								<div class="board-view-count">조회수: ${board.board_cnt}</div>
								<hr class="line">
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="deletepost">게시글이 존재하지 않습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>

			<%@ include file="/Includes/footer.jsp"%>
		</div>
	</div>

	<script src="${contextPath}/resource/js/main.js"></script>
</body>
</html>

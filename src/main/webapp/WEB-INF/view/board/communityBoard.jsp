<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>    
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 게시판</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            color: #333;
        }

        .header, .sub-menu {
            padding: 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-menu ul {
            display: flex;
            list-style: none;
        }

        .nav-menu ul li {
            margin-right: 30px;
        }

        .nav-menu ul li a {
            text-decoration: none;
            color: #383838;
            font-size: 0.9rem;
        }

        .header-right button {
            background-color: #000;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 5px;
        }

        .sub-menu {
            display: flex;
            justify-content: space-around;
            border-bottom: 1px solid #ddd;
        }

        .sub-menu ul {
            display: flex;
            list-style: none;
        }

        .sub-menu ul li {
            margin-right: 20px;
        }

        .sub-menu ul li a {
            font-size: 0.8rem;
            color: #555;
        }

        .board-header {
            padding: 20px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .board-header h1 {
            font-size: 24px;
            font-weight: bold;
        }

        .sort-options {
            display: flex;
            align-items: center;
        }

        .sort-options select {
            margin-left: 10px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }

        .feed-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        .feed-item {
            width: 30%;
            background-color: #f9f9f9;
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
        }

        .feed-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
        }

        .feed-info {
            margin-top: 10px;
        }

        .feed-info p {
            margin-bottom: 5px;
        }

        .feed-info .username {
            font-size: 14px;
            color: #007BFF;
        }

        .follow-btn {
            padding: 5px 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .icon-actions {
            display: flex;
            justify-content: space-around;
            padding: 10px 0;
            font-size: 1.2rem;
        }

        .icon-actions i {
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div class="header">
        <div class="nav-menu">
            <ul>
                <li><a href="${contextPath}/main/main.do">홈</a></li>
                <li><a href="${contextPath}/communityBoard.do">커뮤니티</a></li>
                <li><a href="#">쇼핑</a></li>
            </ul>
        </div>
        <div class="header-right">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <span>${sessionScope.loginUser.mem_nick}</span>
                    <a href="${contextPath}/member/logout.do">
                        <button>로그아웃</button>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${contextPath}/member/login.do">
                        <button>로그인</button>
                    </a>
                    <a href="${contextPath}/member/join.do">
                        <button>회원가입</button>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="sub-menu">
        <ul>
            <li><a href="${contextPath}/home.do">홈</a></li>
            <li><a href="${contextPath}/communityBoard.do" class="home">피드게시판</a></li>
            <li><a href="#">집들이</a></li>
            <li><a href="#">추천</a></li>
        </ul>
    </div>

    <div class="board-header">
        <h1>피드게시판</h1>
        <div class="sort-options">
            <label for="sort">정렬:</label>
            <select id="sort" name="sort">
                <option value="latest">최신순</option>
                <option value="view">조회수 순</option>
                <option value="like">좋아요 순</option>
            </select>
        </div>
    </div>

    <div class="feed-container">
        <div class="feed-item">
            <img src="https://via.placeholder.com/150" alt="게시글 이미지">
            <div class="feed-info">
                <p class="username">회원 닉네임: 팔로우</p>
                <p>회원정보: 골드회원</p>
            </div>
            <div class="icon-actions">
                <i class="far fa-heart"></i>
                <i class="far fa-comment"></i>
                <i class="far fa-bookmark"></i>
            </div>
            <button class="follow-btn">팔로우</button>
        </div>

        <!-- 여러 개의 feed-item을 추가로 배치 -->
        <div class="feed-item">
            <img src="https://via.placeholder.com/150" alt="게시글 이미지">
            <div class="feed-info">
                <p class="username">회원 닉네임: 팔로우</p>
                <p>회원정보: 골드회원</p>
            </div>
            <div class="icon-actions">
                <i class="far fa-heart"></i>
                <i class="far fa-comment"></i>
                <i class="far fa-bookmark"></i>
            </div>
            <button class="follow-btn">팔로우</button>
        </div>

        <!-- 더 많은 피드 아이템 추가 -->
    </div>
</body>

</html>

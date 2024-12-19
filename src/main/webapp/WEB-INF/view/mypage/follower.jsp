<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팔로워 목록</title>
    
    <!-- Linking your custom stylesheet for styling consistency -->
    <link rel="stylesheet" href="${contextPath}/resource/css/main.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        /* Main Navigation */
        .main-nav {
            display: flex;
            gap: 20px;
            padding: 10px 20px;
            background-color: #f4f4f4;
            justify-content: center;
            border-bottom: 1px solid #ddd;
        }

        .main-nav a {
            text-decoration: none;
            color: black;
            padding: 5px 10px;
            font-weight: bold;
        }

        .main-nav a.active {
            color: #00c7ae;
            border-bottom: 2px solid #00c7ae;
        }

        /* Sub Navigation */
        .sub-nav {
            display: flex;
            justify-content: center;
            padding: 10px;
            background-color: white;
            border-bottom: 1px solid #ddd;
        }

        .sub-nav a {
            text-decoration: none;
            color: black;
            padding: 5px 10px;
        }

        .sub-nav a.active {
            color: #00c7ae;
            border-bottom: 2px solid #00c7ae;
        }

        .follower-list {
            margin: 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }

        .follower-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .follower-item:last-child {
            border-bottom: none;
        }

        .follower-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .follower-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #ddd;
        }

        .follow-button {
            color: #007bff;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 14px;
        }

        .following-button {
            color: #28a745;
            border: none;
            background: none;
            cursor: default;
            font-size: 14px;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #f4f4f4;
            font-size: 12px;
            color: #888;
        }
    </style>
    
    <script>
        function followUser(followingId, button) {
            const followerId = <%= session.getAttribute("userId") %>; // 현재 로그인된 사용자 ID

            fetch('mypage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `action=follow&followerId=${followerId}&followingId=${followingId}`
            }).then(response => {
                if (response.ok) {
                    button.innerText = "팔로잉";
                    button.className = "following-button";
                }
            });
        }

        function unfollowUser(followingId, button) {
            const followerId = <%= session.getAttribute("userId") %>; // 현재 로그인된 사용자 ID

            fetch('mypage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `action=unfollow&followerId=${followerId}&followingId=${followingId}`
            }).then(response => {
                if (response.ok) {
                    button.innerText = "팔로우";
                    button.className = "follow-button";
                }
            });
        }
    </script>
</head>
<body>
    <header class="header">
        <div class="header-left">
            <nav class="nav-menu">
                <ul>
                    <li><a href="${contextPath}/main/main.do" class="logo">
                        <img alt="" src="${contextPath}/images/logo.png">
                    </a></li>
                    <li><a href="${contextPath}/gg.do">커뮤니티</a></li>
                    <li><a href="${contextPath}/prod/prodlist.do">쇼핑</a></li>
                </ul>
            </nav>
        </div>
        <div class="header-center">
            <!-- 검색바 -->
            <form action="${contextPath}/search/search.do" method="GET" style="display: flex; align-items: center;">
                <input type="text" class="search-bar" name="query" placeholder="통합검색" value="${param.query}" style="width: 300px;">
                <button type="submit" style="padding: 6px 10px;">검색</button>
            </form>
        </div>
        <div class="header-right">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <span class="id">${sessionScope.loginUser.mem_nick} 님</span>
                    <a href="${contextPath}/member/logout.do">
                        <button class="btnone">로그아웃</button>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${contextPath}/member/login.do">
                        <button class="btnone">로그인</button>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <div class="main-nav">
        <a href="mypage?action=mypage" class="active">프로필</a>
        <a href="mypage?action=order">나의 쇼핑</a>
        <a href="mypage?action=meminfo">설정</a>
        <a href="#">리뷰</a>
    </div>

    <!-- Sub Navigation -->
    <div class="sub-nav">
        <a href="mypage?action=mypage">모두보기</a>
        <a href="mypage?action=follower" class="active">팔로워</a>
        <a href="mypage?action=following">팔로잉</a>
        <a href="mypage?action=bookmark">북마크</a>
    </div>

    <section class="follower-list">
        <h2>팔로워</h2>
        <div class="follower-item">
            <div class="follower-info">
                <img src="${contextPath}/images/profile.PNG" alt="팔로워 이미지">
                <span>스윈호텔</span>
            </div>
            <button class="follow-button" onclick="followUser(1, this)">팔로우</button>
        </div>
        <div class="follower-item">
            <div class="follower-info">
                <img src="${contextPath}/images/profile.PNG" alt="팔로워 이미지">
                <span>스윈호텔01</span>
            </div>
            <button class="follow-button" onclick="followUser(2, this)">팔로우</button>
        </div>
        <div class="follower-item">
            <div class="follower-info">
                <img src="${contextPath}/images/profile.PNG" alt="팔로워 이미지">
                <span>스윈호런</span>
            </div>
            <button class="follow-button" onclick="followUser(3, this)">팔로우</button>
        </div>
        <div class="follower-item">
            <div class="follower-info">
                <img src="${contextPath}/images/profile.PNG" alt="팔로워 이미지">
                <span>스윈호다터</span>
            </div>
            <button class="follow-button" onclick="followUser(4, this)">팔로우</button>
        </div>
        <div class="follower-item">
            <div class="follower-info">
                <img src="${contextPath}/images/profile.PNG" alt="팔로워 이미지">
                <span>스윈호네7</span>
            </div>
            <button class="follow-button" onclick="followUser(5, this)">팔로우</button>
        </div>
    </section>

    <footer>
        Copyright 2014. bucketplace, Co., Ltd. All rights reserved.
    </footer>
</body>
</html>
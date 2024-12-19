<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북마크 - 모두보기</title>
    
    <!-- Linking your custom stylesheet for styling consistency -->
    <link rel="stylesheet" href="${contextPath}/resource/css/main.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        /* Header Menu */
        .dropdown-menu {
            display: none;
            background-color: #f9f9f9;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            padding: 10px;
            border-radius: 5px;
        }

        .dropdown-menu ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .dropdown-menu ul li {
            padding: 8px 12px;
        }

        .dropdown-menu ul li a {
            text-decoration: none;
            color: black;
        }

        .dropdown-menu ul li:hover {
            background-color: #ddd;
        }

        .id {
            cursor: pointer;
            display: inline-block;
            padding: 5px 10px;
            position: relative;
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

        /* Bookmark Section */
        .bookmark-section {
            margin: 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }

        .bookmark-category {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .bookmark-category h3 {
            margin: 0;
            font-size: 16px;
        }

        .bookmark-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px 0;
        }

        .bookmark-item {
            background-color: #e0e0e0;
            height: 100px;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .bookmark-item .info {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
            color: #333;
        }

        .info a {
            color: #007bff;
            text-decoration: none;
            font-size: 12px;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #f4f4f4;
            font-size: 12px;
            color: #888;
        }
    </style>
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
        <a href="mypage?action=follower">팔로워</a>
        <a href="mypage?action=following">팔로잉</a>
        <a href="mypage?action=bookmark" class="active">북마크</a>
    </div>

    <section class="bookmark-section">
        <div class="bookmark-category">
            <h3>피드 <span style="font-weight: normal; color: #888;">전체 13</span></h3>
        </div>
        <div class="bookmark-grid">
            <div class="bookmark-item">
                <div class="info">
                    <p>회원 닉네임</p>
                    <a href="#">팔로우</a>
                </div>
            </div>
            <div class="bookmark-item">
                <div class="info">
                    <p>회원 닉네임</p>
                    <a href="#">팔로우</a>
                </div>
            </div>
            <div class="bookmark-item">
                <div class="info">
                    <p>회원 닉네임</p>
                    <a href="#">팔로우</a>
                </div>
            </div>
            <div class="bookmark-item">
                <div class="info">
                    <p>회원 닉네임</p>
                    <a href="#">팔로우</a>
                </div>
            </div>
        </div>

        <div class="bookmark-category">
            <h3>집들이 <span style="font-weight: normal; color: #888;">전체 4</span></h3>
        </div>
        <div class="bookmark-grid">
            <div class="bookmark-item">
                <div class="info">
                    <p>제목</p>
                </div>
            </div>
            <div class="bookmark-item">
                <div class="info">
                    <p>제목</p>
                </div>
            </div>
            <div class="bookmark-item">
                <div class="info">
                    <p>제목</p>
                </div>
            </div>
            <div class="bookmark-item">
                <div class="info">
                    <p>제목</p>
                </div>
            </div>
        </div>
    </section>

    <footer>
        Copyright 2014. bucketplace, Co., Ltd. All rights reserved.
    </footer>
</body>
</html>

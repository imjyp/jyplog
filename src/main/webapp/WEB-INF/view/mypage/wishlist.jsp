<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>위시리스트</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        header {
            background-color: #fff;
            color: #333;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
        }

        .header-left, .header-right {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .header-right button {
            padding: 6px 12px;
            border: none;
            background-color: #00c7ae;
            color: white;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.9rem;
        }

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

        /* 하위 네비게이션 */
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

        .wishlist-section {
            margin: 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }

        .wishlist-category {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .wishlist-category h3 {
            margin: 0;
            font-size: 16px;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px 0;
        }

        .wishlist-item {
            background-color: #e0e0e0;
            height: 100px;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .wishlist-item .info {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
            color: #333;
        }

        .new-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: red;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 4px;
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
<%@include file="/Includes/headermenu.jsp"%>
    <header>
        <div class="header-left">
            <span>LOGO</span>
            <nav class="nav-menu">
                <ul>
                    <li><a href="#">커뮤니티</a></li>
                    <li><a href="#">쇼핑</a></li>
                    
                </ul>
            </nav>
        </div>
        <div class="header-right">
           
            <button>고객센터</button>
            <button>글쓰기</button>
        </div>
    </header>

  <div class="main-nav"> 
        <a href="mypage?action=mypage">프로필</a> <!-- 프로필 페이지로 이동 -->
        <a href="mypage?action=order" class="active">나의 쇼핑</a>
        <a href="mypage?action=meminfo">설정</a>
        <a href="#">리뷰</a>
    </div>

    <!-- 하위 네비게이션 -->
    <div class="sub-nav">
        <a href="mypage?action=order" >주문배송목록</a>
        <a href="mypage?action=wishlist" class="active">위시리스트</a>
    </div>

    <section class="wishlist-section">
        <div class="wishlist-category">
            <h3>상품 <span style="font-weight: normal; color: #888;">전체 7</span></h3>
        </div>
        <div class="wishlist-grid">
            <div class="wishlist-item">
                <span class="new-badge">New</span>
                <div class="info">
                    <p>상품명</p>
                </div>
            </div>
            <div class="wishlist-item">
                <span class="new-badge">New</span>
                <div class="info">
                    <p>상품명</p>
                </div>
            </div>
            <div class="wishlist-item">
                <div class="info">
                    <p>상품명</p>
                </div>
            </div>
            <div class="wishlist-item">
                <div class="info">
                    <p>상품명</p>
                </div>
            </div>
            <div class="wishlist-item">
                <div class="info">
                    <p>상품명</p>
                </div>
            </div>
            <div class="wishlist-item">
                <div class="info">
                    <p>상품명</p>
                </div>
            </div>
            <div class="wishlist-item">
                <div class="info">
                    <p>상품명</p>
                </div>
            </div>
        </div>
    </section>

    <footer>
        Copyright 2014. bucketplace, Co., Ltd. All rights reserved.
    </footer>
</body>
</html>

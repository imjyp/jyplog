<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팔로잉 목록</title>
    
    <!-- 동일한 CSS 파일 사용 -->
    <link rel="stylesheet" href="${contextPath}/resource/css/main.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        /* Bookmark 페이지와 동일한 네비게이션 및 메뉴 스타일 */
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

        /* 팔로잉 목록 스타일 */
        .following-list {
            margin: 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }

        .following-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .following-item:last-child {
            border-bottom: none;
        }

        .following-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .following-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #ddd;
        }

        .follow-button {
            background-color: #00c7ae;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .follow-button.following {
            background-color: #bbb;
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
    <!-- 동일한 헤더 구조 복사 -->
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

    <!-- 동일한 메인 네비게이션 -->
    <div class="main-nav">
        <a href="mypage?action=mypage" class="active">프로필</a>
        <a href="mypage?action=order">나의 쇼핑</a>
        <a href="mypage?action=meminfo">설정</a>
        <a href="#">리뷰</a>
    </div>

    <!-- 동일한 서브 네비게이션 -->
    <div class="sub-nav">
        <a href="mypage?action=mypage">모두보기</a>
        <a href="mypage?action=follower">팔로워</a>
        <a href="mypage?action=following" class="active">팔로잉</a>
        <a href="mypage?action=bookmark">북마크</a>
    </div>

    <!-- 팔로잉 목록 -->
    <section class="following-list">
        <h2>팔로잉</h2>

        <c:forEach var="following" items="${followingList}">
            <div class="following-item">
                <div class="following-info">
                    <img src="${contextPath}/images/profile.PNG" alt="팔로잉 로고">
                    <span>${following.mem_nick}</span>
                </div>
                <button class="follow-button ${following.isFollowing ? 'following' : ''}" 
                        onclick="toggleFollow('${following.mem_nick}', this)">
                    ${following.isFollowing ? '언팔로우' : '팔로우'}
                </button>
            </div>
        </c:forEach>

        <c:if test="${empty followingList}">
            <div class="following-item">
                <span>팔로우한 사용자가 없습니다.</span>
            </div>
        </c:if>
    </section>

    <footer>
        Copyright 2014. bucketplace, Co., Ltd. All rights reserved.
    </footer>

    <!-- JavaScript 추가 -->
    <script>
        function toggleFollow(writer, button) {
            const followerId = '<%=session.getAttribute("mem_id")%>';
            const action = button.innerText === '팔로우' ? 'follow' : 'unfollow';

            fetch('${contextPath}/mypage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `action=${action}&followerId=${followerId}&followingId=${writer}`
            })
            .then(response => {
                const contentType = response.headers.get("content-type");
                if (contentType && contentType.indexOf("application/json") !== -1) {
                    return response.json();
                } else {
                    throw new Error("서버에서 HTML 페이지가 반환되었습니다.");
                }
            })
            .then(data => {
                if (data.success) {
                    // 팔로우 상태를 토글
                    if (action === 'follow') {
                        button.innerText = '언팔로우';
                        button.classList.add('following');
                    } else {
                        button.innerText = '팔로우';
                        button.classList.remove('following');
                    }
                } else {
                    alert('팔로우/언팔로우 실패');
                }
            })
            .catch(error => {
                console.log('Error:'+ error);
                alert("서버 오류 발생");
            });
        }
    </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'/>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합 검색 결과</title>
    <link rel="stylesheet" href="${contextPath}/resource/css/main.css">
    <link rel="stylesheet" href="${contextPath}/resource/css/tabs.css">

    <style>
        * {
            box-sizing: border-box;
        }

        .header-t {
            font-weight: bold;
            font-size: 1.7rem;
            padding-top: 40px;
            margin-top: 10px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        /* 공통 스타일 설정 */
        .search-container {
            width: 80%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        /* 카테고리 제목 스타일 */
        .search-category {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
        }

        .category-title {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .sort-dropdown {
            display: inline-block;
            margin-right: 20px;
        }

        .sort-dropdown select {
            padding: 5px;
            font-size: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* 상품 목록, 회원 목록, 게시글 목록 스타일 */
        .product-list,
        .member-list,
        .post-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 20px;
        }

        /* 개별 아이템 스타일 (상품, 회원, 게시글 공통) */
        .item {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            flex: 1 1 calc(25% - 20px);
            max-width: calc(25% - 20px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            text-align: center;
            margin: 10px;
            width: 100%;
        }

        .item:hover {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        /* 아이템 이미지 */
        .product-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        /* 아이템 제목 */
        .item-title {
            font-size: 14px;
            font-weight: bold;
            color: rgb(47, 52, 56);
            overflow: hidden;
            line-height: 1.5;
            margin-bottom: 5px;
        }

        /* 게시글 작성자 */
        .item-writer {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }

        /* 상품 가격 */
        .product-price {
            font-size: 12px;
            color: #ff5722;
            margin-top: 5px;
        }

        /* 상품 조회수 */
        .product-view,
        .board-view {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }

        /* 회원 목록 이미지 크기 및 정렬 */
        .member-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 10px;
        }


        /* 탭 스타일 */
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
        
        /* 위시리스트 버튼 */
		.wishlist-btn {
		    background: none;
		    border: none;
		    cursor: pointer;
		    font-size: 20px;
		    color: #ff6666; /* 기본 색상 */
		    transition: color 0.3s ease;
		    display: flex; /* 중앙 정렬을 위한 flexbox */
		    align-items: center; /* 수직 가운데 정렬 */
		    justify-content: center; /* 수평 가운데 정렬 */
		    width: 100%; /* 부모 요소에서 너비를 채우게 설정 */
		}
		
		.wishlist-btn:hover {
		    color: #ff0000; /* 호버 시 색상 변경 */
		}
		
		.wishlist-btn .wished {
		    filter: grayscale(0);  /* 위시리스트에 추가된 상태 */
		}
		.icon wished,
		.icon {
			width: 24px; !important;
		    height: 24px; !important;
		    filter: grayscale(100%);  /* 위시리스트에 추가되지 않은 상태 */
		}
		
		.wishlist-btn:hover img {
		    filter: grayscale(0);  /* 호버 시 색상을 표시 */
		}
		
		.scontainer {
			max-width: 1590px;
			margin: 0 auto;
		}
		
		.stab {
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
        <%@ include file="/Includes/headermenu.jsp" %>
        <%@ include file="/Includes/middlemenu.jsp" %>

		<div class="stab">
        <!-- 탭 메뉴 -->
        <div class="tabs">
            <ul>
                <li><a href="${contextPath}/search/search.do?category=all&query=${param.query}"
                        class="${param.category == 'all' ? 'active' : ''}">통합</a></li>
                <li><a href="${contextPath}/search/search.do?category=prod&query=${param.query}"
                        class="${param.category == 'prod' ? 'active' : ''}">상품</a></li>
                <li><a href="${contextPath}/search/search.do?category=board&query=${param.query}"
                        class="${param.category == 'board' ? 'active' : ''}">집들이 게시판</a></li>
                <li><a href="${contextPath}/search/search.do?category=member&query=${param.query}"
                        class="${param.category == 'member' ? 'active' : ''}">회원</a></li>
            </ul>
        </div>
</div>
	<div class="scontainer">
        <main>
            <div class="search-container">

                <h1 class="header-t">'${query}'에 대한 통합 검색 결과</h1>

                <!-- 상품 검색 결과 -->
                <div class="section product-section"
                    style="display: ${param.category == 'prod' || param.category == 'all' ? 'block' : 'none'};">
                    <div class="search-category">
                        <span class="category-title">상품</span>

                        <!-- 통합 카테고리일 때는 더보기 링크만 표시 -->
                        <c:if test="${param.category == 'all'}">
                            <a href="${contextPath}/search/search.do?category=prod&query=${param.query}"
                                class="${param.category == 'prod' ? 'active' : ''}"
                                style="font-size: 1rem;">더보기</a>
                        </c:if>

                        <!-- 상품 카테고리일 때는 정렬 드롭다운만 표시 -->
                        <c:if test="${param.category == 'prod'}">
                            <div class="sort-dropdown">
                                <label for="sortOptions">정렬 </label>
                                <select id="sortOptions" name="sortOptions"
                                    onchange="location.href='${contextPath}/search/search.do?category=prod&query=${param.query}&sort=' + this.value;">
                                    <option value="price_high" ${param.sort == 'price_high' ? 'selected' : ''}>가격 높은 순</option>
                                    <option value="price_low" ${param.sort == 'price_low' ? 'selected' : ''}>가격 낮은 순</option>
                                    <option value="views" ${param.sort == 'views' ? 'selected' : ''}>조회수 순</option>
                                </select>
                            </div>
                        </c:if>
                    </div>

                    <div class="product-list">
                        <c:choose>
                            <c:when test="${not empty productResults}">
                                <c:forEach var="prod" items="${productResults}">
                                    <div class="item">
                                        <a href="${contextPath}/prod/prodDetail.do?prod_no=${prod.prod_no}">
                                            <img src="${contextPath}${prod.path}" class="product-image" alt="${prod.prod_name}">
                                        </a>
                                        <div class="item-header">
                                            <div class="item-title">
                                                <a href="${contextPath}/prod/prodDetail.do?prod_no=${prod.prod_no}">${prod.prod_name}</a>
                                            </div>
                                        </div>
                                        <div class="product-price">${prod.prod_price}원</div>
                                        <div class="product-view">조회수 ${prod.prod_click_cnt}</div>
                                        <div class="wishlist">
                                            <c:if test="${not empty prod.prod_no}">
										    <button type="button" id="wishlist-icon-${prod.prod_no}" onclick="toggleWishlist(${prod.prod_no})" class="wishlist-btn">
										        <c:choose>
										            <c:when test="${prod.wish_state == 2}">
										                <img src="${contextPath}/images/cart.png" class="icon wished" alt="장바구니 아이콘" style="width: 24px; height: 24px;">
										            </c:when>
										            <c:otherwise>
										                <img src="${contextPath}/images/cart.png" class="icon" alt="장바구니 아이콘" style="width: 24px; height: 24px;">
										            </c:otherwise>
										        </c:choose>
										    </button>
										</c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>상품 검색 결과가 없습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 집들이 게시판 검색 결과 -->
                <div class="section post-section"
                    style="display: ${param.category == 'board' || param.category == 'all' ? 'block' : 'none'};">
                    <div class="search-category">
                        <span class="category-title">집들이 게시판</span>

                        <!-- 통합 카테고리일 때는 더보기 링크만 표시 -->
                        <c:if test="${param.category == 'all'}">
                            <a href="${contextPath}/search/search.do?category=board&query=${param.query}"
                                class="${param.category == 'board' ? 'active' : ''}"
                                style="font-size: 1rem;">더보기</a>
                        </c:if>

                        <!-- 집들이 게시판일 때는 정렬 드롭다운만 표시 -->
                        <c:if test="${param.category == 'board'}">
                            <div class="sort-dropdown">
                                <label for="sortOptions">정렬 </label>
                                <select id="sortOptions" name="sortOptions"
                                    onchange="location.href='${contextPath}/search/search.do?category=board&boardcode=4&query=${param.query}&sort=' + this.value;">
                                    <option value="latest" ${param.sort == 'latest' ? 'selected' : ''}>최신순</option>
                                    <option value="views" ${param.sort == 'views' ? 'selected' : ''}>조회수 순</option>
                                </select>
                            </div>
                        </c:if>
                    </div>

                    <div class="post-list">
                        <c:choose>
                            <c:when test="${not empty boardResults}">
                                <c:forEach var="post" items="${boardResults}">
                                    <div class="item">
                                        <a href="${contextPath}/boardDetail?board_no=${post.board_no}">
                                            <img src="${contextPath}${post.path}" class="post-image" alt="${post.title}">
                                        </a>
                                        <div class="item-header">
                                            <div class="item-title">
                                                <a href="${contextPath}/boardDetail?board_no=${post.board_no}">${post.title}</a>
                                            </div>
                                        </div>
                                        <div class="item-writer">작성자 ${post.writer}</div>
                                        <div class="board-view">조회수 ${post.board_cnt}</div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>게시글 검색 결과가 없습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 회원 검색 결과 -->
                <div class="section member-section"
                    style="display: ${param.category == 'member' || param.category == 'all' ? 'block' : 'none'};">
                    <div class="search-category">
                        <span class="category-title">회원</span>
                        <!-- 통합 카테고리일 때는 더보기 링크만 표시 -->
                        <c:if test="${param.category == 'all'}">
                            <a href="${contextPath}/search/search.do?category=member&query=${param.query}"
                                class="${param.category == 'member' ? 'active' : ''}"
                                style="font-size: 1rem;">더보기</a>
                        </c:if>
                        <!-- 회원 카테고리일 때는 아무것도 표시하지 않음 -->
                    </div>
                    <div class="member-list">
				    <c:choose>
				        <c:when test="${not empty memberResults}">
				            <c:forEach var="member" items="${memberResults}">
				                <div class="item">
				                    <img src="${contextPath}/images/profile.PNG" class="member-image" alt="${member.mem_nick}">
				                    <div class="item-header">
				                        <div class="item-title">
				                            <!-- 로그인한 회원이거나 관리자라면 모든 프로필에 접근 가능 -->
				                            <c:choose>
				                                <c:when test="${not empty sessionScope.loginUser or not empty sessionScope.loginAdmin}">
				                                    <!-- 로그인된 회원과 관리자 모두 프로필 링크로 이동 -->
				                                    <a href="${contextPath}/mypage?mem_id=${member.mem_id}">${member.mem_nick}</a>
				                                </c:when>
				                                <c:otherwise>
				                                    <!-- 비로그인 상태에서는 프로필 링크를 비활성화하고 닉네임만 표시 -->
				                                    <span>${member.mem_nick}</span>
				                                </c:otherwise>
				                            </c:choose>
				                        </div>
				                    </div>
				                </div>
				            </c:forEach>
				        </c:when>
				        <c:otherwise>
				            <p>회원 검색 결과가 없습니다.</p>
				        </c:otherwise>
				    </c:choose>
				</div>

                </div>
            </div>
        </main>
</div>
        <%@ include file="/Includes/footer.jsp" %>
    </div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        function toggleWishlist(prod_no) {
            console.log("Product Number:", prod_no);
            const button = document.getElementById(`wishlist-icon-\${prod_no}`);
            if (!button) {
                console.error(`Element with ID wishlist-icon-\${prod_no} not found.`);
                return;
            }

            const isWished = button.querySelector('img').classList.contains('wished');
            const url = isWished ? `${contextPath}/wishlist/remove.do` : `${contextPath}/wishlist/add.do`;

            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `prod_no=\${prod_no}`
            })
            .then(response => {
               console.log('Response status:', response.status);
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('장바구니 업데이트에 실패했습니다.');
                }
            })
            .then(data => {
		        alert(data.message);
		        if (isWished) {
		            button.querySelector('img').classList.remove('wished');
		        } else {
		            button.querySelector('img').classList.add('wished');
		        }
		    })
            .catch(error => {
                alert('장바구니 기능은 로그인 후 사용가능합니다.');
                console.error('Error:', error);
            });
        }

        // 전역에서 toggleWishlist 함수를 사용할 수 있도록 설정
        window.toggleWishlist = toggleWishlist;
    });
    </script>
</html>

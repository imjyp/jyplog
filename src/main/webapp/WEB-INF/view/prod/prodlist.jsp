<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 리스트</title>

<!-- 외부 스타일 시트 및 폰트 아이콘 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<script src="https://kit.fontawesome.com/516da99189.js"
	crossorigin="anonymous"></script>

<style>
/* 기본 스타일 초기화 */
.msp {
	color: rgb(253, 78, 2) !important;
	font-weight: 500 !important;
}

.comm {
	color: black !important;
}
.sphome{color: rgb(253, 78, 2) !important;
	font-weight: 500 !important;
}


/* 내비게이션 메뉴 */
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
	font-size: 1rem;
}

/* 카테고리 사이드바 */
.wrap-content {
	display: flex;
	justify-content: space-between;
	/* 'spack-between' → 'space-between' 수정 */
	margin-top: 20px;
}

.sidebar {
	position: absolute;
	width: 200px;
	height: 100%;
	padding: 10px 20px;
	border-radius: 5px;
	margin-top: 1%;
}

.sidebar h2 {
	font-size: 20px;
	margin-bottom: 10px;
}

.sidebar ul {
	list-style-type: none;
	padding: 0;
}

.sidebar ul li {
	padding: 10px 0px 10px 0px;
}

.sidebar ul li a {
	flex: 1 0 0px;
	min-width: 0;
	font-size: 13px;
	line-height: 23px;
	white-space: nowrap;
	overflow: hidden;
	transition: opacity .1s;
	font-weight: 400 !important;
	font-size: 16px;
}

.sidebar ul li a:hover {
	color: rgb(157, 155, 154);
}

/* 메인 컨텐츠 */
.spcontent {
 display: block;
   /*             flex-grow: 1;
 */
   padding: 20px;
   margin-left: 20px;
   margin-top: 5%;
   max-width: 1500px;

}

.spcontent h2 {
text-align: center;
   margin-bottom: 20px;
   margin-left:180px;
   font-size: 24px;
   color: #333;

}

/* 상품 리스트 그리드 */
.product-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	gap: 20px;
	margin-left: 12%;
}

.product-item {
	background-color: #fff;
	padding: 15px;
	border-radius: 8px;
	text-align: center;
	transition: box-shadow 0.3s ease;
}

.product-item:hover {
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.product-item img {
	width: 100%;
	height: auto;
	border-radius: 5px;
	display: block;
	width: 100%;
	max-height: calc(-350px + 100vh);
	object-fit: cover;
	margin: 0 auto;
}

.product-name {
	font-size: 16px;
	margin: 10px 0;
	text-decoration: none;
	color: black;
	display: block;
}

.product-description {
	font-size: 14px;
	color: #666;
	margin-bottom: 10px;
}

.product-price {
	font-size: 18px;
	font-weight: bold;
	color: #ff5722;
}

.product-name:hover {
	text-decoration: underline;
	color: #007BFF;
}

/* 슬라이드 쇼 */
.wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 1590px;
	margin-top: 2.5%;
	margin-left: 10%;
}

.box2 {
	overflow: hidden;
	width: 1300px;
	height: 500px;
	border-radius: 10px;
}

.slide_box {
	display: flex;
	width: calc(1300px * 4);
	transition: 0.5s;
	height: 650px;
}

.slide_item {
	min-width: 1300px;
	box-sizing: border-box;
}



/* 아이콘의 위치 조정 */
.prev, .next {
/* 	position: absolute;
	top: 46%;
	transform: translateY(-50%); /* 세로 중앙에 맞추기 */
	font-size: 28px; /* 아이콘 크기 조정 */
	border-radius: 50%;
	cursor: pointer;
	color: white;
	z-index: 100;
 */}

.prev {
	left: 20.5%; /* 왼쪽 아이콘의 위치 */
}

.next {
	right: 13.1%; /* 오른쪽 아이콘의 위치 */
}

.prev:hover, .next:hover {
	color: rgb(253, 78, 2);
}

.fa-solid, .fas {
	font-family: "Font Awesome 6 Free" !important;
	font-weight: 900; . slide_item img { display : block;
	width: 100%;
	max-height: calc(-350px + 100vh);
	object-fit: cover;
	margin: 0 auto;
	height: 500px;
}

/* 위시리스트 버튼 */
.mainspp {
	max-width: 1590px !important;
	margin: 0 auto;
}


</style>
</head>
<body>
	<div class="body">
		<%@ include file="/Includes/headermenu.jsp"%>
		<%@ include file="/Includes/shoppingmiddlemenu.jsp"%>

		<!-- 슬라이드 쇼 -->
		<div class="mainspp">

			<div class="wrap-content">
				<!-- 카테고리 사이드바 -->
				<div class="sidebar">
					<h2>카테고리</h2>
					<ul>
						<c:forEach var="cate" items="${prodCateList}">
							<li class="nav-item"><a class="nav-link"
								href="${contextPath}/prod/prodlist.do?cate_no=${cate.cate_no}">
									${cate.cate_name} </a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="wrap">
					<div class="lricon">
						<div class="prev">
							<i class="fa-sharp fa-solid fa-arrow-left"></i>
						</div>
						<div class="next">
							<i class="fa-sharp fa-solid fa-arrow-right"></i>
						</div>
					</div>
					<div class="box2">
						<div class="slide_box">
							<div class="slide_item">
								<a href="${contextPath}/prod/prodDetail.do?prod_no=14"> <img
									src="${contextPath}/images/upload_files/img22.jpg" alt="1">
								</a>
							</div>
							<div class="slide_item">
								<a href="${contextPath}/prod/prodDetail.do?prod_no=12"> <img
									src="${contextPath}/images/kitchen-9071354_1280.jpg" alt="2">
								</a>
							</div>
							<div class="slide_item">
								<a href="${contextPath}/prod/prodDetail.do?prod_no=43"> <img
									src="${contextPath}/images/living-room-8578263_1280.jpg"
									alt="3">
								</a>
							</div>
							<div class="slide_item">
								<a href="${contextPath}/prod/prodDetail.do?prod_no=1"> <img
									src="${contextPath}/images/interior-design-2685512_1280.jpg"
									alt="4">
								</a>
							</div>
						</div>
					</div>
				</div>

				<!-- 카테고리 리스트 및 상품 리스트 -->

				<!-- 상품 리스트 -->
			</div>
			<div class="spcontent">
				<h2>상품 목록</h2>
				<div class="product-grid">
					<c:forEach var="prod" items="${prodList}">
						<div class="product-item">
							<a
								href="${contextPath}/prod/prodDetail.do?prod_no=${prod.prod_no}">
								<img src="${contextPath}${prod.path}" alt="${prod.prod_name}">
							</a> <a
								href="${contextPath}/prod/prodDetail.do?prod_no=${prod.prod_no}"
								class="product-name"> ${prod.prod_name} </a>
							<div class="product-description">${prod.prod_description}</div>
							<div class="product-price">${prod.prod_price}원</div>

							<c:if test="${not empty prod.prod_no}">
								<button type="button" id="wishlist-icon-${prod.prod_no}"
									onclick="toggleWishlist(${prod.prod_no})" class="wishlist-btn">
									<c:choose>
										<c:when test="${prod.wish_state == 2}">
											<img src="${contextPath}/images/cart.png" class="icon wished"
												alt="장바구니 아이콘">
										</c:when>
										<c:otherwise>
											<img src="${contextPath}/images/cart.png" class="icon"
												alt="장바구니 아이콘">
										</c:otherwise>
									</c:choose>
								</button>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<!-- 외부 자바스크립트 파일 -->
	<script src="${contextPath}/resource/js/main.js"></script>

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

        // 슬라이드 코드
        const prev = document.querySelector('.prev');
        const next = document.querySelector('.next');
        const slideBox = document.querySelector('.slide_box');
        const slide = document.querySelectorAll('.slide_item img');
        const slideLength = slide.length;
        let currentIndex = 0;

        slideBox.style.width = `\${1300 * slideLength}px`;

        const moveSlide = (index) => {
            slideBox.style.transform = `translateX(\${-index * 1300}px)`;
            currentIndex = index;
        };

        prev.addEventListener('click', () => {
            if (currentIndex !== 0) {
                moveSlide(currentIndex - 1);
            }
        });

        next.addEventListener('click', () => {
            if (currentIndex !== slideLength - 1) {
                moveSlide(currentIndex + 1);
            }
        });

        setInterval(() => {
            if (currentIndex !== slideLength - 1) {
                moveSlide(currentIndex + 1);
            } else {
                moveSlide(0);
            }
        }, 3000);
    });
</script>

	<%@ include file="/Includes/footer.jsp"%>
</body>
</html>
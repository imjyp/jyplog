<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>나의 쇼핑 내역</title>

<link rel="stylesheet" href="${contextPath}/resource/css/main.css">


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
	color: rgb(44, 45, 50);
	font-size: 1.1rem;
}

.tabs ul li a.active, .tabs ul li a:hover, .tabs ul li a:focus {
	color: rgb(253, 78, 2);
	font-weight: bold;
}

.houses {
	display: flex;
	flex-direction: column;
	padding: 20px;
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

.mspbox {
	max-width: 1500px;
	margin: 0 auto;
}

.order {
	background-color: #fff;
	padding: 20px 20px 0px 20px;
	border: 1px solid #cfcfcf;
	border-radius: 5px;
	margin-bottom: 20px;
	margin-top: 2%;
}

.order-title {
	font-size: 20px;
	line-height: 26px;
	font-weight: 500;
	margin-bottom: 20px;
	margin-top: 2%;
}

.order-item {
	border-bottom: 1px solid #eee;
	padding: 20px 0;
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

.order-item img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 8px;
	margin-right: 20px;
}

.order-info {
	flex: 1;
	display: flex;
	flex-direction: column;
}

.order-info p {
	font-size: 14px;
	margin: 5px 0;
	color: #333;
}

.order-info strong {
	font-size: 16px;
}

.order-actions {
	display: flex;
	align-items: center;
}

.order-actions button {
	background-color: #ff5722;
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 0.9rem;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.order-actions button:hover {
	background-color: #e64a19;
}

.order-header {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
	color: #999;
}

.order-header .delivery-check {
	color: #007BFF;
	font-size: 14px;
	cursor: pointer;
}

.order-header .delivery-check:hover {
	text-decoration: underline;
}

/* 반응형 스타일 */
@media ( max-width : 768px) {
	.order-item {
		flex-direction: column;
		align-items: flex-start;
	}
	.order-actions {
		margin-top: 15px;
	}
}

#pptext {
	color: rgb(253, 78, 2);
	font-weight: bold;
}

.oprice {
	display: flex;
}
.od{
display: flex;
padding-left: 5px;
}
</style>
<script>
        function cancelOrder(orderNo) {
            if (confirm('정말로 주문을 취소하시겠습니까?')) {
                fetch('${contextPath}/orders?action=cancel', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'orderNo=' + encodeURIComponent(orderNo)
                })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    if (data.success) {
                        location.reload();
                    }
                })
                .catch(error => {
                    alert('주문 취소 중 오류가 발생했습니다.');
                    console.error(error);
                });
            }
        }
    </script>

</head>
<body>
	<div class="body">
		<%@include file="/Includes/headermenu.jsp"%>

		<div class="mptab">
			<div class="tabs">
				<ul>
					<li><a href="${contextPath}/mypage?action=mypage"
						class="${param.action == 'mypage' ? 'active' : ''}" id="pptext">
							프로필 </a></li>
					<li><a href="${contextPath}/orders"
						class="${pageContext.request.servletPath == '/orders' ? 'active' : ''}">
							나의 쇼핑 </a></li>
					<li><a href="${contextPath}/mypage?action=meminfo"
						class="${param.action == 'meminfo' ? 'active' : ''}"> 설정 </a></li>
				</ul>
			</div>
		</div>
		<div class="mptab">
			<div class="tabs">
				<ul>
					<li><a href="${contextPath}/mypage?action=mypage"
						class="${param.action == 'mypage' ? 'active' : ''}" id="pptext">
							주문내역 </a></li>

				</ul>
			</div>
		</div>
		<div class="mspbox">
			<!-- 주문 목록 확인 -->
			<div class="order-title">나의 쇼핑 내역</div>
			<div class="order">
				<c:choose>
					<c:when test="${not empty orderDetails}">
						<c:set var="currentOrderNo" value="0" />
						<c:set var="currentProdNo" value="0" />
						<!-- 주문 목록 출력 -->
						<c:forEach var="orderDetail" items="${orderDetails}"
							varStatus="status">
							<!-- 주문 상태가 '주문취소'가 아닌 항목만 출력 -->
							<c:if test="${orderDetail.ORDER_STAT != '주문취소'}">
								<!-- 같은 주문 번호, 상품 번호인지 확인 -->
								<c:if
									test="${currentOrderNo != orderDetail.ORDER_NO || currentProdNo != orderDetail.PROD_NO}">
									<c:set var="currentOrderNo" value="${orderDetail.ORDER_NO}" />
									<c:set var="currentProdNo" value="${orderDetail.PROD_NO}" />

									<!-- 주문 및 상품 정보를 한 번만 출력 -->
									<section class="order-item">
										<img src="${contextPath}/${orderDetail.PATH}" alt="제품 이미지">
										<div class="order-info">
											<p>주문 상태: ${orderDetail.ORDER_STAT}</p>
											<div class="od">

												<h3>주문 번호: ${orderDetail.ORDER_NO}</h3>
												&nbsp;&nbsp;
												<fmt:formatDate value="${orderDetail.ORDER_DATE}"
													pattern="yyyy-MM-dd HH:mm:ss" />
											</div>


											<strong>${orderDetail.PROD_NAME}</strong>
											<p class="oprice">${orderDetail.ORDER_PRICE}원
												&nbsp;|&nbsp; ${orderDetail.ORDER_CNT}개</p>
											</p>
										</div>
										<div class="order-actions">
											<button onclick="cancelOrder(${orderDetail.ORDER_NO})">주문
												취소</button>
										</div>
									</section>
								</c:if>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<p>주문 내역이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<%@include file="/Includes/footer.jsp"%>
	</div>
</body>
</html>

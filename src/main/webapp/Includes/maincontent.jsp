<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mainContent.css"> 
</head>
<body>

		<main>
		 	<%@include file="./mainbn.jsp" %>
  



			<section class="popular-posts">
				<h2>추천 집들이 게시글</h2>
				<div class="post-items">
					<div class="post-item"><a href="${contextPath}/boardDetail?board_no=5"><img src="${contextPath}/images/upload_files/img11.jpg" alt="Slide 1"></a></div>
					<div class="post-item"><a href="${contextPath}/boardDetail?board_no=6"><img src="${contextPath}/images/upload_files/img17.jpg" alt="Slide 1"></a></div>
					<div class="post-item"><a href="${contextPath}/boardDetail?board_no=8"><img src="${contextPath}/images/upload_files/img14.jpg" alt="Slide 1"></a></div>
					<div class="post-item"><a href="${contextPath}/boardDetail?board_no=12"><img src="${contextPath}/images/upload_files/img16.jpg" alt="Slide 1"></a></div>
					<div class="post-item"><a href="${contextPath}/boardDetail?board_no=2"><img src="${contextPath}/images/upload_files/img19.jpg" alt="Slide 1"></a></div>
					<div class="post-item"><a href="${contextPath}/boardDetail?board_no=14"><img src="${contextPath}/images/upload_files/img15.jpg" alt="Slide 1"></a></div>
				</div>
			</section>

			<!-- 오늘의 딜 섹션 -->
			<div class="dsbox">
			<section class="deals-section">
				<h2>추천 상품</h2>
				<div class="deals-container">
					<div class="deal-item">
						<a href="${contextPath}/prod/prodDetail.do?prod_no=1"><img src="${contextPath}/images/조야 패브릭 호텔 침대프레임.PNG" alt="침대"></a>
						<div class="brand"><a href="${contextPath}/prod/prodDetail.do?prod_no=1">조야패브릭</a></div>
						<div class="description"><a href="${contextPath}/prod/prodDetail.do?prod_no=1">조야 패브릭 호텔 침대프레임</a></div>
						<div class="price">180,000원</div>
					</div>
					
					<div class="deal-item">
						<a href="${contextPath}/prod/prodDetail.do?prod_no=1"><img src="${contextPath}/images/uploadProdImg/서랍형 수납 침대프레임 SSSDQ.png" alt="하비비 본사">
						<div class="brand">하비비</div>
						<div class="description">서랍형 수납 침대프레임</div>
						<div class="price">109,000원</div>
					</div>
					<div class="deal-item">
						<a href="${contextPath}/prod/prodDetail.do?prod_no=1"><img src="${contextPath}/images/uploadProdImg/데이지 통서랍 LED조명 3단 벙커 수납 서랍 침대 1.PNG" alt="삼성전자"></a>
						<div class="brand">데이지</div>
						<div class="description">데이지 통서랍 LED조명 3단 벙커</div>
						<div class="price">650,000원</div>
					</div>
					<div class="deal-item">
						<a href="${contextPath}/prod/prodDetail.do?prod_no=1"><img src="${contextPath}/images/uploadProdImg/호텔식 모나코 편백아트월 LED조명 평상형 침대.png" alt="모던하우스"></a>
						<div class="brand">모나코</div>
						<div class="description">호텔식 모나코 편백아트월 LED조명 침대</div>
						<div class="price">239,000원</div>
					</div>
				
				</div>
			</section>
			</div>

		</main>
		<script src="${pageContext.request.contextPath}/resource/js/mainbn.js"></script>
</body>
</html>
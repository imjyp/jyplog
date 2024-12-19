<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.net.URLEncoder"%>

<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<style>
/* 기본 스타일 초기화 */
.msp {
   color: rgb(253, 78, 2) !important;
   font-weight: 500 !important;
}

.comm {
   color: black !important;
}

.sphome {
   color: rgb(253, 78, 2) !important;
   font-weight: 500 !important;
}

body {
   margin: 0 auto;
   background-color: #ffffff;
   color: #333;
}

/* 전체 컨테이너 */
.pdcontainer {
   display: flex;
   flex-direction: row;
   gap: 20px;
   max-width: 1300px;
   margin: 20px auto; /* 중앙 정렬 및 위쪽 여백 */
   background-color: #ffffff;
   padding: 20px;
   /* height:80vh; */
}

/* 이미지 갤러리 */
.image-gallery {
   flex: 2;
   margin-right: 20px;
   display: flex;
}

.image-gallery img {
   width: 100%;
   height: auto;
   border-radius: 10px;
}

.thumbnail-list {
   display: flex;
   flex-direction: column;
   margin-top: 10px;
   margin-left: 10px;
}

.thumbnail-list img {
   width: 60px;
   height: 60px;
   margin-bottom: 10px;
   cursor: pointer;
   border: 2px solid transparent;
}

.thumbnail-list img:hover {
   border: 2px solid #000;
}

/* 상품 정보 */
.product-info {
   flex: 1;
}

.product-info h1 {
   font-size: 24px;
   margin-bottom: 10px;
}

.product-info .price {
   font-size: 28px;
   color: red;
   margin-bottom: 20px;
   font-weight: bold;
}

/* 옵션 선택 */
.product-options {
   margin-top: 20px;
}

.product-options select {
   width: 100%;
   padding: 12px;
   margin-bottom: 15px;
   border: 1px solid #ddd;
   border-radius: 8px;
   background-color: #ffffff;
   font-size: 16px;
   box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
   appearance: none;
   transition: border-color 0.3s ease;
}

.product-options select:hover, .product-options select:focus {
   border-color: black;
   outline: none;
}

/* 구매 버튼 */
.product-info button {
   width: 44%;
   background-color: rgb(253, 78, 2);
   color: white;
   border: none;
   padding: 12px 0;
   font-size: 14px;
   cursor: pointer;
   margin-top: 10px;
   border-radius: 8px;
   transition: background-color 0.3s ease, transform 0.3s ease;
}

.product-info button:hover {
   background-color:black;
   transform: translateY(-2px);
}

/* 수량 선택 스타일 */
.quantity-control {
   display: flex;
   align-items: center;
   justify-content: space-between;
   width: 120px;
   padding: 10px;
   background-color: #f9f9f9;
   border: 1px solid #ddd;
   border-radius: 8px;
   margin-bottom: 15px;
   box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.quantity-control button {
   width: 30px;
   height: 30px;
   background-color: #ffffff;
   border: 1px solid #ddd;
   border-radius: 5px;
   font-size: 16px;
   font-weight: bold;
   cursor: pointer;
   transition: background-color 0.3s ease, color 0.3s ease;
   display: flex;
   justify-content: center;
   align-items: center;
}

.quantity-control button:hover {
   background-color: black; /* 호버 시 배경색 변경 */
   color: white; /* 호버 시 글자색 변경 */
}

.quantity-control input {
   text-align: center;
   border: none;
   width: 40px;
   font-size: 14px;
   font-weight: bold;
   background-color: #f9f9f9;
   color: #333;
}

/* 장바구니 및 바로 구매 버튼 스타일 */
.product-info button, .sidebar button {
   width: 44%;
   background-color: rgb(253, 78, 2);
   color: white;
   border: none;
   padding: 12px 0;
   font-size: 14px;
   cursor: pointer;
   margin-top: 10px;
   border-radius: 8px;
   transition: background-color 0.3s ease, transform 0.3s ease;
}

.product-info button:hover, .sidebar button:hover {
   background-color: black; /* 호버 시 배경색 */
   transform: translateY(-2px); /* 약간 위로 올라가는 효과 */
}

/* 사이드바 */
.pdsidebar {
   position: sticky;
   top: 14.3%;
   position: sticky;
}

.sidebar {
   width: 350px;
   padding: 20px;
   background-color: #f8f8f8;
   border: 1px solid #ddd;
   right: 0; /* 오른쪽 정렬 */
   /* 초기 위치 */
   z-index: 300;
   position: absolute;
   top: 0;
   height: 900px;
}

/* 사이드바 - 옵션 선택 */
.sidebar select {
   width: 100%;
   padding: 10px;
   margin-bottom: 20px;
   border: 1px solid #ccc;
   border-radius: 4px;
   background-color: white;
   font-size: 16px;
}

/* 사이드바 - 주문 금액 */
.order-summary {
   font-size: 18px;
   margin-bottom: 10px;
   font-weight: bold;
}

/* 사이드바 - 버튼 */
.sidebar button {
   width: 100%;
   padding: 12px;
   margin-bottom: 10px;
   font-size: 14px;
   color: white;
   background-color: rgb(253, 78, 2);
   border: none;
   border-radius: 5px;
   cursor: pointer;
   transition: background-color 0.3s ease, transform 0.3s ease;
}

.sidebar button:hover {
   background-color: black;
   transform: translateY(-2px);
}

/* 위시리스트 버튼 */
.wishlist-btn {
   text-align: center;
   color: rgb(253, 78, 2);
   font-size: 16px;
   margin-bottom: 20px;
   cursor: pointer;
   transition: color 0.3s;
}

.wishlist-btn:hover {
   color: #1d9bd1;
}

/* 탭 네비게이션 스타일 */
.tab-nav {
   display: flex;
   justify-content: space-around;
   border-top: 1px rgb(238, 238, 238) solid;
   border-bottom: 1px rgb(238, 238, 238) solid;
   padding: 10px 0;
   margin-top: 20px;
   position: sticky;
   z-index: 400;
   line-height: 20px;
   font-weight: 700;
   display: flex;
   margin: 0 auto;
   top: 8%;
   background-color: white;
}

.tab-nav a {
   text-decoration: none;
   color: #333;
   font-size: 16px;
   padding: 10px 20px;
   cursor: pointer;
}

.tab-nav a:hover {
   color: rgb(253, 78, 2);
}

.tab-nav a.active {
   border-bottom: 2px solid rgb(253, 78, 2);
   color: rgb(253, 78, 2);
}

/* 섹션 스타일 */
#product-description, #review-sectiony {
   padding: 100px 0px 100px 0px;
   margin: 0 auto;
   max-width: 1300px;
   border-bottom: 1px solid #ddd;
   height: 1000px;
}

#recommended-section {
 padding: 100px 0px 100px 0px;
   margin: 0 auto;
   max-width: 1300px;

}

.product-description h2, .review-section h2, .recommended-section h2 {
   font-size: 24px;
   margin-bottom: 20px;
}

.product-description>p {
   max-width: 800px;
}

#cart {
   color: rgb(253, 78, 2);
   background-color: white;
   border: 1px solid;
   border-color: rgb(253, 78, 2);
}

#cart-sidebar {
   color: rgb(253, 78, 2);
   background-color: white;
   border: 1px solid;
   border-color: rgb(253, 78, 2);
}

#cart :hover {
   background-color: #fffff0;
}

/* 수량 선택 부분 - 헤더 */
.quantity-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   padding: 5px 10px;
   background-color: #f9f9f9;
   border: 1px solid #ddd;
   border-radius: 8px;
   margin-bottom: 10px;
   box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); . quantity-header span {
   font-size : 14px;
   color: #333;
   font-weight: bold;
}

.close-btn {
   width: 25px;
   background: none;
   border: none;
   font-size: 16px;
   cursor: pointer;
   color: #999;
   transition: color 0.3s ease;
}

.close-btn:hover {
   color: #000;
}
/* 추천 상품 섹션 스타일 */
.recommended-section {
   padding: 20px;
   margin: 0 auto;
   max-width: 1300px;
}

.recommended-grid {
   display: grid;
   grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
   gap: 20px;
}

.recommended-item {
   background-color: #fff;
   padding: 15px;
   border-radius: 8px;
   text-align: left; /* 왼쪽 정렬 */
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
   transition: box-shadow 0.3s ease;
   display: flex;
}

.recommended-item:hover {
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.recommended-item img {
   width: 100%;
   height: auto;
   border-radius: 5px;
}

.recommended-name {
   font-size: 16px;
   margin: 10px 0;
   font-weight: bold;
   color: #333;
}

.recommended-price {
   font-size: 18px;
   font-weight: bold;
   color: #ff5722;
   margin: 5px 0;
}

.review-summary {
   display: flex;
   justify-content: space-between;
   align-items: center;
   margin-bottom: 30px;
}
/* 별점 입력 스타일 */
.star-rating {
   direction: rtl;
   display: inline-block;
   background-color: gray;
}

.star-rating input[type=radio] {
   display: none;
}

.star-rating label {
   color: #ddd;
   font-size: 25px;
   padding: 0;
   cursor: pointer;
}

.star-rating label:before {
   content: "★";
}

.star-rating input[type=radio]:checked ~ label {
   color: gold;
}

.star-rating label:hover, .star-rating label:hover ~ label {
   color: gold;
}

.review-item {
   padding: 10px;
   border-bottom: 1px solid #ddd;
}

.review-actions {
   margin-top: 10px;
}

.review-actions button {
   padding: 10px;
   border: none;
   outline: none;
   background-color: rgb(253, 78, 2);
   color: white;
   border-radius: 5px;
}

.reviewUpdateBtn {
   padding: 10px;
   border: none;
   outline: none;
   background-color: rgb(253, 78, 2);
   color: white;
   border-radius: 5px;
}

.review-actions button:hover {
   background-color: #1d9bd1;
}

#editReviewForm {
   margin-top: 20px;
   padding: 20px;
   border: 1px solid #ddd;
   border-radius: 8px;
   background-color: #f9f9f9;
}

.smenu {
   margin: 0 auto;
}

.srbox {
   background-color: gray;
}

.review-item {
   padding: 30px 0px 30px 0px;
}
.buyNow :hover{

background-color: black !imprtant;


}
</style>

</head>


<body>


   <%@ include file="/Includes/headermenu.jsp"%>
   <%@ include file="/Includes/shoppingmiddlemenu.jsp"%>


   <!-- 탭 네비게이션 -->
   <div class="prod-mcontent">

      <div class="pdcontainer">
         <div class="image-gallery">
            <!-- 메인 이미지 -->
            <img id="main-image" src="${contextPath}${prodDetail.imagePaths[0]}"
               alt="Main Image">
            <c:if test="${not empty prodDetail.imagePaths}">
               <div class="thumbnail-list">
                  <c:forEach var="imagePath" items="${prodDetail.imagePaths}">
                     <img alt="Thumbnail" src="${contextPath}${imagePath}"
                        onclick="changeImage('${contextPath}${imagePath}')">
                  </c:forEach>
               </div>
            </c:if>
         </div>

            <!-- 옵션 및 수량 선택 -->
            
      <div class="product-info">
         <!-- 상품명 -->
         <h1>${prodDetail.prod_name}</h1>
         <!-- 가격 -->
         <div class="price">${prodDetail.prod_price}원</div>
         <div>조회수: ${prodDetail.prod_click_cnt}</div>

         <!-- 옵션 및 수량 선택 -->
         <form action="${contextPath}/cart.do" method="POST" id="cartForm">
            <!-- 옵션 선택 -->
            <div class="product-options">
               <h3>옵션 선택</h3>
               <select id="prodOption" name="optionDetail"
                  onchange="setOptionPrice(this.options[this.selectedIndex])">
                  <option value="" disabled selected>옵션 선택</option>
                  <c:forEach var="option" items="${prodDetail.prodOptions}">
                     <option value="${option.prod_option_no}"
                        data-price="${option.prod_option_price}">
                        ${option.prod_option_detail} (${option.prod_option_price}원)</option>
                  </c:forEach>
               </select>
            </div>

            <!-- 본문 수량 선택 -->
            <div class="order-details" style="display: none;"
               id="quantity-section-main">
               <div class="quantity-header">
                  <span id="selected-option-text-main"></span>
                  <button type="button" class="close-btn"
                     onclick="hideQuantitySection()">x</button>
               </div>

               <div class="quantity-control">
                  <button type="button"
                     onclick="changeQuantity(-1, 'quantity-main')" class="changebtn">-</button>
                  <input type="number" id="quantity-main" name="quantity" value="1"
                     min="1" onchange="updateTotalPrice()" />
                  <button type="button" onclick="changeQuantity(1, 'quantity-main')"
                     class="changebtn">+</button>
               </div>
               <div class="total-price" id="total-price-main">0원</div>
            </div>

            <!-- hidden 필드로 상품 번호, 상품명 및 총 가격 전송 -->
            <input type="hidden" name="prodNo" value="${prodDetail.prod_no}">
            <input type="hidden" name="prodName" value="${prodDetail.prod_name}">
            <!-- 상품명 추가 -->
            <input type="hidden" name="totalPrice" id="hiddenTotalPrice">

            <!-- 장바구니 및 바로 구매 버튼 -->
            <div style="margin-top: 20px;">
               <button type="submit" id="cart">장바구니</button>
               <button type="submit" formaction="${contextPath}/order.do"
                  id="buyNow">바로 구매</button>
            </div>

            </form>
         </div>
      </div>

   </div>

   <div id="product-tabs" class="tab-nav">
      <a href="#product-description" class="tab-link active">상품정보</a> <a
         href="#reviews-section" class="tab-link">리뷰</a> <a
         href="#recommended-section" class="tab-link">추천</a>
   </div>
   <div class="pdsidebar">
      <div class="sidebar">
         <!-- 옵션 선택 -->
         <label for="prodOption-sidebar">옵션</label> <select
            id="prodOption-sidebar" name="optionDetail"
            onchange="setOptionPrice(this.options[this.selectedIndex])">
            <option value="" disabled selected>옵션 선택</option>
            <!-- 옵션 목록 -->
            <c:forEach var="option" items="${prodDetail.prodOptions}">
               <option value="${option.prod_option_no}"
                  data-price="${option.prod_option_price}">
                  ${option.prod_option_detail} (${option.prod_option_price}원)</option>
            </c:forEach>
         </select>

         <!-- 수량 선택 -->
         <div class="order-details" style="display: none;"
            id="quantity-section-sidebar">
            <div class="quantity-header">
               <span id="selected-option-text-sidebar"></span>
               <button type="button" class="close-btn"
                  onclick="hideQuantitySection()">x</button>
            </div>
            <div class="quantity-control">
               <button type="button"
                  onclick="changeQuantity(-1, 'quantity-sidebar')" class="changebtn">-</button>
               <input type="number" id="quantity-sidebar" name="quantity"
                  value="1" min="1" onchange="updateTotalPrice()" />
               <button type="button"
                  onclick="changeQuantity(1, 'quantity-sidebar')" class="changebtn">+</button>
            </div>
            <div class="total-price" id="total-price-sidebar">0원</div>
         </div>

         <!-- 주문 금액 표시 -->
         <div class="order-summary">
            주문 금액: <span id="orderAmount">0원</span>
         </div>

         <!-- 장바구니 및 바로 구매 버튼 -->
         <button type="button" class="cart-btn" id="cart-sidebar"
            onclick="submitCartForm()">장바구니</button>
         <button type="button" class="buy-btn" id="buyNow-sidebar"
            onclick="submitBuyForm()">바로 구매</button>

         <!-- 찜하기 버튼 -->
      
      </div>
   </div>
   <div class="prod-mcontent">
      <!-- 상품 설명 -->
      <div id="product-description" class="product-description">
         <h2>상품정보</h2>
         <p>${prodDetail.prod_description}</p>

      </div>
   </div>



   <!-- 리뷰 섹션 -->
   <div id="reviews-section" class="review-section">
      <h2>리뷰</h2>
      <!-- 로그인된 회원만 리뷰 작성 가능 -->
      <c:if test="${not empty sessionScope.loginUser}">
         <form action="${contextPath}/prod/prodDetail.do" method="post">
            <input type="hidden" name="action" value="insert">
            <!-- 상품 번호를 숨겨서 전송 -->
            <input type="hidden" name="prod_no" value="${prodDetail.prod_no}">
            <div class="srbox">
               <label>별점:</label>
               <div class="star-rating">
                  <input type="radio" id="star5" name="rating" value="5" required><label
                     for="star5">★★★★★</label> <input type="radio" id="star4"
                     name="rating" value="4"><label for="star4">★★★★</label> <input
                     type="radio" id="star3" name="rating" value="3"><label
                     for="star3">★★★</label> <input type="radio" id="star2"
                     name="rating" value="2"><label for="star2">★★</label> <input
                     type="radio" id="star1" name="rating" value="1"><label
                     for="star1">★</label>
               </div>
            </div>
            <div>
               <textarea id="content" name="content" rows="5" cols="50"
                  class="rcbox" required></textarea>
            </div>
            <button type="submit" class="rvupload">리뷰 등록</button>
         </form>
      </c:if>
      <c:if test="${empty sessionScope.loginUser}">
         <p>
            리뷰를 작성하려면 <a href="${contextPath}/member/login.do">로그인</a>이 필요합니다.
         </p>
      </c:if>


      <!-- 리뷰 리스트 표시 -->
      <c:if test="${not empty reviewList}">
         <c:forEach var="review" items="${reviewList}">
            <div class="review-item">
               <div class="review-rating">
                  <c:forEach begin="1" end="5" var="i">
                     <c:if test="${i <= review.rating}">
                        <span style="color: gold;">★</span>
                     </c:if>
                     <c:if test="${i > review.rating}">
                        <span style="color: #ddd;">★</span>
                     </c:if>
                  </c:forEach>
               </div>
               <div class="review-author">작성자: ${review.mem_nick}</div>
               <div class="review-date">작성일: ${review.date_of_pre}</div>
               <div class="review-content">${review.content}</div>
               <!-- 수정 및 삭제 버튼 (작성자 본인에게만 보임) -->
               <c:if
                  test="${sessionScope.loginUser != null && sessionScope.loginUser.mem_no == review.mem_no}">
                  <div class="review-actions">
                     <button 
                        onclick="showEditForm(${review.review_no}, ${review.rating}, '${review.content.replaceAll("'", "\\'")}')">수정</button>
                     <form action="${contextPath}/prod/prodDetail.do" method="post"
                        style="display: inline;">
                        <input type="hidden" name="action" value="delete"> <input
                           type="hidden" name="prod_no" value="${prodDetail.prod_no}">
                        <input type="hidden" name="review_no"
                           value="${review.review_no}">
                        <input type="hidden" name="mem_no" value="${sessionScope.loginUser.mem_no}">
                        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                     </form>
                  </div>
               </c:if>
            </div>
         </c:forEach>
      </c:if>
      <c:if test="${empty reviewList}">
         <p>등록된 리뷰가 없습니다.</p>
      </c:if>

      <!-- 리뷰 수정 폼 추가 -->
      <div id="editReviewForm" style="display: none;">
         <form action="${contextPath}/prod/prodDetail.do" method="post">
            <input type="hidden" name="action" value="update"> <input
               type="hidden" name="prod_no" value="${prodDetail.prod_no}">
            <input type="hidden" name="review_no" id="editReviewNo">
            <div>
               <label>별점:</label>
               <div class="star-rating">
                  <input type="radio" id="editStar5" name="rating" value="5"><label
                     for="editStar5">★★★★★</label> <input type="radio" id="editStar4"
                     name="rating" value="4"><label for="editStar4">★★★★</label>
                  <input type="radio" id="editStar3" name="rating" value="3"><label
                     for="editStar3">★★★</label> <input type="radio" id="editStar2"
                     name="rating" value="2"><label for="editStar2">★★</label>
                  <input type="radio" id="editStar1" name="rating" value="1"><label
                     for="editStar1">★</label>
               </div>
            </div>
            <br>
            <div>
               <label for="editContent">리뷰 내용:</label><br>
               <textarea id="editContent" name="content" rows="5" cols="50"
                  required></textarea>
            </div>
            <br>
            <div class="reviewUpdateBtn">
            <button type="submit">리뷰 수정</button>
            <button type="button" onclick="hideEditForm()">취소</button>
            </div>
         </form>
      </div>
   </div>
   <div id="recommended-section" class="recommended-section">
      <h2>추천 상품</h2>
      <div class="recommended-grid">
         <c:forEach var="recommended" items="${recommendedProd}" begin="0"
            end="3">
            <div class="recommended-item">
               <a
                  href="${contextPath}/prod/prodDetail.do?prod_no=${recommended.prod_no}">
                  <img src="${contextPath}${recommended.path}"
                  alt="${recommended.prod_name}">
               </a>
               <div class="recommended-name">${recommended.prod_name}</div>
               <div class="recommended-price">${recommended.prod_price}원</div>
            </div>
         </c:forEach>
      </div>


   </div>






   <!-- 추천 상품 섹션 -->


   <script src="${pageContext.request.contextPath}/resource/js/main.js"></script>
   <script>
   
   // 썸네일 이미지를 클릭할 때 메인 이미지를 변경하는 함수
    function changeImage(imagePath) {
        // 메인 이미지 요소를 찾음
        const mainImage = document.getElementById("main-image");
        
        // 메인 이미지의 src를 썸네일 이미지 경로로 변경
        if (mainImage) {
            mainImage.src = imagePath;
        }
    }
   
   document.addEventListener("DOMContentLoaded", function () {
      let selectedPrice = 0;
      
      

      function setOptionPrice(option) {
            selectedPrice = parseInt(option.getAttribute('data-price')) || 0;
            
         // 선택된 옵션 텍스트 설정
            const selectedOptionText = option.textContent || option.innerText;
         
         // 메인 섹션 및 사이드바에 선택된 옵션 이름 설정
            const selectedOptionTextMain = document.getElementById("selected-option-text-main");
            const selectedOptionTextSidebar = document.getElementById("selected-option-text-sidebar");
            
            if (selectedOptionTextMain) {
                selectedOptionTextMain.innerText = selectedOptionText;
            }
            if (selectedOptionTextSidebar) {
                selectedOptionTextSidebar.innerText = selectedOptionText;
            }
            
         // 수량 섹션 활성화 (메인 및 사이드바 모두)
            const quantitySectionMain = document.getElementById("quantity-section-main");
            const quantitySectionSidebar = document.getElementById("quantity-section-sidebar");
            
            if (quantitySectionMain) {
                quantitySectionMain.style.display = 'block';
            }
            if (quantitySectionSidebar) {
                quantitySectionSidebar.style.display = 'block';
            }
            // 수량 초기화
            const quantityMainElement = document.getElementById("quantity-main");
            const quantitySidebarElement = document.getElementById("quantity-sidebar");
            if (quantityMainElement) {
                quantityMainElement.value = 1; // 초기 수량을 1로 설정
            }
            if (quantitySidebarElement) {
                quantitySidebarElement.value = 1; // 초기 수량을 1로 설정
            }
            updateTotalPrice();
        }
      

      function updateTotalPrice() {
            // 메인 섹션의 수량과 총 금액 계산
            const quantityMainElement = document.getElementById("quantity-main");
            const quantitySidebarElement = document.getElementById("quantity-sidebar");

            if (quantityMainElement && quantitySidebarElement) {
                const quantity = parseInt(quantityMainElement.value) || 1;
                const totalPrice = selectedPrice * quantity;

                // 메인 섹션과 사이드바의 수량 및 총 금액을 모두 동기화
                quantityMainElement.value = quantity;
                quantitySidebarElement.value = quantity;

                document.getElementById("total-price-main").innerText = totalPrice.toLocaleString() + '원';
                document.getElementById("total-price-sidebar").innerText = totalPrice.toLocaleString() + '원';
                document.getElementById("orderAmount").innerText = totalPrice.toLocaleString() + '원';
                document.getElementById("hiddenTotalPrice").value = totalPrice;
            }
        }
      // 수량 증가/감소 버튼 클릭 시 수량 변경
        function changeQuantity(amount) {
            const quantityMainElement = document.getElementById("quantity-main");
            const quantitySidebarElement = document.getElementById("quantity-sidebar");

            if (quantityMainElement && quantitySidebarElement) {
                let quantity = parseInt(quantityMainElement.value) || 1;
                quantity += amount;
                if (quantity < 1) quantity = 1;

                // 메인 섹션과 사이드바의 수량을 동기화
                quantityMainElement.value = quantity;
                quantitySidebarElement.value = quantity;

                updateTotalPrice();
            }
        }

      
       // 장바구니 폼 제출
       function submitCartForm(){
           document.getElementById("cartForm").action = "${contextPath}/wishlist.do";
           document.getElementById("cartForm").submit();
       }

       // 바로 구매 폼 제출
       function submitBuyForm(){
           document.getElementById("cartForm").action = "${contextPath}/order.do";
           document.getElementById("cartForm").submit();
       }
       
       function hideQuantitySection() {
            // 본문 수량 선택 섹션 숨기기
            document.getElementById("quantity-section-main").style.display = 'none';

            // 사이드바 수량 선택 섹션 숨기기
            document.getElementById("quantity-section-sidebar").style.display = 'none';

            // 옵션 선택 초기화
            document.getElementById("prodOption").selectedIndex = 0;
            document.getElementById("prodOption-sidebar").selectedIndex = 0;

            // 선택한 옵션 텍스트 초기화
            document.getElementById("selected-option-text-main").innerText = '';
            document.getElementById("selected-option-text-sidebar").innerText = '';

            // 총 가격 초기화
            document.getElementById("total-price-main").innerText = '0원';
            document.getElementById("total-price-sidebar").innerText = '0원';
            document.getElementById("orderAmount").innerText = '0원';

            // 수량 초기화
            document.getElementById("quantity-main").value = 1;
            document.getElementById("quantity-sidebar").value = 1;
        }
    // 스크롤에 따라 사이드바가 움직이도록 추가
   /*    const sidebar = document.querySelector('.sidebar');
      const initialTop = sidebar.offsetTop;

      window.addEventListener('scroll', function() {
         let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

         if (scrollTop > initialTop) {
            sidebar.style.top = (scrollTop - initialTop + 20) + 'px'; // 스크롤 시 사이드바가 따라 올라가게 설정
         } else {
            sidebar.style.top = '20px'; // 원래 위치 유지
         }
      }); */

      
    // 탭 클릭 시 해당 섹션으로 부드럽게 스크롤 이동하는 기능
       document.querySelectorAll('.tab-link').forEach(link => {
           link.addEventListener('click', function (e) {
               e.preventDefault();
               
               // 모든 탭에서 active 클래스 제거
               document.querySelectorAll('.tab-link').forEach(item => item.classList.remove('active'));
               
               // 클릭한 탭에 active 클래스 추가
               this.classList.add('active');
               
               // 클릭한 링크의 href 속성으로 이동
               const sectionId = this.getAttribute('href');
               document.querySelector(sectionId).scrollIntoView({
                   behavior: 'smooth'
            });
         });
      });
      
      // 전역 함수로 설정하여 HTML에서 접근 가능하게 만듦
       window.setOptionPrice = setOptionPrice;
       window.changeQuantity = changeQuantity;
       window.submitCartForm = submitCartForm;
       window.submitBuyForm = submitBuyForm;
       window.hideQuantitySection = hideQuantitySection; // 여기서 함수 전역 설정 추가
   });
   // 리뷰 수정 폼 제어 함수 추가
    function showEditForm(reviewNo, rating, content) {
        // 폼 보이기
        document.getElementById('editReviewForm').style.display = 'block';

        // 기존 값 설정
        document.getElementById('editReviewNo').value = reviewNo;
        document.getElementById('editContent').value = content;

        // 별점 설정
        document.querySelectorAll('#editReviewForm input[name="rating"]').forEach(function(el) {
            if (el.value == rating) {
                el.checked = true;
            } else {
                el.checked = false;
            }
        });
    }

    function hideEditForm() {
        // 폼 숨기기 및 초기화
        document.getElementById('editReviewForm').style.display = 'none';
        document.getElementById('editReviewNo').value = '';
        document.getElementById('editContent').value = '';
        document.querySelectorAll('#editReviewForm input[name="rating"]').forEach(function(el) {
            el.checked = false;
        });
    }
    
   </script>

   <%@ include file="/Includes/footer.jsp"%>
</body>
</html>
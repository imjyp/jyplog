<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/516da99189.js" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

.header-spacing {
    margin-bottom: 30px;
}

.content {
    display: flex;
    justify-content: space-between;
    align-items: flex-end; /* 선택 삭제 버튼이 h2의 오른쪽 하단에 맞춰지도록 설정 */
    margin-top: 40px;
    margin-right: 20px;
}
 
h2 {
    margin-left: 20px;
}

.delete-button {
    padding: 6px 10px;
    border: none;
    color: white;
    background-color: rgb(253, 78, 2);
    border-radius: 3px;
    cursor: pointer;
    font-size: 1rem;
    margin-left: 40px;
    transition: background-color 0.3s ease;
}

.delete-button:hover {
    background-color: #e64a19;
}
       
.wishlist-page {
    display: grid;
    grid-template-columns: repeat(6, 1fr); /* 한 줄에 6개의 아이템 */
    gap: 20px; /* 아이템 사이에 20px의 간격 */
    margin-left: 0; /* 왼쪽 여백 제거 */
}

.wishlist-container {
    display: contents; /* 그리드 부모 컨테이너를 무시하고, 각 아이템을 직접 배치 */
}

.wishlist-item {
    background-color: #fff;
    padding: 15px;
    border-radius: 8px;
    text-align: center;
    transition: box-shadow 0.3s ease;
    width: 100%;
}

.wishlist-item:hover {
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}
	
.wishlist-item img {
    width: 100%;
    height: auto;
    border-radius: 5px;
    display: block;
    max-height: 200px; /* 이미지 최대 높이 설정 */
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

.product-price {
    font-size: 18px;
    font-weight: bold;
    color: #ff5722;
}

.product-name:hover {
    text-decoration: underline;
    color: #007BFF;
}
    
    .wlcontainer {
	max-width: 1590px;
	margin: 0 auto;
}
    
</style>
</head>
<body>

    <%@ include file="/Includes/headermenu.jsp"%>
    <%@ include file="/Includes/shoppingmiddlemenu.jsp"%>
    
<div class="body">
<div class="wlcontainer">
    <div class="content header-spacing">
    <h2>나의 장바구니</h2>
    <button class="delete-button"id="deleteSelectedButton" onclick="deleteSelected()">선택 삭제</button>
    </div>
    
    <div class="wishlist-page">
    <div class="wishlist-container">
        <c:forEach var="item" items="${wishList}">
            <div class="wishlist-item">
                <input type="checkbox" class="wishlist-checkbox" value="${item.prod_no}">
                <a href="${contextPath}/prod/prodDetail.do?prod_no=${item.prod_no}">
                    <img src="${contextPath}${item.prod_path}" alt="${item.prod_name}">
                </a>
                <a href="${contextPath}/prod/prodDetail.do?prod_no=${item.prod_no}" class="product-name">${item.prod_name}</a>
                <div class="product-price">${item.prod_price}원</div>
            </div>
	        </c:forEach>
	    </div>
	</div>
	</div>  
   <script>
    function deleteSelected() {
        const checkboxes = document.querySelectorAll('.wishlist-checkbox:checked');
        if (checkboxes.length === 0) {
            alert('삭제할 항목을 선택하세요.');
            return;
        }

        const formData = new URLSearchParams();
        checkboxes.forEach(checkbox => {
            formData.append('prod_no', checkbox.value);
        });

        if (!confirm('선택한 항목을 삭제하시겠습니까?')) {
            return;
        }

        fetch('/MiddleProject2/wishlist/deleteSelected.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData.toString()
        })
        .then(response => {
            if (response.ok) {
                alert('선택한 항목이 삭제되었습니다.');
                location.reload(); // 페이지 새로고침
            } else {
                throw new Error('삭제 요청에 실패했습니다.');
            }
        })
        .catch(error => {
            alert('네트워크 오류가 발생했습니다. 다시 시도해 주세요.');
            console.error('Error:', error);
        });
    }
</script>

    <%@ include file="/Includes/footer.jsp"%>
</div>
</body>
</html>

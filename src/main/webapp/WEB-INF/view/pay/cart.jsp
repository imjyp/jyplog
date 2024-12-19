<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        /* 장바구니 페이지 스타일 */
        body {
            font-family: 'Noto Sans KR', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 1200px;
            margin: 50px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: left;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f5f5f5;
        }
        .product-info {
            display: flex;
            align-items: center;
        }
        .product-info img {
            width: 80px;
            height: 80px;
            margin-right: 10px;
            border-radius: 8px;
        }
        .quantity-control {
            display: flex;
            align-items: center;
        }
        .quantity-control input {
            width: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 0 5px;
        }
        .btn-remove {
            background-color: transparent;
            border: none;
            color: #ff0000;
            cursor: pointer;
        }
        .order-summary {
            float: right;
            text-align: right;
            margin-top: 20px;
            font-size: 18px;
        }
        .order-summary p {
            margin-bottom: 5px;
        }
        .btn-checkout {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }
        .btn-checkout:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>장바구니</h2>

    <!-- 장바구니 비어있는 경우 -->
    <c:if test="${empty cartItems}">
        <p>장바구니가 비어 있습니다.</p>
    </c:if>

    <!-- 장바구니에 상품이 있는 경우 -->
    <c:if test="${not empty cartItems}">
        <table>
            <thead>
                <tr>
                    <th>상품 이미지</th>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>가격</th>
                    <th>합계</th>
                    <th>제거</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <!-- 상품 이미지 및 정보 -->
                        <td>
                            <div class="product-info">
                                <img src="${contextPath}${item.path}" alt="${item.prod_name}">
                            </div>
                        </td>
                        <td>${item.prod_name}</td>
                        
                        <!-- 수량 조절 -->
                        <td class="quantity-control">
                            <button type="button" onclick="updateQuantity(${item.prod_no}, 'decrease')">-</button>
                            <input type="text" value="${item.quantity}" readonly>
                            <button type="button" onclick="updateQuantity(${item.prod_no}, 'increase')">+</button>
                        </td>

                        <!-- 상품 가격 및 합계 -->
                        <td>${item.prod_price}원</td>
                        <td>${item.prod_price * item.quantity}원</td>

                        <!-- 상품 제거 버튼 -->
                        <td>
                            <button class="btn-remove" onclick="removeItem(${item.prod_no})">X</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 주문 요약 -->
        <div class="order-summary">
            <p>총 상품 금액: ${totalProductPrice}원</p>
            <p>총 배송비: ${deliveryFee}원</p>
            <p>할인 금액: ${discountAmount}원</p>
            <p><strong>결제 금액: ${finalAmount}원</strong></p>
            <!-- 결제하기 버튼 -->
            <form action="${contextPath}/order.do" method="POST">
                <button type="submit" class="btn-checkout">결제하기</button>
            </form>
        </div>
    </c:if>
</div>

<script>
    // 수량 증가/감소 요청을 서버에 보내는 함수
    function updateQuantity(prodNo, action) {
        fetch(`${contextPath}/cart.do`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `prodNo=${prodNo}&action=${action}`
        })
        .then(response => response.text())
        .then(data => {
            location.reload();
        });
    }

    // 아이템 제거 요청을 서버에 보내는 함수
    function removeItem(prodNo) {
        if(confirm('장바구니에서 해당 상품을 제거하시겠습니까?')) {
            fetch(`${contextPath}/cart.do`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `prodNo=${prodNo}&action=remove`
            })
            .then(response => response.text())
            .then(data => {
                location.reload();
            });
        }
    }
</script>

</body>

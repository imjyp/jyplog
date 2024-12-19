<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결제 페이지</title>
    <link rel="stylesheet" href="${contextPath}/resource/css/main.css">
    <style>
        /* 기본 스타일 설정 */
        body {
            font-family: 'Noto Sans', sans-serif;
            background-color: #f0f0f5;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            max-width: 1590px;
            margin: 0 auto;
            padding:3%;
        }

        .form-section {
            flex: 1;
            margin-right: 10%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .receipt-section {
            width: 350px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 10%;
            height: 60vh;
            overflow-y: auto;
        }

        .header {
            background-color: #1a73e8;
            padding: 20px;
            text-align: center;
            color: white;
        }

        .header h2 {
            margin: 0;
            font-size: 2rem;
            font-weight: bold;
        }

        .header h2 a {
            color: white;
            text-decoration: none;
        }

        .header h2 a:hover {
            text-decoration: underline;
        }

        h3 {
            margin-bottom: 20px;
            font-size: 1.25rem;
        }

        label {
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 0.9rem;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9rem;
            box-sizing: border-box;
            transition: border-color 0.2s ease;
        }

        input:focus, textarea:focus {
            border-color: #1a73e8;
            outline: none;
        }

        .pay-button {
            background-color: black;
            color: white;
            padding: 15px;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        .pay-button:active {
            background-color:rgb(253, 78, 2);
        }

        .address-search-btn {
            margin-top: 5px;
            background-color:black ;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        .address-search-btn:active {
            background-color: rgb(253, 78, 2);
        }
        .oitem{
       
        
        width: 90%;
        }
        .oitem>p{
        font-size:18px;
		 padding:10px 0px 15px 0px;        
        
        }
        .total{
        
            margin-top: 80%;
        }

    </style>

    <!-- 다음 도로명 주소 검색 API 추가 -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        // 다음 주소 팝업
        function openJusoPopup() {
            new daum.Postcode({
                oncomplete: function(data) {
                    document.getElementById('address').value = data.roadAddress;  // 도로명 주소
                    document.getElementById('zipNo').value = data.zonecode;       // 우편번호
                }
            }).open();
        }

        // ReceiptController로 데이터를 전송하는 함수
        function sendReceiptData(receiptFormData) {
            // 동적으로 폼 생성
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%=request.getContextPath()%>/receipt.do';

            // receiptFormData의 값을 폼에 추가
            for (var key in receiptFormData) {
                if (receiptFormData.hasOwnProperty(key)) {
                    var hiddenField = document.createElement('input');
                    hiddenField.type = 'hidden';
                    hiddenField.name = key;
                    hiddenField.value = receiptFormData[key];
                    form.appendChild(hiddenField);
                }
            }

            document.body.appendChild(form);
            form.submit();
        }

        // 주문, 상품 주문, 결제 순차적으로 전송
        function submitForms() {
            var orderProduct = $('#prodName').val();           // 상품명
            var optionDetail = $('#optionDetail').val();       // 옵션
            var quantity = $('#quantity').val();               // 수량
            var deliveryAddress = $('#address').val();         // 배송지 주소
            var detailedAddress = $('#detailedAddress').val(); // 상세 주소
            var requestNote = $('#request').val();             // 배송 요청 사항
            var paymentAmount = $('#totalPrice').val();        // 총 결제 금액

            // 주문 정보 직렬화
            var orderFormData = $('#orderForm').serialize();

            // 첫 번째 주문 요청
            $.post("<%=request.getContextPath()%>/order.do", orderFormData, function(orderResponse) {
                var orderNo = orderResponse.orderNo;  // 서버로부터 생성된 주문 번호 받아오기

                if (orderNo) {
                    // prodOrderForm에서 orderNo를 추가하지 않음

                    var prodOrderData = $('#prodOrderForm').serialize();

                    // 2. 상품 주문 요청
                    $.post("<%=request.getContextPath()%>/prodOrder.do", prodOrderData, function(prodOrderResponse) {
                        // 3. 상품 주문이 완료되면 결제 요청
                        var payFormData = $('#payForm').serialize() + "&orderNo=" + orderNo;

                        $.post("<%=request.getContextPath()%>/pay.do", payFormData, function(payResponse) {
                            // 결제 완료 후, 해당 값을 POST로 전달하여 receipt.do로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            // 새로운 함수 호출
                            sendReceiptData(receiptFormData);
                        }).fail(function() {
                            // 결제 실패 시에도 영수증 페이지로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            sendReceiptData(receiptFormData);
                        });
                    }).fail(function() {
                        // 상품 주문 실패 시 결제 처리 진행
                        var payFormData = $('#payForm').serialize() + "&orderNo=" + orderNo;
                        $.post("<%=request.getContextPath()%>/pay.do", payFormData, function(payResponse) {
                            // 결제 완료 후 영수증 페이지로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            sendReceiptData(receiptFormData);
                        }).fail(function() {
                            // 결제 실패 시에도 영수증 페이지로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            sendReceiptData(receiptFormData);
                        });
                    });
                } else {
                    // 주문번호 생성 실패 시에도 결제 진행
                    var prodOrderData = $('#prodOrderForm').serialize();
                    $.post("<%=request.getContextPath()%>/prodOrder.do", prodOrderData, function(prodOrderResponse) {
                        var payFormData = $('#payForm').serialize();
                        $.post("<%=request.getContextPath()%>/pay.do", payFormData, function(payResponse) {
                            // 결제 완료 후 영수증 페이지로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            sendReceiptData(receiptFormData);
                        }).fail(function() {
                            // 결제 실패 시에도 영수증 페이지로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            sendReceiptData(receiptFormData);
                        });
                    }).fail(function() {
                        var payFormData = $('#payForm').serialize();
                        $.post("<%=request.getContextPath()%>/pay.do", payFormData, function(payResponse) {
                            // 결제 완료 후 영수증 페이지로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            sendReceiptData(receiptFormData);
                        }).fail(function() {
                            // 결제 실패 시에도 영수증 페이지로 이동
                            var receiptFormData = {
                                orderProduct: orderProduct,
                                optionDetail: optionDetail,
                                quantity: quantity,
                                deliveryAddress: deliveryAddress,
                                detailedAddress: detailedAddress,
                                requestNote: requestNote,
                                paymentAmount: paymentAmount
                            };

                            sendReceiptData(receiptFormData);
                        });
                    });
                }
            }).fail(function() {
                // 주문 처리 실패 시에도 영수증 페이지로 이동
                var receiptFormData = {
                    orderProduct: orderProduct,
                    optionDetail: optionDetail,
                    quantity: quantity,
                    deliveryAddress: deliveryAddress,
                    detailedAddress: detailedAddress,
                    requestNote: requestNote,
                    paymentAmount: paymentAmount
                };

                sendReceiptData(receiptFormData);
            });
        }
    </script>
</head>
<body>
<%@include file="/Includes/headermenu.jsp"%>
    <!-- 헤더 - Sweet Home 링크 -->
    

    <!-- 메인 컨테이너 -->
    <div class="container">
        <!-- 왼쪽 배송지 입력 폼 -->
        <div class="form-section">
            <h3>배송지 정보</h3>
            
            <!-- 주문 및 결제 정보 전송 -->
                 <form id="orderForm" action="<%=request.getContextPath()%>/order.do" method="POST">
                <!-- 회원번호 히든 처리 -->
                <input type="hidden" id="memNo" name="memNo" value="${sessionScope.loginUser.mem_no}">

                <label for="deliveryName">배송지명</label>
                <input type="text" id="deliveryName" name="deliveryName" required>

                <label for="recipientName">받는사람</label>
                <input type="text" id="recipientName" name="recipientName" required>

                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" required>

                <label for="address">주소</label>
                <input type="text" id="address" name="address" required>
                <button type="button" class="address-search-btn" onclick="openJusoPopup()">주소 검색</button>

                <label for="detailedAddress">상세주소</label>
                <input type="text" id="detailedAddress" name="detailedAddress">

                <!-- 우편번호 입력 필드 -->
                <input type="hidden" id="zipNo" name="zipNo">

                <label for="request">배송시 요청사항</label>
                <textarea id="request" name="request" rows="3"></textarea>

                <label for="prodNo">상품 번호</label>
                <input type="hidden" id="prodNo" name="prodNo" value="<%=request.getParameter("prodNo")%>" readonly>

                <label for="quantity">수량</label>
                <input type="text" id="quantity" name="orderCnt" value="<%=request.getParameter("quantity")%>" readonly>

                <!-- 추가: 가격 필드 -->
                <label for="price">가격</label>
                <input type="text" id="totalPrice" name="totalPrice" value="<%=request.getParameter("totalPrice")%>" readonly>

                <label for="prodName">상품명</label>
                <input type="text" id="prodName" name="prodName" value="<%=request.getParameter("prodName")%>" readonly>

                <label for="optionDetail">옵션</label>
                <input type="hidden" id="optionDetail" name="optionDetail" value="<%=request.getParameter("optionDetail")%>" readonly>
            </form>

            <!-- 상품 주문 정보 전송 -->
            <form id="prodOrderForm" action="<%=request.getContextPath()%>/prodOrder.do" method="POST">
                <input type="hidden" name="prodNo" value="<%=request.getParameter("prodNo")%>">
                <input type="hidden" name="orderCnt" value="<%=request.getParameter("quantity")%>">
                <input type="hidden" name="totalPrice" value="<%=request.getParameter("totalPrice")%>">
                <!-- orderNo를 전달하지 않음 -->
            </form>

            <!-- 결제 정보 전송 -->
            <form id="payForm" action="<%=request.getContextPath()%>/pay.do" method="POST">
                <input type="hidden" name="payPrice" value="<%=request.getParameter("totalPrice")%>">
            </form>

            <button type="button" class="pay-button" onclick="submitForms()">주문 및 결제</button>
        </div>

        <!-- 오른쪽 영수증 섹션 -->
        <div class="receipt-section">
            <h3>결제 내역</h3>
            <div class="oitem">
                <p>상품명: <%=request.getParameter("prodName") %></p>
                <p>수량: <%=request.getParameter("quantity") %> 개</p>
                
            </div>
            <div class="total">
                <p><strong>총 금액: <%=request.getParameter("totalPrice")%> 원</strong></p>
            </div>
        </div>
    </div>
</body>
</html>

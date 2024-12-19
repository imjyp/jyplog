<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 완료</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
			max-width:700px;

            height:75vh;
            margin: 50px auto;
            background-color: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #FF6666;
        }
        .order-info {
        width:100%;
            margin-top: 20px;
            padding-top: 20px;
        }
        .order-info p {
            font-size: 19px;
            color: #333;
            margin: 5px 0;
            padding: 10px;
            font-weight: 400 !important;
        text-align: center;
        }
        .order-info>h3{
        text-align: center;
        font-size: 30px;
        font-weight: 400;
        margin-bottom:30px;
        color:rgb(253, 78, 2);
       
}
        
        
        }
        .btn-group {
            margin-top: 30px;
            text-align: center;
        }
        .btn-group a {
        
            text-decoration: none;
            display: inline-block;
            padding: 13px 30px;
            margin: 0 10px;
            font-size: 16px;
            color: white;
            background-color: #333;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn-group a:hover {
            background-color: #555;
        }
        .btn-shopping {
            background-color: #ccc;
        }
         
        .header>h2{
        	text-align: center;
        	margin:0 auto;
        
        
        }
        .oheader{
        margin-top:2.5%;
        
        }
        .oheader>h2{
        font-weight: 400;
        font-size: 23px;
        color:#8e8d8d;
        
        }
        
        .mainbt{
        background-color: black;
        color: white;
        padding:10px  20px 10px 20px;
        outline: none;
        border:none;
        border-radius: 5px;
        font-size:18px;
        }
        .mainbt:active {
	background-color: rgb(253, 78, 2);
        outline: none;
        border:none;
}

       
    </style>
</head>
<body>
<%@include file="/Includes/headermenu.jsp"%>
<%@include file="/Includes/middlemenu.jsp"%>
    
    
    <div class="container">
        <div class="order-info">
            <h3>주문 정보</h3>
            <p><span>상품명&nbsp;:</span> ${orderProduct != null ? orderProduct : 'N/A'}</p>
            <p><span>옵션 &nbsp;:</span> ${optionDetail != null ? optionDetail : 'N/A'}</p>
            <p><span>수량 &nbsp;:</span> ${quantity != null ? quantity : 'N/A'}</p>
            <p><span>배송지&nbsp;:</span> ${deliveryAddress != null ? deliveryAddress : 'N/A'}</p>
            <p><span>상세주소&nbsp;:</span> ${detailedAddress != null ? detailedAddress : 'N/A'}</p>
            <p><span>요청사항&nbsp;:</span> ${requestNote != null ? requestNote : 'N/A'}</p>
            <!-- 결제 금액 출력 부분 수정 -->
            <p><span>결제 금액:</span> ${paymentAmount != null ? paymentAmount : 'N/A'}원</p>
    <div class="oheader">
        <h2>주문이 완료 되었습니다.</h2>
    </div>
        </div>
        <div class="btn-group">
            <button onclick="location.href='<%=request.getContextPath()%>/order.do?action=home'" class="mainbt">메인 페이지로 이동</button>
        </div>
    </div>
</body>
</html>

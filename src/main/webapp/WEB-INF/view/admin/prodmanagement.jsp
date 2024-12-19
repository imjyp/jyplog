<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 관리</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    
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
.pmtab {
	border-bottom: 1px solid #ddd;
	width: 100%;
}

.tabs {
	max-width: 1590px;
	margin: 0 auto;
	border: none !important;
}
        
h1 {
    margin-left: 20px;
    font-size: 1.5rem; /* h2와 동일한 크기 */
    font-weight: bold;
}        


.header-spacing {
    margin-bottom: 30px;
}

.content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 40px;
}

.btn,
.btn-reset1 {
    float: right;
    margin-right: 20px;
    padding: 6px 10px;
	border: none;
	color: white;
	background-color: rgb(253, 78, 2);
	border-radius: 3px;
	cursor: pointer;
	font-size: 1rem;
	transition: background-color 0.3s ease;
}
/* 	background-color: #6c757d;  회색  */

.reset-btn,
.register-btn {
	float: right;
    margin-right: 20px;
    padding: 6px 10px;
	border: none;
	color: white;
	background-color: #000;
	border-radius: 3px;
	cursor: pointer;
	font-size: 1rem;
	transition: background-color 0.3s ease;
}	

.btn:hover,
.btn-reset1:hover {
    background-color: #e64a19;
        }
        
table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 15px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }
        
.btn:hover,
.btn-reset:hover,
.btn-reset1:hover {
    background-color: rgb(253, 78, 2);
}

        .product-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
 .pmcontainer {
	max-width: 1590px;
	margin: 0 auto;
}       
        
    </style>
    
</head>
<body>

	<div class="body">
	
    <%@ include file="/Includes/headermenu.jsp"%>
    <%@include file="/Includes/middlemenu.jsp" %>
	<div class="pmtab">
		<div class="tabs">
		    <ul>
		        <li><a href="${contextPath}/admin/memList.do" >회원 관리</a></li>
		        <li><a href="${contextPath}/member/customer.do" >고객센터</a></li>
		        <li><a href="${contextPath}/admin/prodmanagement.do" class="active" >상품 관리</a></li>
		    </ul>
		</div>
		</div>
		<div class="pmcontainer">
    <div class="content header-spacing">
        <h1>상품 관리</h1>
        <div class="register-button">
        	<button type="button" class="reset-btn" onclick="confirmDeletion()">선택 삭제</button>
            <a href="${contextPath}/prod/addProd.do">
                <button class="register-btn">상품 등록</button>
            </a>
        </div>
	</div>
	
        <form id="deleteForm" action="${contextPath}/prod/deleteSelectedProd.do" method="post">
            <table>
                <thead>
                    <tr id= "tre">
                        <th><input type="checkbox" onclick="toggleCheckboxes(this)"></th>
                        <th>상품번호</th>
                        <th>이미지</th>
                        <th>상품명</th>
                        <th>카테고리</th>
                        <th>가격</th>
                        <th>조회</th>
                        <th id="managementtab">관리</th>
                    </tr>
                </thead>
                <tbody id="prodList">
                    <c:forEach var="prod" items="${prodManagementList}">
                        <tr>
                            <td><input type="checkbox" name="prod_no" value="${prod.prod_no}"></td>
                            <td>${prod.prod_no}</td>
                            <td><img src="${contextPath}${prod.path}" class="product-image" alt="상품 이미지"></td>
                            <td>${prod.prod_name}</td>
                            <td>${prod.cate_name}</td>
                            <td>${prod.prod_price}원</td>
                            <td>${prod.prod_click_cnt}</td>
                            <td>
                                <a href="${contextPath}/prod/prodDetail.do?prod_no=${prod.prod_no}">
                                    <button type="button" class="btn">보기</button>
									</a>
                                
                                <button type="button" class="btn btn-reset1"
										onclick="confirmDeletion()">삭제</button>
                                
								<div class="form-actions">
								<a href="${contextPath}/prod/editProd.do?prod_no=${prod.prod_no}">
                                    <button type="button" class="btn">수정</button>
                                    </a>
								
								</div>
							</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
    </div>
   </div>
    <script>
        function toggleCheckboxes(source) {
            const checkboxes = document.querySelectorAll('input[name="prod_no"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = source.checked;
            });
        }

        function confirmDeletion() {
            if (confirm('정말 삭제하시겠습니까?')) {
                document.getElementById('deleteForm').submit();
            }
        }
    </script>

    <%@ include file="/Includes/footer.jsp"%>

</body>
</html>

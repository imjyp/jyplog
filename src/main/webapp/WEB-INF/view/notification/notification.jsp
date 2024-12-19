<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알림 페이지</title>
    <style>
  
.notification-header {
            display: flex;
            justify-content: space-between; /* 양쪽으로 배치 */
            align-items: center; /* 수직 중앙 정렬 */
            margin: 20px 0;
        }

        .dropdown {
            float: right;
            display: inline-block;
            font-size: 0.8rem;
        }

        .dropdown select {
            padding: 5px;
            font-size: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .search-container {
            margin: 20px auto;
            width: 80%;
        }

.notification-label {
    margin-right: 10px;
}

        .category-title {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .notification-list {
            list-style-type: none;
            padding: 0;
        }

        .notification-item {
            display: flex;
            align-items: center;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            padding: 20px;
            transition: background-color 0.3s;
        }

        .notification-item:hover {
            background-color: #f1f1f1;
        }

        .notification-item img {
            width: 50px;
            height: 50px;
            margin-right: 20px;
            border-radius: 50%;
        }

        .notification-text {
            font-size: 1rem;
            color: rgb(47, 52, 56);
        }

        .notification-date {
            font-size: 0.8rem;
            color: #999;
            margin-left: auto;
        }
    </style>
</head>

<body>
    <div class="body">
        <%@include file="/Includes/headermenu.jsp" %>
        <%@include file="/Includes/middlemenu.jsp" %>

	<main class="search-container">
            <div class="notification-header">
                <span class="category-title">나의 알림</span>
           <!-- 알림 아이콘 -->
                <div class="notification-icon" id="notificationIcon">
                    <img src="${contextPath}/images/notification.png" alt="알림 아이콘">
                    <span class="badge" id="notificationBadge">1</span> <!-- 알림 개수 표시 -->
                </div>
            </div>

            <p>새로운 알림이 도착하면 알림 아이콘에 표시됩니다.</p>
        </main>      
                
                
<%-- 	
            <div class="dropdown" style="display: flex; align-items: center;">
            <span class="notification-label" style="margin-right: 10px;">유형</span>
            <form action="${contextPath}/notification/notification.do" method="get">
                <select id="notificationType" name="type" onchange="this.form.submit()">
                    <option value="all" ${param.type == 'all' || param.type == null ? 'selected' : ''}>전체</option>
                    <option value="order" ${param.type == 'order' ? 'selected' : ''}>주문</option>
                    <option value="board" ${param.type == 'board' ? 'selected' : ''}>게시글</option>
                    <option value="comment" ${param.type == 'comment' ? 'selected' : ''}>댓글</option>
                </select>
            </form>
        </div>
	</div>
       
	<c:if test="${not empty notifications}">
        <ul id="notification-list" class="notification-list">
		    <c:forEach var="notification" items="${notifications}">
		        <li class="notification-item">
		            <img src="${contextPath}/images/logo.png" alt="Logo">
		            <div class="notification-text">
		                <c:choose>
		                    <c:when test="${notification.type == 'order'}">
		                        주문 번호 ${notification.orderNo} - 상품 번호 ${notification.prodNo}가 완료되었습니다. (수량: ${notification.orderCnt})
		                    </c:when>
		                    <c:when test="${notification.type == 'boardComplete'}">
		                        게시글 "${notification.title}"이(가) 작성되었습니다.
		                    </c:when>
		                    
		                </c:choose>
		            </div>
		            <span class="notification-date">${notification.date}</span> 
		        </li>
		    </c:forEach>
		</ul>
		</c:if>
		
		<c:if test="${empty notifications}">
		    <p>알림이 없습니다.</p>
		</c:if>
		 --%>
		
	</main>
	
    <%@include file="/Includes/footer.jsp" %>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 관리</title>
    <link rel="stylesheet" href="${contextPath}/resource/css/main.css">
    
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
    align-items: center;
    margin-top: 40px;
}
 
h2 {
    margin-left: 20px;
}

.search-bar-container {
    display: flex;
    justify-content: center;
    align-items: center;
}

.search-bar {
	padding: 8px;
	width: 300px;
	border: 1px solid #ddd;
	border-radius: 3px;
}

.search-bar-container button {
	padding: 6px 10px;
	border: none;
	color: white;
	background-color: rgb(253, 78, 2);
	border-radius: 3px;
	cursor: pointer;
	font-size: 1rem;
	margin-left: 10px;
	transition: background-color 0.3s ease;
}

.delete-button {
    float: right;
    margin-right: 20px;
    padding: 6px 10px;
	color: rgb(253, 78, 2);
	background-color: white;
	border: 1px solid;
	border-color: rgb(253, 78, 2);
	border-radius: 3px;
	cursor: pointer;
	font-size: 1rem;
	transition: background-color 0.3s ease;
}

.search-button:hover {
    background-color: #e64a19;
        }
        
.delete-button:hover {
	background-color: #f8f8f8;
        }        
	
.member-table {
    width: 100%;
    border-collapse: collapse;
    background-color: white;
    margin: 20px 0;
}

.member-table th, .member-table td {
    border: 1px solid #ddd;
    padding: 15px;
    text-align: center;
}

.member-table th {
    background-color: #f1f1f1;
} 
  
.select-all {
    float: right;
    margin-bottom: 10px;
}
.mlcontainer {
	max-width: 1590px;
	margin: 0 auto;
}

.mltab {
	border-bottom: 1px solid #ddd;
	width: 100%;
}

.tabs {
	max-width: 1590px;
	margin: 0 auto;
	border: none !important;
}
    </style>
</head>
<body>

    <div class="body">
    
    <%@include file="/Includes/headermenu.jsp" %>
	<%@include file="/Includes/middlemenu.jsp" %>
		
		<div class="mltab">
        <div class="tabs">
		    <ul>
		        <li><a href="${contextPath}/admin/memList.do" class="active">회원 관리</a></li>
		        <li><a href="${contextPath}/member/customer.do" >고객센터</a></li>
		        <li><a href="${contextPath}/admin/prodmanagement.do" >상품 관리</a></li>
		    </ul>
		</div>
		</div>
		<div class="mlcontainer">
        <div class="content header-spacing">
		    <h2>회원 리스트</h2>
		    <div class="search-bar-container">
		        <input type="text" id="searchQuery" class="search-bar" placeholder="회원 검색" />
		        <button class="search-button"onclick="searchMember()">검색</button>
		    </div>
		    <button class="delete-button" type="button" onclick="deleteMember()">탈퇴</button>
		</div>
            
            <form action="${contextPath}/admin/memList.do" method="post">
            <table class="member-table">
                <thead>
                    <tr>
                    	<th><input type="checkbox" id="selectAll" onclick="toggleAll(this)"/></th>
                        <th>아이디</th>
                        <th>비밀번호</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>휴대폰 번호</th>
                        <th>닉네임</th>
                    </tr>
                </thead>
                <tbody id="memberList">
	            <c:forEach var="member" items="${memberList}">
			    <tr>
			        <td><input type="checkbox" name="selectedMembers" value="${member.mem_id}" class="memberCheckbox"/></td>
			        <td>
			            <c:choose>
			                <c:when test="${member.del_yn == 2}">
			                    ${member.mem_id} (탈퇴) <!-- 탈퇴한 회원의 아이디에 '(탈퇴)' 추가 -->
			                </c:when>
			                <c:otherwise>
			                    ${member.mem_id} <!-- 일반 회원 아이디만 출력 -->
			                </c:otherwise>
			            </c:choose>
			        </td>
			        <td>${member.mem_pw}</td>
			        <td>${member.mem_name}</td>
			        <td>${member.email}</td>
			        <td>${member.phone}</td>
			        <td>${member.mem_nick}</td>
			    </tr>
			</c:forEach>
	        </tbody>
            </table>
            </form>
        </div>
        
<%@ include file="/Includes/footer.jsp" %>
    </div>
  <script>
        function searchMember() {
        	const query = document.getElementById('searchQuery').value;
        	
        	// Fetch API로 서버에 요청
            fetch(`${contextPath}/search/searchMemAdmin.do?query=` + encodeURIComponent(query), {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.text())  // 서버에서 받은 응답을 텍스트로 변환
            .then(data => {
                // 응답 데이터를 회원 리스트 테이블에 반영
                document.getElementById('memberList').innerHTML = data;
            })
            .catch(error => console.error('Error:', error));
        }

        
        
        function deleteMember() {
            const selectedMembers = document.querySelectorAll('.memberCheckbox:checked');  // 선택된 체크박스 확인

            if (selectedMembers.length > 0) {
                const memberIds = Array.from(selectedMembers).map(member => member.value);  // 선택된 회원 ID들 배열로 변환

                // Fetch API로 서버에 POST 요청 보내기
                fetch(`${contextPath}/admin/memList.do`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        'selectedMembers': memberIds.join(',')  // 배열을 쉼표로 구분된 문자열로 변환
                    })
                })
                .then(response => {
                    if (response.ok) {
                        alert('선택한 회원을 성공적으로 탈퇴시켰습니다.');
                        location.reload();  // 페이지 새로고침
                    } else {
                        alert('탈퇴 처리 중 오류가 발생했습니다.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('서버와의 통신 중 오류가 발생했습니다.');
                });
            } else {
                alert('탈퇴할 회원을 선택해 주세요.');
            }
        }

        function toggleAll(selectAllCheckbox) {
            const checkboxes = document.querySelectorAll('.memberCheckbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });
        }
        
        function toggleDropdown() {
		    const dropdownMenu = document.getElementById('customerDropdown');
		    if (dropdownMenu) {
		        dropdownMenu.style.display = dropdownMenu.style.display === 'none' || dropdownMenu.style.display === '' ? 'block' : 'none';
		    }
		}
       
    	
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<script src="https://kit.fontawesome.com/516da99189.js"
	crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
    margin-top: 20px;
}

h1 {
    text-align: center;
    margin-bottom: 20px;
}


.form {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 800px;
	margin: 0 auto; /* 폼 자체 가운데 정렬 */
	text-align: center; /* 폼 내부 요소들 가운데 정렬 */
}
.form-group {
	margin-bottom: 20px;
	display: flex;
	align-items: center;
}

label {
	width: 150px;
	font-weight: bold;
}

input[type="text"], select, textarea {
	width: 70%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.text-editor {
	width: 70%;
	height: 150px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.form-actions {
	text-align: center;
	margin-top: 30px;
}

.deletebtn{
/* 	float: right; */
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

.imgfile {
    clear: both;  /* 이전 요소들과 겹치지 않도록 줄바꿈 */
    margin-top: 80px; /* 상품 이미지 위에 여백 추가 */
    margin-bottom: 30px; 
   
}

.add-btn {
    display: block;  /* 버튼을 블록 요소로 만들어서 줄바꿈 */
    margin-bottom: 30px; /* 버튼 아래쪽에 여백 추가 */
}

.addbtn {
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
	

.submitbtn,
.canclebtn{
/* 	float: right; */
    margin-right: 20px;
    padding: 6px 10px;
	border: none;
	background-color: #000000;
	color: white;
	border-radius: 3px;
	cursor: pointer;
	font-size: 1rem;
}

.submitbtn:hover,
.canclebtn:hover{
	background-color: rgb(253, 78, 2);
}

.pmecontainer {
	max-width: 1590px;
	margin: 0 auto;
}

.pmetab {
	border-bottom: 1px solid #ddd;
	width: 100%;
}

.tabs {
	max-width: 1590px;
	margin: 0 auto;
	border: none !important;
}


#options-container {
    margin-top: 0; /* 전체 옵션 컨테이너의 상단 여백 제거 */
}

.option-group {
    position: relative;
    padding: 20px 0 40px; /* 상단과 하단 여백 추가 */
    border-bottom: 1px solid #ddd; /* 하단 경계선 */
    margin-bottom: 20px;
}

/* 첫 번째 옵션 그룹에 상단 경계선과 여백을 추가 */
.option-group:first-child {
    border-top: 1px solid #ddd; /* 첫 번째 옵션 그룹 위에 상단 경계선 추가 */
    padding-top: 40px; /* 첫 번째 옵션 그룹과 상단 경계선 사이에 충분한 여백 추가 */
}

#existing-images {
    border: 1px solid #ddd; /* 경계선 추가 */
    padding: 20px;
    margin-top: 20px;
}

#existing-images .form-group {
    display: inline-block; /* 이미지와 버튼이 수평으로 배치되도록 설정 */
    text-align: center; /* 삭제 버튼이 이미지 밑 중앙에 오도록 설정 */
    margin-right: 20px; /* 이미지 사이에 여백 추가 */
    vertical-align: top; /* 이미지와 버튼이 수평 중앙에 맞춰지도록 설정 */
}

#existing-images img {
    display: block;
    margin-bottom: 10px; /* 이미지와 삭제 버튼 사이에 여백 추가 */
}

.imgdeletebtn {
    padding: 6px 10px;
    background-color: rgb(253, 78, 2);
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.3s ease;
}

</style>
</head>
<body>

	<%@ include file="/Includes/headermenu.jsp"%>
	<%@ include file="/Includes/shoppingmiddlemenu.jsp"%>

	<div class="pmetab">
		        <div class="tabs">
				    <ul>
				        <li><a href="${contextPath}/admin/memList.do" >회원 관리</a></li>
				        <li><a href="${contextPath}/member/customer.do" >고객센터</a></li>
				        <li><a href="${contextPath}/admin/prodmanagement.do" class="active" >상품 관리</a></li>
				    </ul>
				</div>
		</div>
		<div class="pmecontainer">
        <div class="content header-spacing">
	<h1>상품 수정</h1>
		</div>
	<form class="form" action="${contextPath}/prod/updateProd.do" method="post"
		accept-charset="UTF-8" enctype="multipart/form-data">

		<!-- 상품 번호 (수정 불가능하게 숨김) -->
		<input type="hidden" name="prod_no" value="${prodVo.prod_no}" />

		<div class="form-group">
			<label for="product-name">상품 이름</label> <input type="text"
				id="product-name" name="prod_name" value="${prodVo.prod_name}"
				required />
		</div>

		<div class="form-group">
			<label for="short-description">상품설명</label>
			<textarea id="short-description" name="prod_description"
				class="text-editor">${prodVo.prod_description}</textarea>
		</div>

		<div class="form-group">
			<label for="category">카테고리</label> <select name="cate_no">
				<option value="">전체 분류</option>
				<c:forEach var="cate" items="${cateList}">
					<option value="${cate.cate_no}"
						${cate.cate_no == prodVo.cate_no ? 'selected="selected"' : ''}>${cate.cate_name}</option>
				</c:forEach>
			</select>
		</div>

		<div class="form-group">
			<label for="price">가격</label> <input type="text" id="price"
				name="prod_price" value="${prodVo.prod_price}" />
		</div>

		<!-- 여러 개의 상품 옵션 수정 가능 -->
		<div id="options-container">
			<c:forEach var="option" items="${prodVo.prodOptions}">
				<div class="option-group">
					<div class="form-group">
						<input type="hidden" name="prod_option_no[]"
							value="${option.prod_option_no}" /> <label
							for="prod_option_detail">옵션 상세</label> <input type="text"
							name="prod_option_detail[]" value="${option.prod_option_detail}"
							required />
					</div>
					<div class="form-group">
						<label for="prod_option_price">옵션 가격</label> <input type="text"
							name="prod_option_price[]" value="${option.prod_option_price}" />
					</div>
					<div class="form-group">
						<label for="prod_color">옵션 색상</label> <input type="text"
							name="prod_color[]" value="${option.prod_color}" />
					</div>
					<button type="button" class="deletebtn"
						onclick="removeOption(this)">옵션 삭제</button>
				</div>
				
			</c:forEach>
		</div>
		
		<div class="add-btn">
		<button type="button" class="addbtn" onclick="addOption()">옵션 추가</button>
		</div>
		
		<!-- 상품 이미지 -->
		<div class="imgfile">
		<div class="form-group">
			<label for="product-image">상품 이미지</label> <input type="file"
				id="product-image" name="prod_images" multiple />
		</div>
		</div>
		

		<!-- 기존 상품 이미지 표시 및 삭제 -->
		<div id="existing-images">
			<div class="content header-spacing">
			<h3>기존 이미지</h3>
			</div>
			<c:forEach var="image" items="${prodVo.imagePaths}">
				<div class="form-group">
					<img src="${contextPath}${image}" alt="상품 이미지" width="100"
						height="100" />
					<button type="button" class="imgdeletebtn"
						onclick="removeExistingImage('${image}')">이미지 삭제</button>
				</div>
			</c:forEach>
		</div>
		<div class="form-actions">
			<button type="submit" class="submitbtn">수정</button>
			<button type="button" class="canclebtn"
				onclick="cancelAndRedirect()">취소</button>
		</div>
	</form>
</div>
	<script>

function removeExistingImage(imagePath) {
    // 삭제할 이미지를 서버에 알려주는 기능 추가 (Ajax로 처리 가능)
    console.log("D:\\A_TeachingMaterial\\05\\source\\MiddleProject2\\src\\main\\webapp\\images\\", imagePath);
    // 실제 이미지 삭제 처리 로직 추가 필요
}
function cancelAndRedirect() {
    window.location.href = '${contextPath}/admin/prodmanagement.do';
}

function addOption() {
    const optionGroup = document.createElement('div');
    optionGroup.className = 'option-group';

    optionGroup.innerHTML = `
        <div class="form-group">
            <label for="prod_option_detail">옵션 상세</label>
            <input type="text" name="prod_option_detail[]" required />
        </div>
        <div class="form-group">
            <label for="prod_option_price">옵션 가격</label>
            <input type="text" name="prod_option_price[]" />
        </div>
        <div class="form-group">
            <label for="prod_color">옵션 색상</label>
            <input type="text" name="prod_color[]" />
        </div>
        <button type="button" class="deletebtn" onclick="removeOption(this)">옵션 삭제</button>
    `;

    document.getElementById('options-container').appendChild(optionGroup);
}

function removeOption(button) {
    const optionGroup = button.parentElement;
    document.getElementById('options-container').removeChild(optionGroup);
}
</script>

	<%@ include file="/Includes/footer.jsp"%>

</body>
</html>
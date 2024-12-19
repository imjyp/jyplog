<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<title>상품 등록 창</title>
<style>
body { <<<<<<< .
	mine font-family: Arial, sans-serif;
	margin: 0 auto; ||||||| .
	r449102 font-family: Arial, sans-serif;
	max-width: 1000px;
	margin: 20px auto; =======
	font-family: Arial, sans-serif;
	margin: 0 auto;
	>>>>>>>
	.
	r449286
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

.btn {
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

.btn-submit { <<<<<<< .
	mine background-color: black;
	color: white; ||||||| .
	r449102 background-color: #4CAF50;
	color: white; =======
	background-color: black;
	color: white;
	>>>>>>>
	.
	r449286
}

<<<<<<<
.mine

.pubox {
	max-width: 1000px;
	margin: 0 auto;
	margin-top: 2%;
	border: 1px solid #dfdfdf;
	border-radius: 13px;
	padding: 3% 3% 3% 3%; ||||||| . r449102 .btn-reset { background-color :
	#f44336;
	color: white; ======= . pubox { max-width : 1000px;
	margin: 0 auto;
	padding-top: 3%;
	border: 1px solid gray;
	>>>>>>>
	.
	r449286
}

<<<<<<<
.mine
.pubox>h1 {
	text-align: center;
	padding-bottom: 30px;
	color: rgb(253, 78, 2);
}

.opbt {
	width: 100%;
	margin: 0 auto;
	display: flex;
}

.btn-reset {
	color: white;
	background-color: rgb(253, 78, 2);
}

.add-option-btn {
	background-color: white;
	color: black;
}

.btn-reset2 {
	background-color: white;
}

|||||||
.r449102
 ======= .opbt {
	width: 100%;
	margin: 0 auto;
	display: flex;
}

.btn-reset {
	color: white;
	background-color: rgb(253, 78, 2);
}

.add-option-btn {
	background-color: white;
	color: black;
}

.btn-reset2 {
	background-color: white;
}
>>>>>>>
.r449286
</style>
</head>
<body>


	<%@ include file="/Includes/headermenu.jsp"%>
	<%@ include file="/Includes/shoppingmiddlemenu.jsp"%>
	<div class="pubox">
		<h1>상품 등록</h1>
		<form action="${contextPath}/prod/addProd.do" method="post"
			accept-charset="UTF-8" enctype="multipart/form-data">


			<div class="form-group">
				<label for="product-name">상품 이름</label> <input type="text"
					id="product-name" name="prod_name" required />
			</div>

			<div class="form-group">
				<label for="short-description">상품설명</label>
				<textarea id="short-description" name="prod_description"
					class="text-editor"></textarea>
			</div>

			<div class="form-group">
				<label for="category">카테고리</label> <select name="cate_no">
					<option value="">전체 분류</option>
					<!-- 분류 옵션 추가 -->
					<c:forEach var="cate" items="${cateList}">
						<option value="${cate.cate_no}">${cate.cate_name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="price">가격</label> <input type="text" id="price"
					name="prod_price" />
			</div>
			<!-- 상품 옵션 입력 (기본적으로 항상 보임) -->
			<h2>상품 옵션</h2>
			<div id="options-container">
				<div class="option-group">
					<div class="form-group">
						<label for="prod_option_detail">옵션 상세</label> <input type="text"
							name="prod_option_detail[]" required />
					</div>
					<div class="form-group">
						<label for="prod_option_price">옵션 가격</label> <input type="text"
							name="prod_option_price[]" />
					</div>
					<div class="form-group">
						<label for="prod_color">옵션 색상</label> <input type="text"
							name="prod_color[]" />
					</div>
					<div class="form-group">
						<label for="add_prod_price">추가 옵션 가격</label> <input type="text"
							name="add_prod_price[]" />
					</div>
					<div class="form-group">
						<label for="add_prod_option">추가 옵션 설명</label> <input type="text"
							name="add_prod_option[]" />
					</div>

					<div class="form-actions">
						<button type="submit" class="btn btn-submit">입력</button>
						<button type="button" class="btn btn-reset"
							onclick="cancelAndRedirect()">취소</button>
					</div>
		</form>
	</div>


	<script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
	<script>
   
   
   
   function cancelAndRedirect() {
       // 상품 관리 페이지로 이동
       window.location.href = '${contextPath}/admin/prodmanagement.do';
   }
    // CKEditor 적용
    CKEDITOR.replace('detailed-description', {
        filebrowserUploadUrl: '${contextPath}/images/uploadProdImg',  // 이미지 업로드를 처리할 서버 경로
        filebrowserUploadMethod: 'form'
    });
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
            <div class="form-group">
                <label for="add_prod_price">추가 옵션 가격</label>
                <input type="text" name="add_prod_price[]" />
            </div>
            <div class="form-group">
                <label for="add_prod_option">추가 옵션 설명</label>
                <input type="text" name="add_prod_option[]" />
            </div>
            <button type="button" class="btn btn-reset2" onclick="removeOption(this)">+ 옵션 삭제</button>
           
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">

<script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
<style>
/* 스타일 유지 */
#att_zone {
   min-height: 300px;
   padding: 10px;
}

#image_preview {
   width: 400px;
   height: 450px;
   border-radius: 10px;
   background-color:#eeeef2; 
}

#att_zone:empty:before {
   content: attr(data-placeholder);
   color: #4c4a4a;
   font-size: .9em;
}

#cke_postContent {
   width: 600px;
}

#uploadForm {
   padding-top: 50px;
}

#cke_1_top {
   background-color: inherit;
}

#cke_1_bottom {
   background-color: inherit;
   color: black;
}

#postTitle {
   height: 40px;
   width: 600px;
   border-radius: 5px;
   border: rgb(186, 186, 186) 1px solid;
   font-weight: lighter !important;
   padding: 10px;
}

#postTitle:focus {
   border: rgb(186, 186, 186) 1px solid !important;
   outline: none;
}


/* 헤더 스타일 */

#btnAtt {
   margin: 0 auto;
   display: block;
   text-align: center;
   
}

#att_zone {
   text-align: center;
   padding: 30px;
}

#uploadForm {
   display: flex;
   margin-top: 50px;
   text-align: center;
   justify-content: center;
}

.post4 {
   margin: 0 auto;
   display: block !important;
   width: 150px;
   height: 50px;
   border-radius: 5px;
   margin-top: 20px;
   outline: none;
   border: none ;
   background-color: black;
   color:white;
   cursor: pointer;
   font-size: 16px;
}

.post4:active{
   background-color: rgb(253, 78, 2);
   color: white;
}
.post4:hover{
   background-color: rgb(253, 78, 2);
}

.image_upload {
   padding-left: 20px;
}

.post {
   margin-left: 30px;
}

#postWriter {
   outline:none ;
   width:600px;
   height:40px;
   border: 1px solid rgb(186, 186, 186) ;
   font-weight: lighter !important;
   padding: 10px;
   border-radius: 5px;
}
.home {
	color: black !important;
}


.comm{
color: rgb(253, 78, 2) !important;
	font-weight: bold !important;
}
.post2{
max-width: 1590px;
height: 70vh;
margin:0 auto;

}
#cke_1_contents{
    height: 400px;


}
</style>

</head>
<body>
	<%@include file="/Includes/headermenu.jsp"%>
	<div class="post2">
		<form id="uploadForm"
			action="${contextPath}/postupdate.do?board_no=${board.board_no}"
			method="post" enctype="multipart/form-data">
			<!-- 게시글 번호 hidden 필드로 전달 -->
			<input type="hidden" name="board_no" value="${board.board_no}">



			<div class="post">
				<!-- 세션에서 회원번호(mem_no) 가져오기 -->
				<c:if test="${not empty sessionScope.loginUser}">
					<input type="hidden" name="mem_no"
						value="${sessionScope.loginUser.mem_no}">
				</c:if>

				<!-- 제목 필드 -->
				<label for="postTitle"></label> <input type="text" id="postTitle"
					name="title" value="${board.title}" required><br>

				<!-- 내용 필드 -->
				<label for="postContent"></label>
				<textarea id="postContent" name="content" required>${board.content}</textarea>

				<!-- 수정 완료 버튼 -->
				<button type="submit" class="post4">수정 완료</button>
			</div>
		</form>

	<%@include file="/Includes/footer.jsp"%>
	</div>

	<script>
		// CKEditor의 내용을 form 제출 전에 textarea에 반영

		// CKEditor의 내용을 form 제출 전에 textarea에 반영
		document.getElementById('uploadForm').addEventListener('submit',
				function(event) {
					CKEDITOR.instances['postContent'].updateElement();
				});

		// CKEditor 초기화
		CKEDITOR.replace("postContent");
	</script>

</body>
</html>

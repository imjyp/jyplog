<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.board.vo.BoardVo"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 상세 페이지</title>
<link rel="stylesheet" href="${contextPath}/resource/css/main.css">
<style>
.home {
	color: black !important;
}

.co {
	color: rgb(253, 78, 2) !important;
	font-weight: bold !important;
}

.board-wrapper {
	max-width: 1980px !important;
}

.comm {
	color: rgb(253, 78, 2) !important;
	font-weight: 500 !important;
}

.boardcontainer {
	justify-content: center;
	width: 100%;
	margin: 0 auto;
}

.board {
	text-align: center;
}

.board img {
	display: block;
	width: 100%;
	max-height: calc(-350px + 100vh);
	object-fit: cover;
	margin: 0 auto;
}

.board-info {
	margin-top: 50px;
	height: 72vh;
}

.board-title {
	font-size: 30px;
	font-weight: bold;
	margin-bottom: 5px;
	color: #333;
	text-align: left;
}

.board-name {
	margin-top: 20px;
	margin-bottom: 20px;
	text-align: left;
	font-weight: bold;
	font-size: 14px;
	color: rgb(47, 52, 56);
}

.board-description {
	text-align: left;
	overflow-wrap: break-word;
	margin: 10px 0px;
	color: rgb(47, 52, 56);
	font-size: 16px;
	line-height: 28px;
	min-height: 28px;
}

.board-count {
	font-size: 13px;
	color: rgb(130, 140, 148);
	margin-top: 5px;
	text-align: left;
}

.line {
	margin: 20px 0;
	height: 1px;
	background-color: #cbcbcb;
}

.loading {
	background-color: #ccc;
	cursor: wait;
}
/* 댓글 스타일 */
.comment-section {
	margin-top: 30px;
	height: 90vh;
}

.comment-section>h2 {
	text-align: left;
	margin-bottom: 24px;
	font-size: 20px;
}

.comment-form {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.comment-form textarea {
	cursor: text;
	display: inline-block;
	padding: 10px;
	border: none;
	background: none;
	color: rgb(47, 52, 56);
	outline: none;
	font-size: 16px;
	margin: 9px 0px;
	height: 0px;
	border: 1px solid #ddd;
	height: 50px;
	border
}

.comment-form button {
	padding: 10px;
	background-color: #000000;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	width: 100px;
	align-self: flex-end;
}

.comment-list {
	margin-top: 20px;
}

.comment-item {
	padding: 10px;
	text-align: left;
}

.comment-item .comment-nick {
	font-weight: bold;
	color: #333;
	text-align: left;
}

.comment-item .comment-content {
	margin: 5px 0;
	font-size: 14px;
	text-align: left;
}

.boardct {
	max-width: 1200px;
	margin: 0 auto;
}

.crv {
	height: 50px;
}

.pbt {
	margin: 0px;
    border: none;
    background: none rgb(253, 78, 2) ;
    
    font-size: 14px;
    line-height: 18px;
	color:white;
    width: auto;
    height: 44px;
    border-radius: 4px;
    padding: 0px 16px;
    font-weight: 400;

    box-shadow: rgba(63, 71, 77, 0.15) 0px 2px 5px 0px;
}
</style>
</head>
<body>
	<!-- 상단 메뉴 -->
	<%@ include file="/Includes/headermenu.jsp"%>
	<%@ include file="/Includes/middlemenu.jsp"%>

	<div class="board-wrapper">
		<div class="boardcontainer">
			<div class="board">
				<c:choose>
					<c:when test="${not empty board}">
						<c:if test="${not empty board.images}">
							<c:forEach var="imgpath" items="${board.images}">
								<img src="${contextPath}${imgpath}" alt="Board Image">
							</c:forEach>
						</c:if>
						<c:if test="${empty board.images}">
							<div>이미지 경로 없음~~</div>
						</c:if>

						<div class="boardct">
							<div class="board-info">
								<div class="board-title">${board.title}</div>
								<div class="board-name">작성자: ${board.writer}</div>
								<div class="board-description">${board.content}</div>
							</div>
								<!-- 로그인한 사용자가 본인 게시글일 경우에만 수정 버튼 표시 -->
								<c:if test="${sessionScope.loginUser.mem_no == board.mem_no}">
									<!-- 게시글 상세 페이지에서 수정 버튼 -->
									<a
										href="${contextPath}/postupdate.do?board_no=${board.board_no}">
										<button class="pbt">게시글 수정</button>
									</a>
									<!-- 게시글 삭제 버튼 -->
									<form id="deleteForm"
										action="${contextPath}/postdelete?board_no=${board.board_no}"
										method="post" style="display: inline;">
										<input type="hidden" name="board_no" value="${board.board_no}">
										<button class="pbt" type="button" id="deletePostBtn">게시글 삭제</button>
									</form>
								</c:if>
							<div class="board-count">조회수: ${board.board_cnt}</div>
					</c:when>
					<c:otherwise>
						<div>No board details available.</div>
					</c:otherwise>
				</c:choose>

				<!-- 댓글 섹션 -->
				<div class="comment-section">
					<h2>댓글</h2>

					<!-- 댓글 작성 폼 -->
					<form id="commentForm" class="comment-form">
						<input type="hidden" name="board_no" value="${board.board_no}">
						<input type="hidden" name="mem_no"
							value="<%=session.getAttribute("mem_no")%>">
						<textarea name="content" class="crv" rows="4"
							placeholder="댓글을 입력하세요." required></textarea>
						<button type="button" id="submitCommentBtn">댓글 작성</button>
					</form>

					<!-- 댓글 목록 -->
					<div class="comment-list">
						<c:if test="${not empty comments}">
							<c:forEach var="comment" items="${comments}">
								<div class="comment-item">
									<div class="comment-nick">${comment.mem_nick}</div>
									<div class="comment-content">${comment.content}</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${empty comments}">
							<div>댓글이 없습니다.</div>
						</c:if>
					</div>
				</div>
				<!-- 댓글 섹션 끝 -->
			</div>
		</div>
	</div>
	</div>
	<!-- 푸터 -->
	</div>

	<!-- 댓글 작성 스크립트 -->
	<!-- 댓글 작성 스크립트 -->
	<script>
   const contextPath = '<%=request.getContextPath()%>';
   </script>
	<script>
   document.addEventListener("DOMContentLoaded", function() {
       // 게시글 삭제 버튼이 있을 때만 이벤트 리스너 등록
       const deletePostBtn = document.getElementById('deletePostBtn');
       if (deletePostBtn) {
           deletePostBtn.addEventListener('click', function() {
               const confirmDelete = confirm('게시글을 삭제하시겠습니까?');
               if (confirmDelete) {
                   document.getElementById('deleteForm').submit();
               }
           });
       }

    // 댓글 작성 버튼이 있을 때만 이벤트 리스너 등록
       const submitCommentBtn = document.getElementById('submitCommentBtn');
       if (submitCommentBtn) {
           submitCommentBtn.addEventListener('click', submitComment);
       }

       const commentTextarea = document.querySelector('textarea[name="content"]');
       if (commentTextarea) {
           commentTextarea.addEventListener('keydown', function(event) {
               if (event.key === 'Enter' && !event.shiftKey) {
                   event.preventDefault(); // 기본 엔터 동작(줄바꿈) 막기
                   submitComment(); // 댓글 작성 함수 호출
               }
           });
       }
    });

    // 댓글 작성 함수
    function submitComment() {
       const form = document.getElementById('commentForm');
       const formData = new FormData(form);
       
        fetch(`${contextPath}/comment/comment.do`, {
            method: 'POST',
            body: new URLSearchParams(formData)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('댓글 작성 중 문제가 발생했습니다.');
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                // 댓글을 동적으로 추가
                const commentList = document.querySelector('.comment-list');
                const newComment = document.createElement('div');
                newComment.classList.add('comment-item');

                const commentNick = document.createElement('div');
                commentNick.classList.add('comment-nick');
                commentNick.textContent = data.comment.mem_nick;

                const commentContent = document.createElement('div');
                commentContent.classList.add('comment-content');
                commentContent.textContent = data.comment.content;

                newComment.appendChild(commentNick);
                newComment.appendChild(commentContent);

                // 댓글 리스트의 맨 위에 새로운 댓글 추가
                commentList.prepend(newComment);

                form.querySelector('textarea[name="content"]').value = '';
            } else {
                alert('댓글 작성에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('댓글 작성 중 오류 발생:', error);
        });
    }
   </script>
	<%@ include file="/Includes/footer.jsp"%>
</body>
</html>
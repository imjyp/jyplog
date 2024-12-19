<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sweet Home 중간 프로젝트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"> 
    <style>
       
* {
	font-family: "Noto Sans KR", "roboto" !important;
}

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

  
/* 버튼 호버        
.update-btn:hover,
.delete-btn:hover,
.register-btn:hover,
.qna-delete-btn:hover,
.qna-answer-btn:hover,
.qna-register-btn:hover{
	background-color: rgb(253, 78, 2) !important;
}
 */
 
 
.update-btn:hover {
    background-color: #e64a19;
        }
        
.delete-btn:hover {
	background-color: #f8f8f8;
        }     
        /* 고객센터 스타일 */
        .customer-center {
            padding: 20px;
            background-color: #fff;
            margin-top: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            height: auto;
        }

        .customer-center h2 {
            font-size: 1.6rem;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .notice-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .notice-item {
            display: flex;
            justify-content: space-between;
            padding: 7px 0;
            border-bottom: 1px solid #eee;
        }

        .notice-item a {				/* 고객센터 리스트 글씨 크기 조정 */
            text-decoration: none;
            color: #007bff;
            font-size: 1.6rem;				
        }

        .notice-date {
            font-size: 0.8rem;
            color: #999;
        }
 
        .register-btn,
        .qna-register-btn {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 5px;
        color: #fff;
        font-size: 0.9rem;
        margin-left: 10px;
        text-align: center;
        height: 35px !important; 
        }
        
		
/* 탭 메뉴 스타일 */
.tab-list {
    display: flex;
    justify-content: space-around;
    list-style: none;
    padding: 0;
    margin-bottom: 20px;
    background-color: #f8f8f8;
    border-radius: 8px;
    border: 1px solid #ddd;
}

.tab-list li {
    flex: 1;
    text-align: center;
}

.tab-list li a {
    display: block;
    padding: 10px;
    border-radius: 8px;
    background-color: #f8f8f8;
    color: #000;
    text-decoration: none;
}

.tab-list li a.active {
    background-color: #000; !important;
    color: #fff !important;
}

/* 추가적인 스타일 */
.inquiry-item {
    margin-bottom: 10px;
}

.inquiry-header a {
    font-size: 1.1rem;
}

.inquiry-content p {
    margin: 0;
    line-height: 1.5;
}
.status-box {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 5px;
        color: #fff;
        font-size: 0.9rem;
        margin-left: 10px;
    }
    .answered {
        background-color: rgb(253, 78, 2); /* 초록색 */
    }
    .waiting {
        background-color: #6c757d; /* 회색 */
    }
    
.cucontainer {
	max-width: 1590px;
	margin: 0 auto;
}

.cutab {
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
	<div class="cutab">
	<c:if test="${sessionScope.loginAdmin != null}">
		<div class="tabs">
		    <ul>
		        <li><a href="${contextPath}/admin/memList.do" >회원 관리</a></li>
		        <li><a href="${contextPath}/member/customer.do" class="active">고객센터</a></li>
		        <li><a href="${contextPath}/admin/prodmanagement.do" >상품 관리</a></li>
		    </ul>
		</div>
	</c:if>
	</div>
	<div class="cucontainer">
        <!-- 고객센터 페이지 내용 -->
        <main>
            <section class="customer-center">
                <h2>고객센터</h2>

                <!-- 공지사항 탭 콘텐츠 -->
                <c:if test="${param.boardcode == '1'}">
				    <div id="notices" class="tab-content active">
				        <c:forEach var="notice" items="${aList}">
				        </c:forEach>
				    </div>
				</c:if>
				

				<!-- 탭 메뉴 (공지사항, FAQ, 1:1 문의 가로 배치) -->
				<ul class="tab-list" style="...">
				    <li style="flex: 1; text-align: center;">
				        <a href="${contextPath}/member/customer.do?boardcode=1" class="${(param.boardcode == '1' || param.boardcode == null) && param.inquiry == null ? 'active' : ''}" style="...">공지사항</a>
				    </li>
				    <li style="flex: 1; text-align: center;">
				        <a href="${contextPath}/member/customer.do?boardcode=2" class="${param.boardcode == '2' && param.inquiry == null ? 'active' : ''}" style="...">FAQ</a>
				    </li>
				    <li style="flex: 1; text-align: center;">
				        <a href="${contextPath}/member/customer.do?inquiry=1" class="${param.inquiry == '1' ? 'active' : ''}" style="...">1:1 문의</a>
				    </li>
				</ul>


				
				<!-- 공지사항 탭 콘텐츠 (기본으로 활성화된 상태) -->
				<c:if test="${param.boardcode == '1' || param.boardcode == null && param.inquiry == null}">
				    <div id="notices" class="tab-content active" style="border: 1px solid #ddd; padding: 20px; border-radius: 8px;">
				        <!-- 공지사항 리스트 -->
				        <div id="faqs" class="tab-content active" >
						<c:forEach var="notice" items="${aList}">
						    <div class="notice-item" style="display: flex; justify-content: space-between; align-items: center; padding: 7px 0; border-bottom: 1px solid #eee; margin-bottom: 20px;"> <!-- 여기 margin-bottom 추가 -->
						        <!-- 공지사항 제목 -->
						        <div>
						            <a href="${contextPath}/board/detail.do?board_no=${notice.board_no}" style="text-decoration: none; color: #212121;  font-size: 1.2rem;">${notice.title}</a>
						        </div>
						        <!-- 작성일 및 관리자용 버튼 -->
						        <div style="text-align: right;">
						            <span class="notice-date" style="font-size: 0.8rem; color: #999; margin-right: 10px;">
						                <fmt:formatDate value="${notice.date_of_pre}" pattern="yyyy-MM-dd"/>
						            </span>
						            <span class="notice-writer" style="font-size: 0.8rem; color: #999; margin-right: 10px;">${notice.writer}</span>
						            <!-- 관리자만 수정/삭제 버튼 표시 -->
						            <c:if test="${sessionScope.loginAdmin != null}">
						                <a href="${pageContext.request.contextPath}/notice/edit.do?board_no=${notice.board_no}" class="update-btn" style="font-size: 15px;  padding: 6px 10px; background-color: rgb(253, 78, 2); color: white; border-radius: 5px; text-decoration: none; margin-right: 5px; transition: background-color 0.3s ease;">수정</a>
						                <a href="${pageContext.request.contextPath}/notice/delete.do?board_no=${notice.board_no}" class="delete-btn" style="font-size: 15px;  padding: 6px 10px; background-color: white; color: rgb(253, 78, 2); border-radius: 5px; text-decoration: none; border: 1px solid; border-color: rgb(253, 78, 2);" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
						            </c:if>
						        </div>
						    </div>
						</c:forEach>
				        
				        <!-- 관리자만 공지사항 등록 버튼 표시 -->
				        <c:if test="${sessionScope.loginAdmin != null && (param.boardcode == '1' || param.boardcode == null && param.inquiry == null)}">
				            <div style="text-align: right; margin-top: 90px;">
				                <a href="${pageContext.request.contextPath}/notice/form.do" class="register-btn" style="font-size: 15px;  padding: 5px 9px; background-color: #000000; color: white; border-radius: 5px; text-decoration: none; width: 100px;">등록</a>
				            </div>
				        </c:if>
				      </div>
				      </div>
				</c:if>
				
                <!-- FAQ 탭 콘텐츠 -->
				<c:if test="${param.boardcode == '2'}">
				    <div id="faqs" class="tab-content active" style="border: 1px solid #ddd; padding: 20px; border-radius: 8px;">
				        <c:if test="${not empty aList}">
				            <c:forEach var="faq" items="${aList}">
				                <!-- FAQ 제목 클릭시 내용 토글 -->
				                <div class="faq-item" style=" justify-content: space-between; align-items: center; padding: 7px 0; border-bottom: 1px solid #eee; margin-bottom: 20px;"> <!-- margin-bottom과 padding 추가 -->
				                    <a href="${contextPath}/member/customer.do?boardcode=2&detail=${faq.board_no}" style="text-decoration: none; color: #212121; display: block; margin-bottom: 10px;">${faq.title}</a>
				                    <!-- FAQ 내용 조건적 표시 -->
				                    <c:if test="${param.detail == faq.board_no}">
				                        <div class="faq-detail" style="padding: 15px; color: #8c8c8c; background-color: #f8f8f8; border-radius: 5px;">
				                            ${faq.detail} <!-- FAQ 내용 -->
				                        </div>
				                    </c:if>
				                </div>
				            </c:forEach>
				        </c:if>
				        <c:if test="${empty aList}">
				            <p>현재 등록된 FAQ가 없습니다.</p>
				        </c:if>
				    </div>
				</c:if>
				
				
				<!-- 1:1 문의 탭 콘텐츠 -->
				<c:if test="${param.inquiry == '1'}"> 
				    <div class="tab-content active" style="border: 1px solid #ddd; padding: 30px; border-radius: 8px; margin-top: 10px;">
				        
				        <!-- 게시글 리스트 -->
				        <div class="inquiry-list">
				            <c:forEach var="question" items="${boardList}">
				                <!-- 게시글 아이템 -->
				            <div class="inquiry-item" style="border-bottom: 1px solid #eee; padding: 10px 0;">
				                <div style="display: flex; justify-content: space-between; align-items: center;">
				                    <!-- 제목, 등록일, 작성자 -->
				                        <div>
											<!--제목 -->
				                            <a href="javascript:void(0);" onclick="toggleInquiryContent('content${question.question_no}')" style="text-decoration: none; color: #212121;">
				                                ${question.question_title}
				                            </a>
											<!-- 답변 상태 표시-->
											<c:choose>
											<c:when test="${not empty question.answer_content}">
						                        <span class="status-box answered">답변완료</span>
						                    </c:when>
						                    <c:otherwise>
						                        <span class="status-box waiting">답변대기</span>
						                    </c:otherwise>
											</c:choose>
				                        </div>
										<!--작성일, 작성자 -->
				                        <div style="font-size: 0.8rem; color: #666;">
				                            날짜: <fmt:formatDate value="${question.question_date}" pattern="yyyy-MM-dd"/> | 작성자: ${question.mem_id}
				                        </div>
				                    </div>
				                    
				                    <!-- 내용 및 관리자 답변 (토글 영역) -->
				                    <div id="content${question.question_no}" class="inquiry-content" style="display: none; padding: 10px 0;">
				                        <!-- 내용 -->
				                        <div class="question-content" style="margin-bottom: 10px;">
				                            <p>${question.question_content}</p>
				                        </div>
				                        
				                        <!-- 관리자 답변 -->
				                        <div class="admin-answer" style="background-color: #f9f9f9; padding: 10px; border-radius: 5px;">
				                            <c:choose>
				                                <c:when test="${not empty question.answer_content}">
				                                    <p><strong>${question.admin_nick}</strong> : <br> &nbsp;&nbsp;&nbsp; ${question.answer_content}</p>
				                                	<div style="text-align: right;">
				                                	<p><small>
				                                		답변일 : <fmt:formatDate value="${question.answer_date}" pattern="yyyy-MM-dd"/>
				                                	</small></p>
				                                	</div>
				                                </c:when>
				                                <c:otherwise>
				                                    <p>아직 답변이 없습니다.</p>
				                                </c:otherwise>
				                            </c:choose>
				                        </div>
				                        
				                        <!-- 수정 및 삭제 버튼 (작성자, 관리자만 표시) -->
										<c:if test="${(sessionScope.loginUser != null && sessionScope.loginUser.mem_no == question.mem_no) || sessionScope.loginAdmin != null}">
										    <div class="action-buttons" style="margin-top: 10px;  margin-bottom: 20px; display: flex; justify-content: flex-end; gap: 10px;">
											    <!-- 관리자일 경우에만 답변 버튼 보이기 -->
										        <c:if test="${sessionScope.loginAdmin != null}">
										            <a href="${pageContext.request.contextPath}/admin/answerForm.do?question_no=${question.question_no}" class= "qna-answer-btn" 
										                style="font-size: 15px; padding: 6px 10px; background-color: #000000; color: #fff; border-radius: 5px; text-decoration: none;">답변</a>
										        </c:if>
										        
										        <a href="javascript:void(0);" class= "qna-delete-btn" onclick="confirmDelete(${question.question_no})" 
										        style="font-size: 15px; padding: 6px 10px; background-color: #808080; color: #fff; border-radius: 5px; text-decoration: none;">삭제</a>
											    
										    </div>
										</c:if>
										
				                    </div>
				                </div>
				            </c:forEach>
				        </div>

					<c:if test="${sessionScope.loginAdmin == null}">
						<!--문의하기 버튼 -->
				        <div style="margin-top: 20px; text-align: right;">
				            <a href="${pageContext.request.contextPath}/member/inquiryForm.do" class= "qna-register-btn" style="font-size: 15px;  padding: 5px 9px; background-color: #000000; color: white; border-radius: 5px; text-decoration: none; width: 100px;">문의하기</a>
				        </div>
					</c:if>
				    </div>
					</c:if>
					




				
            </section>
        </main>
	<%@include file="/Includes/footer.jsp" %>
      </div> 
    </div>

    <!-- 하단바 토글 기능 추가 -->
    <script>
	    function confirmDelete(questionNo) {
	        if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
	            location.href = "${pageContext.request.contextPath}/member/deleteQuestion.do?questionNo=" + questionNo;
	        }
	    }
        function toggleFooterMenu() {
            const footerMenu = document.getElementById('footerMenu');
            footerMenu.style.display = footerMenu.style.display === 'none' || footerMenu.style.display === '' ? 'block' : 'none';
        }
        (function() {
            function toggleInquiryContent(id) {
                var content = document.getElementById(id);
                if (content.style.display === "none" || content.style.display === "") {
                    content.style.display = "block";
                } else {
                    content.style.display = "none";
                }
            }
            // 함수가 전역 스코프에서 호출될 수 있도록 설정
            window.toggleInquiryContent = toggleInquiryContent;
        })();
    </script>
</body>

</html>
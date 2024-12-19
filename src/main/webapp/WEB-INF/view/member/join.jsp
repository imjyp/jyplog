<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>   

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
      * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
          font-family: 'Noto Sans KR', sans-serif;
      }

      body {
          display: flex;
          justify-content: center;
          align-items: flex-start;;
          min-height: 100vh;
          background-color: #f5f5f5;
          padding: 20px;
      }

      .signup-container {
          background-color: #fff;
          padding: 40px;
          border-radius: 8px;
          box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
          text-align: left;
          width: 400px;
      }

      .signup-container h1 {
          font-size: 1.5rem;
          margin-bottom: 20px;
          font-weight: bold;
          text-align: center;
      }
      
.logo {
    text-align: center; /* 로고를 가운데 정렬 */
    margin-bottom: 20px; /* 아래 여백 추가 */
}

.logo img {
    width: 60px; /* 로고 크기 설정 */
    height: auto; /* 비율을 유지하며 크기 조정 */
}


.input-group {
    margin-bottom: 15px;
}

.input-group label {
    display: block;
    margin-bottom: 5px;
    font-size: 0.9rem;
    color: #333;
}

 .input-field {
    width: 100%;
    padding: 10px;
   
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 0.9rem;
    box-sizing: border-box;
}

.input-field-half {
    width: calc(50% - 3px); /* 절반 너비로 설정 (간격을 줄여 더 정확한 계산) */
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 0.9rem;
    box-sizing: border-box; /* padding과 border를 너비 계산에 포함 */
    display: inline-block;
}

.phone-inputs {
    display: flex;
    gap: 10px;
}

.id-container,
.nick-container {
    display: flex; 
    align-items: center;
}

.btn-signup {
    width: 100%;
    padding: 12px;
    background-color: #000000;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    margin-top: 15px;
}
.btn-signup:hover {
    background-color: #000000;
}

.terms {
    font-size: 0.8rem;
    margin-top: 10px;
    line-height: 1.5;
}

.terms input {
    margin-right: 5px;
}

.footer-link {
    text-align: center;
    margin-top: 20px;
    font-size: 0.8rem;
}

.footer-link a {
    text-decoration: none;
    color: #000000;
    font-weight: bold;
    font-size: 1rem;
}

.custom-domain {
    width: 100%; /* 전체 너비로 설정 */
    padding: 10px;
    margin-top: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 0.9rem;
    box-sizing: border-box;
}
        
.input-field-phone {
    width: calc(25% - 10px); /* 필드 간 적절한 간격을 주기 위해 너비 조정 */
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 0.9rem;
	}

.nick-container .input-field,
.id-container .input-field {
    flex: 1; /* 입력 필드가 가능한 공간을 모두 차지하도록 설정 */
    margin-right: 10px; /* 버튼과의 간격 추가 */
}

#checkNickBtn,
#checkIdBtn {
    width: auto; /* 버튼의 너비를 자동으로 설정 (내용에 맞춤) */
    padding: 8px 12px; /* 위아래 8px, 좌우 12px의 여백을 설정하여 버튼 크기 조절 */
    background-color: #000000; /* 배경색을 검정색으로 설정 */
    color: white; /* 텍스트 색상을 흰색으로 설정 */
    border: none; /* 테두리 없음 */
    border-radius: 4px; /* 모서리를 둥글게 */
    cursor: pointer; /* 마우스를 올리면 포인터 표시 */
    font-size: 1rem; /* 글씨 크기 설정 */
    margin-left: 5px; /* 입력 필드와 버튼 사이의 여백 추가 */
    vertical-align: middle;
}
	

    
    </style>
</head>
<body>
	
    <div class="signup-container">
    	<div class="logo">
		    <a href="${contextPath}/main/main.do" class="logo">
			<img alt="" src="${contextPath}/images/logo.png">
			</a>
		</div>
        <h1>회원가입</h1>
<%--         <form id="joinForm" action="${pageContext.request.contextPath}/member/join.do" method="post" onsubmit="combineEmail(event)"> --%>
<%--         <form id="joinForm" action="${pageContext.request.contextPath}/member/join.do" method="post" onsubmit="validateForm(event, '??')"> --%>
        <form id="joinForm" action="${pageContext.request.contextPath}/member/join.do" method="post" onsubmit="return handleFormSubmit(event)">
            <div class="input-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" class="input-field" placeholder="이름을 입력해주세요">
            </div>

            <div class="input-group">
                <label for="id">아이디</label>
                <div class="id-container">
                <input type="text" id="id" name="id" class="input-field" placeholder="영어, 숫자 포함 4자 ~ 15자">
                <button type="button" id="checkIdBtn">중복검사</button>
                </div>
                <span id="idCheckResult"></span>
            </div>

            <div class="input-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" class="input-field" placeholder="특수문자 포함 8자 이상">
            </div>

            <div class="input-group">
                <label for="email">이메일</label>
                <div>
                    <input type="text" id="email" name="email" class="input-field-half" placeholder="이메일">
                    <select name="emailDomain" id="emailDomain" class="input-field-half">
                        <option value="">선택해주세요</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="custom">직접 입력</option>
                    </select>
                </div>
                <input type="text" id="customEmailDomain" name="customEmailDomain" class="input-field custom-domain" placeholder="도메인 입력">
                <input type="hidden" id="fullEmail" name="fullEmail">
            </div>

            <div class="input-group">
                <label for="phone">휴대폰 번호</label>
                <div class="phone-inputs">
                    <input type="text" id="phone1" name="phone1" class="input-field-half" placeholder="010">
                    <input type="text" id="phone2" name="phone2" class="input-field-half" placeholder="1234">
                    <input type="text" id="phone3" name="phone3" class="input-field-half" placeholder="5678">
                </div>
            </div>

            <div class="input-group">
                <label for="nick">닉네임</label>
                <div class="nick-container">
                <input type="text" id="nick" name="nick" class="input-field" placeholder="2자 ~ 20자">
                <button type="button" id="checkNickBtn">중복검사</button>
                </div>
                <span id="nickCheckResult"></span>
            </div>

			
			<div class="terms">
                <label><input type="checkbox" id="masterCheckbox" onclick="toggleAllCheckboxes(this)"> 전체동의 (선택항목에 대한 동의 포함)</label><br>
                <label><input type="checkbox" name="terms_age" required> 14세 이상입니다 (필수)</label><br>
                <label><input type="checkbox" name="terms_service" required> 이용약관 (필수)</label><br>
                <label><input type="checkbox" name="terms_privacy" required> 개인정보 수집 및 이용 동의 (필수)</label><br>
                <label><input type="checkbox" name="terms_marketing"> 이벤트, 맞춤 혜택 등 알림 정보 수신 (선택)</label>
            </div>
            <button type="submit" class="btn-signup">회원가입</button>

            <div class="footer-link">
                <p>이미 아이디가 있으신가요? <a href="${pageContext.request.contextPath}/member/login.do">로그인</a></p>
            </div>
            
        </form>
    </div>
    <!-- JavaScript 코드 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
 	<script type="text/javascript">
        const contextPath = '<%= request.getContextPath() %>'; // JSP에서 contextPath를 JavaScript로 전달
        console.log("Context Path: " + contextPath);

    // 아이디 중복검사
    function checkId() {
        const idInput = document.getElementById('id');
        console.log("ID input element: ", idInput);  // input element가 제대로 잡히는지 확인
        const id = idInput ? idInput.value.trim() : null;
        console.log("ID 값 확인: '" + id + "'");  // 클라이언트에서 ID 값 확인

        if (!id) {
            alert('아이디를 입력해주세요.');
            return;
        }

        const requestUrl = `/MiddleProject2/member/checkId.do?id=\${id}`;  	
        console.log("Request URL: " + requestUrl);  // 클라이언트에서 URL 확인

        fetch(requestUrl, {
            method: 'GET'
        })
        .then(response => {
            console.log("Response status: " + response.status);  // 응답 상태 확인
            return response.text();
        })
        .then(data => {
            console.log("Received response for ID check: " + data);  // 서버 응답 확인
            const messageElement = document.getElementById('idCheckResult');

            if (!data || data.trim() === "") {
                console.error("Empty response received from server");
                alert('서버에서 빈 응답을 받았습니다. 다시 시도해주세요.');
                return;
            }

            if (data.trim() === 'true') {
                messageElement.innerHTML = '사용 가능한 아이디입니다.';
                messageElement.style.color = 'green';
            } else if (data.trim() === 'false') {
                messageElement.innerHTML = '이미 존재하는 아이디입니다.';
                messageElement.style.color = 'red';
            } else {
                messageElement.innerHTML = '서버 오류가 발생했습니다.';
                messageElement.style.color = 'red';
            }
        })
        .catch(error => {
            console.error('ID 중복 검사 오류:', error);  // 오류 발생 시 로그
            alert('ID 중복 검사 중 오류가 발생했습니다.');
        });
    }

    document.getElementById('checkIdBtn').addEventListener('click', checkId); // ID 중복 검사 함수 호출
    
    // 닉네임 중복 체크 함수
         function checkNick() {
        	const nickInput = document.getElementById('nick');
            console.log("nick input element: ", nickInput);  // input element가 제대로 잡히는지 확인
            const nick = nickInput ? nickInput.value.trim() : null;
            console.log("닉네임 값 확인: '" + nick + "'");  // 클라이언트에서 ID 값 확인
            
            if (!nick) {
                alert('닉네임을 입력해주세요.');
                return;
            }
            
            const requestUrl = `/MiddleProject2/member/checkNick.do?nick=\${nick}`;  	
            console.log("Request URL: " + requestUrl);  // 클라이언트에서 URL 확인

            fetch(requestUrl, {
                method: 'GET'
            })
            .then(response => {
                console.log("Response status: " + response.status);  // 응답 상태 확인
                return response.text();
            })
            .then(data => {
            console.log("Received response for 닉네임 check: " + data);  // 서버 응답 확인
            const messageElement = document.getElementById('nickCheckResult');

            if (!data || data.trim() === "") {
                console.error("Empty response received from server");
                alert('서버에서 빈 응답을 받았습니다. 다시 시도해주세요.');
                return;
            }
            if (!data || data.trim() === "") {
                console.error("Empty response received from server");
                alert('서버에서 빈 응답을 받았습니다. 다시 시도해주세요.');
                return;
            }

            if (data.trim() === 'true') {
                messageElement.innerHTML = '사용 가능한 닉네임입니다.';
                messageElement.style.color = 'green';
            } else if (data.trim() === 'false') {
                messageElement.innerHTML = '이미 존재하는 닉네임입니다.';
                messageElement.style.color = 'red';
            } else {
                messageElement.innerHTML = '서버 오류가 발생했습니다.';
                messageElement.style.color = 'red';
            }
        })
        .catch(error => {
            console.error('닉네임 중복 검사 오류:', error);  // 오류 발생 시 로그
            alert('닉네임 중복 검사 중 오류가 발생했습니다.');
        });
    }
    
         document.getElementById('checkNickBtn').addEventListener('click', checkNick);  // 닉네임 중복 검사 함수 호출
         
//             const requestUrl = `/MiddleProject2/member/checkNick.do?nick=\${nick}`;  	
//             console.log("Request URL: " + requestUrl);  // 클라이언트에서 URL 확인
            
            
            /*
            $.ajax({
                url: `/MiddleProject2/member/checkNick.do`,
                type: 'GET',
                data: { nick: nickInput },
                success: function(response) {
                    const messageElement = $('#nickCheckResult');

                    if (response.trim() === 'true') {
                        messageElement.text('사용 가능한 닉네임입니다.');
                        messageElement.css('color', 'green');
                    } else if (response.trim() === 'false') {
                        messageElement.text('이미 존재하는 닉네임입니다.');
                        messageElement.css('color', 'red');
                    } else {
                        messageElement.text('서버 오류가 발생했습니다.');
                        messageElement.css('color', 'red');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('닉네임 중복 검사 오류:', error);
                    alert('닉네임 중복 검사 중 오류가 발생했습니다.');
                }
            });
        }

//         $('#checkNickBtn').click(checkNick);

    
    document.getElementById('checkNickBtn').addEventListener('click', checkNick);  // 닉네임 중복 검사 함수 호출
     */
     
    function combineEmail(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        
        const email = document.getElementById('email').value.trim();
        const emailDomain = document.getElementById('emailDomain').value;
        const customDomain = document.getElementById('customEmailDomain').value.trim();
        
        // 이메일이 빈 값인지 확인
        if (!email) {
            alert('이메일을 입력해주세요.');
            return;
        }

        // 도메인이 선택되지 않거나 입력되지 않은 경우 처리
        let finalDomain;
        if (emailDomain === 'custom' && customDomain) {
            finalDomain = customDomain;
        } else if (emailDomain) {
            finalDomain = emailDomain;
        } else {
            alert('이메일 도메인을 선택해주세요.');
            return;
        }

        // 이메일 주소 조합
        const fullEmail = `${email}@${finalDomain}`;
        document.getElementById('fullEmail').value = fullEmail;

        console.log("조합된 이메일:", fullEmail); // 디버깅용 콘솔 출력
        
        // 폼 제출
//         document.getElementById('joinForm').submit();
    }

    // 도메인 선택 시 직접 입력 필드 처리
    document.getElementById('emailDomain').addEventListener('change', function () {
        const customDomainField = document.getElementById('customEmailDomain');
        if (this.value === 'custom') {
            customDomainField.style.display = 'block';
            customDomainField.required = true;
        } else {
            customDomainField.style.display = 'none';
            customDomainField.required = false;
        }
    });

    // 폼 제출 시 유효성 검사
    //추후 삭제하거나 수정하거나
    /* document.getElementById('joinForm').addEventListener('submit', function (event) {
        if (!validateForm()) {
            event.preventDefault();
        }
    }); */
    
   /*  function handleFormSubmit(event) {
        // 유효성 검사가 통과되지 않으면 false 반환
        if (!validateForm(event)) {
            return false;
        }
        
        // 유효성 검사가 통과되면 이메일 조합 후 폼 제출
        combineEmail(event);
        
        return true;  // 폼이 정상적으로 제출되도록 true 반환
    } */
    
    // 유효성 검사 함수
    function validateForm(event) {
//         event.preventDefault();
        
        const id = document.getElementById('id').value.trim();
        const pw = document.getElementById('pw').value.trim();
        const nick = document.getElementById('nick').value.trim();

        const idRegex = /^[a-zA-Z0-9]{4,15}$/;
        if (!idRegex.test(id)) {
            alert('아이디는 영어, 숫자 포함 4~15자로 입력해주세요.');
            return false;
        }

        const pwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
        if (!pwRegex.test(pw)) {
            alert('비밀번호는 영문, 숫자, 특수문자 포함 8자 이상으로 입력해주세요.');
            return false;
        }

        const nickRegex = /^[a-zA-Z0-9가-힣]{2,20}$/;
        if (!nickRegex.test(nick)) {
            alert('닉네임은 공백이나 특수문자 없이 2~20자로 입력해주세요.');
            return false;
        }

        return true; // 유효성 검사를 통과했을 때만 폼을 제출
    }
    
    function toggleAllCheckboxes(masterCheckbox) {
        const checkboxes = document.querySelectorAll('.terms input[type="checkbox"]');
        checkboxes.forEach((checkbox) => {
            checkbox.checked = masterCheckbox.checked;
        });
    }
    
    function validateRequiredFields() {
        const name = document.getElementById('name').value.trim();
        const id = document.getElementById('id').value.trim();
        const pw = document.getElementById('pw').value.trim();
        const email = document.getElementById('email').value.trim();
        const emailDomain = document.getElementById('emailDomain').value;
        const phone1 = document.getElementById('phone1').value.trim();
        const phone2 = document.getElementById('phone2').value.trim();
        const phone3 = document.getElementById('phone3').value.trim();
        const nick = document.getElementById('nick').value.trim();
        
        // 필수 항목이 비어 있는지 확인
        if (!name) {
            alert('이름을 입력해주세요.');
            return false;
        }
        if (!id) {
            alert('아이디를 입력해주세요.');
            return false;
        }
        if (!pw) {
            alert('비밀번호를 입력해주세요.');
            return false;
        }
        if (!email || (!emailDomain && document.getElementById('customEmailDomain').value.trim() === '')) {
            alert('이메일과 도메인을 모두 입력해주세요.');
            return false;
        }
        if (!phone1 || !phone2 || !phone3) {
            alert('휴대폰 번호를 모두 입력해주세요.');
            return false;
        }
        if (!nick) {
            alert('닉네임을 입력해주세요.');
            return false;
        }
        
        // 필수 항목이 모두 입력되었으면 true 반환
        return true;
    }
    
    function handleFormSubmit(event) {
        event.preventDefault(); // 폼 기본 제출 동작 방지

        // 유효성 검사 먼저 수행
        if (!validateForm(event)) {
            return false; // 유효성 검사를 통과하지 못하면 폼 제출 방지
        }

        // 필수 항목 확인
        if (!validateRequiredFields()) {
            return false; // 필수 항목이 입력되지 않았다면 폼 제출 방지
        }

        // 이메일 조합 후 폼 제출
        combineEmail(event);
        
        document.getElementById('joinForm').submit();
        return true;
    }
    
    
    </script>

</body>
</html>

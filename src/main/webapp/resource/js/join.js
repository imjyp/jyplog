/**
 * 
 */

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

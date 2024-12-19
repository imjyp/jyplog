document.addEventListener("DOMContentLoaded", function() {
   // localStorage에서 알림 개수와 마지막 알림 메시지를 가져옵니다.
    let notificationCount = localStorage.getItem('notificationCount') ? parseInt(localStorage.getItem('notificationCount')) : 0;
    let latestNotification = localStorage.getItem('latestNotification') || '';

    // 알림 배지를 초기화합니다.
    updateNotificationBadge();

    // WebSocket을 통한 실시간 알림 처리
    function connectWebSocket() {
        const protocol = window.location.protocol === 'https:' ? 'wss://' : 'ws://';
        const host = window.location.host;
        const websocketURL = `${protocol}${host}/MiddleProject2/websocket`;

        console.log("Attempting to connect to WebSocket at", websocketURL);

        let websocket;
        try {
            websocket = new WebSocket(websocketURL);
        } catch (e) {
            console.error("WebSocket initialization error:", e);
            return;
        }

        // WebSocket 연결이 성공적으로 열렸을 때
        websocket.addEventListener('open', function() {
            console.log("WebSocket connection opened");
        });

        // WebSocket 메시지를 수신했을 때
        websocket.addEventListener('message', function(event) {
            console.log("Received message: ", event.data);

            // 알림 개수를 1 증가하고 localStorage에 저장
            notificationCount++;
            localStorage.setItem('notificationCount', notificationCount);

            // 최신 알림 메시지를 업데이트하고 localStorage에 저장
            latestNotification = event.data;
            localStorage.setItem('latestNotification', latestNotification);

            updateNotificationBadge();
        });

        // WebSocket 연결이 닫혔을 때
        websocket.addEventListener('close', function(event) {
            console.log("WebSocket connection closed", event);
            // 일정 시간 후 재연결 시도 (예: 5초 후)
            setTimeout(connectWebSocket, 5000);
        });

        // WebSocket 오류가 발생했을 때
        websocket.addEventListener('error', function(error) {
            console.error("WebSocket error: ", error);
            websocket.close();
        });
    }

    // 페이지 로드 시 WebSocket 연결
    connectWebSocket();

    // 알림 배지 업데이트 함수
    function updateNotificationBadge() {
        var notificationBadge = document.getElementById("notificationBadge");

        if (notificationBadge) {
            notificationBadge.textContent = notificationCount;

            // 알림이 있을 때만 배지를 표시
            if (notificationCount > 0) {
                notificationBadge.style.display = 'block';
            } else {
                notificationBadge.style.display = 'none';
            }
        } else {
            console.error("Notification badge element not found");
        }
    }

    // 알림 아이콘 클릭 시 알림 메시지를 표시
    var notificationIcon = document.getElementById("notificationIcon");
    if (notificationIcon) {
        notificationIcon.onclick = function(event) {
            // 드롭다운이나 다른 요소가 열리지 않도록 이벤트 전파 중단
            event.stopPropagation();

            if (latestNotification) {
                alert("🔔새로운 알림🔔: " + latestNotification);

                // 알림 확인 후 카운트와 메시지를 초기화하고 localStorage에 반영
                notificationCount = 0;
                localStorage.setItem('notificationCount', notificationCount);

                latestNotification = '';
                localStorage.setItem('latestNotification', latestNotification);

                updateNotificationBadge();
            } else {
                alert("새로운 알림이 없습니다.");
            }
        };
    }



    
    // 글쓰기 드롭다운 토글 함수
    function toggleWriteDropdown() {
        var dropdownMenu = document.getElementById('writeDropdown');
        if (dropdownMenu) {
            dropdownMenu.style.display = dropdownMenu.style.display === 'none' || dropdownMenu.style.display === '' ? 'block' : 'none';
        }
    }

    // 사용자 드롭다운 토글 함수 (로그인한 회원 및 관리자)
    function toggleUserDropdown(dropdownId) {
        var dropdownMenu = document.getElementById(dropdownId);
        if (dropdownMenu) { 
            dropdownMenu.style.display = dropdownMenu.style.display === 'none' || dropdownMenu.style.display === '' ? 'block' : 'none';
        }
    }

    // 버튼 이벤트 리스너 추가
/*    var writeButton = document.getElementById("writeButton");
    if (writeButton) {
        writeButton.onclick = toggleWriteDropdown;
    }*/
    

    // 사용자 드롭다운
    var userButton = document.getElementById("userButton");
    if (userButton) {
        userButton.onclick = function() {
            toggleUserDropdown('userDropdownMenuUser');
        };
    }

    // 관리자 드롭다운
    var adminButton = document.getElementById("adminButton");
    if (adminButton) {
        adminButton.onclick = function() {
            toggleUserDropdown('userDropdownMenuAdmin');
        };
    }

    // 외부 클릭 시 모든 드롭다운 닫기
    window.onclick = function(event) {
        if (!event.target.matches('.write button') && !event.target.matches('.id') && !event.target.matches('.admin-button')) {
            closeAllDropdowns();
        }
    };

    // 모든 드롭다운 메뉴를 닫는 함수
    function closeAllDropdowns() {
        var dropdowns = document.getElementsByClassName("dropdown-menu");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.style.display === "block") {
                openDropdown.style.display = "none";
            }
        }
    }

    // 위시리스트 페이지로 이동하는 함수
    function goToWishlist() {
        window.location.href = '/wishlist.do';
    }
});

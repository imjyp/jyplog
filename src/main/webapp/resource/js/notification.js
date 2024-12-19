	// WebSocket 변수를 글로벌 스코프에서 선언
	let websocket;
	let reconnectInterval = 3000; // 재연결 시도 간격 (3초)
	
	// WebSocket 연결 함수
	function connectWebSocket() {
	    websocket = new WebSocket("ws://localhost:8080/MiddleProject2/websocket");
	
	    websocket.onopen = function() {
	        console.log("WebSocket connection opened");
	    };
	
	    websocket.onmessage = function(event) {
	        console.log("Received message: ", event.data);
	
	        var notificationList = document.getElementById("notification-list");
	
	        if (notificationList) {
	            var newNotification = document.createElement("li");
	            newNotification.classList.add("notification-item");
	            newNotification.textContent = event.data;
	
	            notificationList.appendChild(newNotification);
	        } else {
	            console.error("Notification list element not found");
	        }
	    };
	
	    websocket.onclose = function() {
	        console.log("WebSocket connection closed, attempting to reconnect...");
	        setTimeout(connectWebSocket, reconnectInterval);  // 3초 후 재연결 시도
	    };
	
	    websocket.onerror = function(error) {
	        console.error("WebSocket error: ", error);
	    };
	}
	
	// 페이지 로드 시 자동으로 WebSocket 연결
	window.onload = function() {
	    connectWebSocket();
	};
	
	// WebSocket 연결을 유지하기 위한 ping 메시지 전송
	function keepAlive() {
	    if (websocket.readyState === websocket.OPEN) {
	        console.log('Sending ping...');
	        websocket.send('ping');  // 서버에 유지 메시지 전송
	    }
	}
	
	// 일정 시간마다 ping 메시지 보내기 (30초마다 예시)
	setInterval(keepAlive, 30000);

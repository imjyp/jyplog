<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도로명 주소 검색</title>

    <!-- 도로명 주소 검색 API 스크립트 -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 선택한 도로명 주소와 우편번호를 가져옵니다.
                    var roadAddr = data.roadAddress; // 도로명 주소
                    var zipNo = data.zonecode; // 우편번호

                    // 부모 창의 콜백 함수로 전달
                    opener.jusoCallBack(roadAddr, zipNo);

                    // 팝업 닫기
                    window.close();
                }
            }).open();
        }
    </script>
</head>
<body onload="execDaumPostcode()">
    <h3>도로명 주소 검색</h3>
    <p>도로명 주소를 검색하는 중입니다. 잠시만 기다려 주세요...</p>
</body>
</html>

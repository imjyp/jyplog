package kr.or.ddit.order.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;

//import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/kakaoPay")
public class KakaoPayController extends HttpServlet {
    
    private static final String KAKAO_API_KEY = "601d553288db395931b3725aab893fb8";  // REST API 키
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 결제 준비 API URL
            URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            
            // POST 요청을 위한 설정
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Authorization", "KakaoAK " + KAKAO_API_KEY);
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
            connection.setDoOutput(true);

            // 파라미터 작성
            String params = "cid=TC0ONETIME&" +  // 테스트용 가맹점 코드
                            "partner_order_id=1001&" +  // 주문번호
                            "partner_user_id=USER1234&" +  // 사용자 ID
                            "item_name=상품명&" +  // 상품명
                            "quantity=1&" +  // 수량
                            "total_amount=1000&" +  // 총 결제 금액
                            "vat_amount=200&" +  // 부가세 금액
                            "tax_free_amount=0&" +  // 비과세 금액
                            "approval_url=http://localhost:38080/MiddleProject2/success.jsp&" +  // 결제 성공 시 이동할 URL
                            "cancel_url=http://localhost:38080/MiddleProject2/cancel.jsp&" +  // 결제 취소 시 이동할 URL
                            "fail_url=http://localhost:38080/MiddleProject2/fail.jsp";  // 결제 실패 시 이동할 URL

            // 데이터 전송
            OutputStream os = connection.getOutputStream();
            os.write(params.getBytes());
            os.flush();
            os.close();

            // 응답 확인
            int responseCode = connection.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) {  // 성공
                br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            } else {  // 오류
                br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            }

            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            // 응답 결과 처리
            JSONObje
            ct jsonResponse = new JSONObject(response.toString());
            String redirectUrl = jsonResponse.getString("next_redirect_pc_url");

            // 클라이언트로 리디렉션 URL 전송
            resp.setContentType("application/json");
            resp.getWriter().write("{\"next_redirect_pc_url\": \"" + redirectUrl + "\"}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

package kr.or.ddit.member.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

@WebServlet("/member/checkId.do")
public class CheckIdController extends HttpServlet {

    IMemberService memberService = MemberServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 요청 데이터 UTF-8 인코딩 설정 (이 부분이 중요)
            req.setCharacterEncoding("UTF-8");

            // ID 파라미터 가져오기
            String id = req.getParameter("id");
            System.out.println("Received ID: '" + id + "'"); // 디버깅을 위한 ID 로그 출력
            System.out.println("Trimmed ID: " + id.trim());  // Trimmed 후 값 확인

            // ID가 null이거나 빈 값일 경우 처리
            if (id == null || id.trim().isEmpty()) {
                System.out.println("ID is null or empty."); // 로그 출력
                resp.setContentType("text/plain; charset=UTF-8");
                resp.getWriter().write("ID를 입력해주세요.");
                return;
            }

            // ID 중복 여부 확인
            boolean isIdExists = memberService.isIdExists(id);
            System.out.println("ID exists in DB: " + isIdExists); // 중복 여부 확인 로그

            // 클라이언트에 응답
            resp.setContentType("text/plain; charset=UTF-8");
            resp.getWriter().write(String.valueOf(!isIdExists)); // true: 사용 가능, false: 중복됨
        } catch (Exception e) {
            // 예외 처리 및 오류 로그 출력
            System.err.println("Error processing ID check: " + e.getMessage());
            e.printStackTrace(); // 스택 트레이스 출력
            resp.setContentType("text/plain; charset=UTF-8");
            resp.getWriter().write("error");
        }
    }
}

package kr.or.ddit.member.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/member/logout.do")
public class LogoutController extends HttpServlet {
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logout(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logout(req, resp); // POST 요청도 로그아웃 처리
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.invalidate(); // 세션 무효화
        
     // 로그아웃 메시지를 설정
        req.getSession().setAttribute("message", "로그아웃 처리가 되었습니다.");
        
//     // 메인 페이지로 포워딩 
//        req.getRequestDispatcher("/WEB-INF/main.jsp").forward(req, resp);
        
        resp.sendRedirect(req.getContextPath() + "/main/main.do"); // 유동적인 리다이렉트 경로 설정
    }

}

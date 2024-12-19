//package kr.or.ddit.mypage.controller;
//
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import kr.or.ddit.mypage.service.MypageService;
//import kr.or.ddit.mypage.service.MypageServiceImpl;
//import kr.or.ddit.mypage.vo.ProfileVo;
//
//@WebServlet("/mypage")
//public class FollowerController extends HttpServlet {
//
//    MypageService mypageService = MypageServiceImpl.getInstance();
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String userIdParam = req.getParameter("userId");
//        
//        // userId 파라미터가 유효한지 확인
//        if (userIdParam == null || userIdParam.isEmpty()) {
//            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId parameter");
//            return;
//        }
//        
//        // userId를 정수로 변환
//        int userId;
//        try {
//            userId = Integer.parseInt(userIdParam);
//        } catch (NumberFormatException e) {
//            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid userId parameter");
//            return;
//        }
//        
//        // 프로필 정보 조회 (이 부분은 아직 DB 연결이 없으니 주석 처리할 수 있습니다)
//        // ProfileVo profile = mypageService.viewProfile(userId);
//        ProfileVo profile = null; // 임시로 null로 설정
//        
//        // 조회한 프로필 정보를 JSP로 전달
//        req.setAttribute("profile", profile);
//        
//        // 마이페이지 JSP로 포워딩
//        req.getRequestDispatcher("/WEB-INF/view/mypage/follower.jsp").forward(req, resp);
//    }
//} 
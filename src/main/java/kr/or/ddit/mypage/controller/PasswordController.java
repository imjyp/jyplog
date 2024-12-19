package kr.or.ddit.mypage.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.service.MypageServiceImpl;

@WebServlet("/mypage/changePassword")
public class PasswordController extends HttpServlet {

    private MypageServiceImpl mypageService = MypageServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 로그 출력

        	System.out.println("PasswordController 요청 받음");

            // 세션에서 로그인한 사용자 정보 가져오기
            MemberVo loginUser = (MemberVo) req.getSession().getAttribute("loginUser");
            if (loginUser == null) {
                System.out.println("로그인된 사용자가 없습니다.");
                req.setAttribute("message", "로그인이 필요합니다.");
                req.getRequestDispatcher("/mypage/login.jsp").forward(req, resp);
                return;
            }

            // 사용자 아이디 및 비밀번호 파라미터 가져오기
            String userId = loginUser.getMem_id();
            String currentPassword = req.getParameter("currentPassword");
            String newPassword = req.getParameter("newPassword");

            // 입력된 비밀번호 로그
            System.out.println("입력된 현재 비밀번호: " + currentPassword);
            System.out.println("입력된 새 비밀번호: " + newPassword);

            // MemberVo 객체 생성
            MemberVo member = new MemberVo();
            member.setMem_id(userId);
            member.setMem_pw(currentPassword);

            // 현재 비밀번호 확인
            int passwordCount = mypageService.checkPassword(member);
            if (passwordCount > 0) {
                // 비밀번호가 일치할 경우 새 비밀번호로 업데이트
                member.setMem_pw(newPassword);
                int result = mypageService.updatePassword(member);

                if (result > 0) {
                    resp.getWriter().write("비밀번호가 성공적으로 변경되었습니다.");
                } else {
                    resp.getWriter().write("비밀번호 변경에 실패하였습니다.");
                }
            } else {
                resp.getWriter().write("현재 비밀번호가 일치하지 않습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("비밀번호 변경 중 오류가 발생하였습니다.");
        }
    }
}

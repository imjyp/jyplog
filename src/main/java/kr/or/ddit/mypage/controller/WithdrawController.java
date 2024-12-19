package kr.or.ddit.mypage.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.service.MypageServiceImpl;

@WebServlet("/mypage/withdraw")
public class WithdrawController extends HttpServlet {

    private MypageServiceImpl mypageService = MypageServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 세션에서 로그인한 사용자 정보 가져오기
            HttpSession session = req.getSession();
            MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");

            if (loginUser == null) {
                // 로그인이 되어 있지 않은 경우 로그인 페이지로 리다이렉트
                resp.sendRedirect(req.getContextPath() + "/mypage/login.jsp");
                return;
            }

            // 회원 탈퇴 처리를 위한 DEL_YN 값 업데이트 (1 -> 2)
            loginUser.setDel_yn(2); // DEL_YN = 2는 탈퇴 상태로 간주

            // 데이터베이스에서 DEL_YN 업데이트
            int result = mypageService.withdrawMember(loginUser);

            if (result > 0) {
                // 성공적으로 탈퇴 처리가 되었으면 세션 무효화 후 로그인 페이지로 리다이렉트
                session.invalidate();
                resp.getWriter().write("탈퇴가 성공적으로 완료되었습니다.");
            } else {
                resp.getWriter().write("회원 탈퇴 처리에 실패하였습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("회원 탈퇴 처리 중 오류가 발생했습니다.");
        }
    }
}

package kr.or.ddit.mypage.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.service.MypageServiceImpl;

import java.io.IOException;

@WebServlet("/mypage/updateMember")
public class InfoController extends HttpServlet {

    private MypageServiceImpl mypageService = MypageServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = req.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");

        if (loginUser != null) {
            // 사용자로부터 입력받은 값 가져오기
            String memName = req.getParameter("mem_name");
            String memNick = req.getParameter("mem_nick");
            String emailPart = req.getParameter("email_part");
            String emailDomain = req.getParameter("email_domain");
            String email = emailPart + "@" + emailDomain;
            String phonePart1 = req.getParameter("phone_part1");
            String phonePart2 = req.getParameter("phone_part2");
            String phonePart3 = req.getParameter("phone_part3");
            String phone = phonePart1 + "-" + phonePart2 + "-" + phonePart3;

            // 가져온 값을 MemberVo에 세팅
            loginUser.setMem_name(memName);
            loginUser.setMem_nick(memNick);
            loginUser.setEmail(email);
            loginUser.setPhone(phone);

            // 데이터베이스 업데이트
            int result = mypageService.updateMemberInfo(loginUser);

            if (result > 0) {
                // 수정 성공 시 세션 갱신
                session.setAttribute("loginUser", loginUser);

                // 성공 메시지를 출력하도록 수정
                req.setAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
                resp.sendRedirect(req.getContextPath() + "/mypage?action=meminfo&success=true");
            } else {
                req.setAttribute("message", "회원 정보 수정에 실패했습니다.");
                req.getRequestDispatcher("/WEB-INF/view/member/meminfo.jsp").forward(req, resp);
            }

        } else {
            // 로그인 정보가 없으면 로그인 페이지로 이동
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}

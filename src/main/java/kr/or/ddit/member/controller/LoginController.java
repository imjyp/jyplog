package kr.or.ddit.member.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/member/login.do")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IMemberService memberService = MemberServiceImpl.getInstance();
    IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/member/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String pw = req.getParameter("pw");

        // 일반 회원 로그인 처리
        MemberVo member = new MemberVo();
        member.setMem_id(id);
        member.setMem_pw(pw);

        MemberVo memberResult = memberService.login(member);
        System.out.println("ID: " + id + ", PW: " + pw);  // 입력한 아이디와 비밀번호 출력
        System.out.println("login result: " + memberResult);

        if (memberResult != null) {
            if (memberResult.getDel_yn() == 2) { // 탈퇴한 회원
                System.out.println("탈퇴한 회원입니다.");  // 로그
                req.setAttribute("message", "탈퇴한 회원입니다.");
                req.getRequestDispatcher("/WEB-INF/view/member/login.jsp").forward(req, resp);
                return;
            }

            // 로그인 성공 처리
            processLogin(req, resp, memberResult);
        } else {
            // 로그인 실패: 아이디 또는 비밀번호 불일치
            // 추가로 탈퇴한 회원 여부 확인 (이미 위에서 확인했으므로 생략 가능)
            // 하지만 만약 회원이 존재하지 않지만 탈퇴한 회원일 수 있다면 아래 로직 유지
            boolean isWithdrawn = memberService.isWithdrawnMember(id);
            if (isWithdrawn) {
                System.out.println("탈퇴한 회원입니다.");  // 로그 추가
                req.setAttribute("message", "탈퇴한 회원입니다.");
                req.getRequestDispatcher("/WEB-INF/view/member/login.jsp").forward(req, resp);
                return;
            }

            System.out.println("일반 회원 로그인 실패: 아이디 또는 비밀번호가 일치하지 않음");

            // 관리자 로그인 처리
            AdminVo admin = new AdminVo();
            admin.setAdmin_id(id);
            admin.setAdmin_pw(pw);

            AdminVo adminResult = adminService.adminLogin(admin);
            System.out.println("login result : " + adminResult);

            if (adminResult != null) {
                System.out.println("관리자 로그인 성공: " + adminResult);
                processAdminLogin(req, resp, adminResult);
            } else {
                System.out.println("관리자 로그인 실패: 아이디 또는 비밀번호가 일치하지 않음");
                req.setAttribute("message", "ID와 비밀번호를 다시 확인해 주세요.");
                req.getRequestDispatcher("/WEB-INF/view/member/login.jsp").forward(req, resp);
            }
        }
    }

    // 회원 로그인 성공 처리 메서드
    private void processLogin(HttpServletRequest req, HttpServletResponse resp, MemberVo memberResult) throws IOException {
        System.out.println("로그인 성공: " + memberResult);
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        session = req.getSession(true);

        // 사용자 정보 세션에 저장
        session.setAttribute("loginUser", memberResult);  // 전체 사용자 정보 저장
        session.setAttribute("mem_id", memberResult.getMem_id());  // 사용자 ID 저장
        session.setAttribute("userNickname", memberResult.getMem_nick());  // 사용자 닉네임 저장
        session.setAttribute("mem_no", memberResult.getMem_no());  // 사용자 번호 저장

        // 메인 페이지로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/main/main.do");
    }

    // 관리자 로그인 성공 처리 메서드
    private void processAdminLogin(HttpServletRequest req, HttpServletResponse resp, AdminVo adminResult) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        session = req.getSession(true);

        // 관리자 정보 세션에 저장
        session.setAttribute("loginAdmin", adminResult);
        session.setAttribute("admin_id", adminResult.getAdmin_id());
        session.setAttribute("admin_nick", adminResult.getAdmin_nick());

        // 메인 페이지로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/main/main.do");
    }
}


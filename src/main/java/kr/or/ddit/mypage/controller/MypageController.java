package kr.or.ddit.mypage.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.service.MypageServiceImpl;

@WebServlet("/mypage")
public class MypageController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private MypageServiceImpl userService = MypageServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // mem_id 파라미터를 URL에서 가져옴
        String memIdParam = req.getParameter("mem_id");  

        String view = "/WEB-INF/view/mypage/mypage.jsp"; // 기본 페이지

        HttpSession session = req.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
        AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");

     // 로그인 여부 확인
        if (loginUser == null && loginAdmin == null) {  // 일반 사용자와 관리자 모두 로그인 여부 확인
            resp.sendRedirect(req.getContextPath() + "/member/login.do");
            return;
        }

     // 로그인한 사용자 또는 관리자의 정보를 사용하여 처리
        MemberVo member = null;
        if (memIdParam != null && !memIdParam.isEmpty()) {
            // 파라미터로 전달된 mem_id가 있을 경우 해당 회원 정보 조회
            member = userService.getMemberInfo(memIdParam);

            // member가 null인 경우 처리
            if (member == null) {
                req.setAttribute("errorMessage", "해당 회원을 찾을 수 없습니다.");
                req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
                return;
            }
        } else {
            // mem_id 파라미터가 없을 경우, 로그인한 사용자 정보를 사용
            // 로그인한 사용자는 일반 사용자(loginUser)일 수도 있고, 관리자(loginAdmin)일 수도 있음
            if (loginUser != null) {
                member = loginUser;
            } else if (loginAdmin != null) {
                // 관리자는 다른 사용자의 정보를 보게 되므로, 관리자의 프로필로 마이페이지를 설정하지 않음
                member = new MemberVo();
                member.setMem_id(loginAdmin.getAdmin_id());  // 관리자의 아이디를 설정 (예시)
                member.setMem_nick(loginAdmin.getAdmin_nick());  // 관리자의 닉네임 설정 (예시)
            }
        }

        // 이후 처리
        if (action == null || action.equals("mypage")) {
            // 프로필 페이지 - 내가 작성한 게시글 조회
            List<BoardVo> myPosts = userService.getMyPosts(member.getMem_no());
            req.setAttribute("myPosts", myPosts);
            req.setAttribute("member", member);  // 조회한 회원 정보 설정
            view = "/WEB-INF/view/mypage/mypage.jsp";
        }

        if (action == null || action.equals("mypage")) {
            // 프로필 페이지 - 내가 작성한 게시글 조회
            List<BoardVo> myPosts = userService.getMyPosts(member.getMem_no());
            req.setAttribute("myPosts", myPosts);
            req.setAttribute("member", member);  // 조회한 회원 정보 설정
            view = "/WEB-INF/view/mypage/mypage.jsp";
        } else if (action.equals("order")) {
            // 나의 쇼핑 페이지
            req.setAttribute("member", member); // 다른 사용자의 경우에도 member 정보 설정
            view = "/WEB-INF/view/mypage/order.jsp"; // '나의 쇼핑' 페이지
        } else if (action.equals("meminfo")) {
            // 설정 페이지
            req.setAttribute("member", member); // 다른 사용자의 경우에도 member 정보 설정
            view = "/WEB-INF/view/mypage/meminfo.jsp"; // 설정 페이지
        } else if (action.equals("password")) {
            // 비밀번호 변경 페이지
            view = "/WEB-INF/view/mypage/password.jsp";
        } else if (action.equals("withdraw")) {
            // 회원 탈퇴 페이지
            view = "/WEB-INF/view/mypage/withdraw.jsp";
        } else {
            // 알 수 없는 action일 경우 기본 페이지로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/mypage?action=mypage");
            return;
        }

        req.setAttribute("member", member);  // 조회한 회원 정보를 요청에 설정
        req.getRequestDispatcher(view).forward(req, resp);
        System.out.println("Action: " + action + ", View: " + view);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("changePassword".equals(action)) {
            // 비밀번호 변경 로직
            String userId = ((MemberVo) req.getSession().getAttribute("loginUser")).getMem_id();
            String currentPassword = req.getParameter("currentPassword");
            String newPassword = req.getParameter("newPassword");

            MemberVo member = new MemberVo();
            member.setMem_id(userId);
            member.setMem_pw(currentPassword);

            boolean passwordValid = userService.checkPassword(member) > 0;

            if (passwordValid) {
                member.setMem_pw(newPassword);
                int result = userService.updatePassword(member);

                if (result > 0) {
                    req.setAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
                    resp.sendRedirect(req.getContextPath() + "/mypage?action=meminfo");
                    return;  // 리다이렉트 후 추가 로직을 방지하기 위해 리턴
                } else {
                    req.setAttribute("message", "비밀번호 변경에 실패하였습니다.");
                    req.getRequestDispatcher("/WEB-INF/view/mypage/password.jsp").forward(req, resp);
                    return;
                }
            } else {
                req.setAttribute("message", "현재 비밀번호가 일치하지 않습니다.");
                req.getRequestDispatcher("/WEB-INF/view/mypage/password.jsp").forward(req, resp);
                return;
            }
        }

        if ("updateInfo".equals(action)) {
            // 회원 정보 업데이트 로직
            HttpSession session = req.getSession();
            MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");

            String memName = req.getParameter("mem_name");
            String memNick = req.getParameter("mem_nick");
            String email = req.getParameter("email");

            loginUser.setMem_name(memName);
            loginUser.setMem_nick(memNick);
            loginUser.setEmail(email);

            int result = userService.updateMemberInfo(loginUser);

            if (result > 0) {
                req.setAttribute("message", "회원 정보가 성공적으로 업데이트되었습니다.");
                resp.sendRedirect(req.getContextPath() + "/mypage?action=meminfo");
                return;  // 리다이렉트 후 추가 로직을 방지하기 위해 리턴
            } else {
                req.setAttribute("message", "회원 정보 업데이트에 실패하였습니다.");
                req.getRequestDispatcher("/WEB-INF/view/mypage/meminfo.jsp").forward(req, resp);
                return;
            }
        }

        // 다른 POST 요청의 경우
        resp.sendRedirect(req.getContextPath() + "/mypage?action=mypage");
    }
}

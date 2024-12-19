package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.board.service.AnnServiceImpl;
import kr.or.ddit.board.service.IAnnService;
import kr.or.ddit.board.vo.BoardVo;

@WebServlet("/notice/insert.do")
public class NoticeInsertController extends HttpServlet {

    private IAnnService iAnnService = AnnServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 관리자 로그인 여부 확인
        HttpSession session = req.getSession();
        AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");
        if (loginAdmin == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login.do");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String title = req.getParameter("title");
        String content = req.getParameter("content");

        if (title == null || content == null || title.isEmpty() || content.isEmpty()) {
            req.setAttribute("errorMessage", "제목과 내용을 모두 입력해야 합니다.");
            req.getRequestDispatcher("/WEB-INF/view/board/noticeForm.jsp").forward(req, resp);
            return;
        }

        BoardVo board = new BoardVo();
        board.setTitle(title);
        board.setContent(content);
        board.setAdmin_no(loginAdmin.getAdmin_no());
        board.setBoardcode_no(1); // 공지사항의 boardcode_no 설정

        int result = iAnnService.insertNotice(board);

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?boardcode=1");
        } else {
            req.setAttribute("errorMessage", "공지사항 등록에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/board/noticeForm.jsp").forward(req, resp);
        }
    }
}

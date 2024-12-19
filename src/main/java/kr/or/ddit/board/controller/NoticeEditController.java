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

@WebServlet("/notice/edit.do")
public class NoticeEditController extends HttpServlet {

    IAnnService iAnnService = AnnServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 관리자 로그인 여부 확인
        HttpSession session = req.getSession();
        AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");
        if (loginAdmin == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login.do");
            return;
        }

        String boardNoStr = req.getParameter("board_no");
        if (boardNoStr == null || boardNoStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?boardcode=1");
            return;
        }

        int board_no = Integer.parseInt(boardNoStr);

        // 공지사항 상세 조회
        BoardVo notice = iAnnService.aDetail(board_no);

        if (notice == null) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?boardcode=1");
            return;
        }

        req.setAttribute("notice", notice);

        // 수정 폼으로 이동
        req.getRequestDispatcher("/WEB-INF/view/board/noticeEdit.jsp").forward(req, resp);
    }
}

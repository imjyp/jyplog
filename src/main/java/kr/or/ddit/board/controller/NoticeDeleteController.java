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

@WebServlet("/notice/delete.do")
public class NoticeDeleteController extends HttpServlet {

    IAnnService iAnnService = AnnServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 관리자 로그인 여부 확인
        HttpSession session = req.getSession();
        AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");
        if (loginAdmin == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.do");
            return;
        }

        String boardNoStr = req.getParameter("board_no");
        if (boardNoStr == null || boardNoStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?boardcode=1");
            return;
        }

        int board_no = Integer.parseInt(boardNoStr);

        int result = iAnnService.deleteNotice(board_no);

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?boardcode=1");
        } else {
            req.setAttribute("errorMessage", "공지사항 삭제에 실패했습니다.");
            req.getRequestDispatcher("/member/customer.do?boardcode=1").forward(req, resp);
        }
    }
}

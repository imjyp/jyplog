package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/postdelete")
public class BoardDeleteController extends HttpServlet {

	BoardService boardservice = BoardServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String boardNoStr = req.getParameter("board_no");

		if (boardNoStr == null || boardNoStr.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/boardList");
			return;
		}

		int boardNo = Integer.parseInt(boardNoStr);

		BoardVo board = boardservice.boardDetail(boardNo);

		if (board == null) {
			req.setAttribute("errorMessage", "해당 게시글을 찾을 수 없습니다.");
			req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
			return;
		}

		req.setAttribute("board", board);

		req.getRequestDispatcher("/WEB-INF/view/board/postdelete.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");

		if (loginUser == null) {
			System.out.println("세션에 로그인 정보가 없습니다.");
			resp.sendRedirect(req.getContextPath() + "/member/login.do");
			return;
		}

		req.setCharacterEncoding("UTF-8");

		String boardNoStr = req.getParameter("board_no");
		if (boardNoStr == null || boardNoStr.isEmpty()) {
			req.setAttribute("errorMessage", "게시글 번호가 유효하지 않습니다.");
			req.getRequestDispatcher("/WEB-INF/view/board/postdelete.jsp").forward(req, resp);
			return;
		}

		int board_no = Integer.parseInt(boardNoStr);

		// DEL_YN='Y'로 게시글 삭제 처리
		int result = boardservice.deletePost(board_no);

		if (result > 0) {
			System.out.println("게시글 삭제 성공");
			resp.sendRedirect(req.getContextPath() + "/mypage?action=mypage");
		} else {
			req.setAttribute("errorMessage", "게시글 삭제에 실패했습니다.");
			req.getRequestDispatcher("/WEB-INF/view/board/postdelete.jsp").forward(req, resp);
		}

//	        if (result > 0) {
//	            // 삭제 성공 시 deleteSuccess 플래그 설정
//	            req.setAttribute("deleteSuccess", true);
//	        } else {
//	            // 삭제 실패 시 deleteSuccess 플래그 설정
//	            req.setAttribute("deleteSuccess", false);
//	        }
//	        req.getRequestDispatcher("/WEB-INF/view/board/alert.jsp").forward(req, resp);
//	    }
	}
}

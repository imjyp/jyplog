package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.AnnServiceImpl;
import kr.or.ddit.board.service.IAnnService;
import kr.or.ddit.board.vo.BoardVo;

@WebServlet("/board/detail.do")
public class AnnDetailController extends HttpServlet {

	IAnnService iAnnService = AnnServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int board_no = Integer.parseInt(req.getParameter("board_no"));

		BoardVo detailBoard = iAnnService.aDetail(board_no);
		System.out.println("boardVo : " + detailBoard);

		req.setAttribute("detailBoard", detailBoard);

		req.getRequestDispatcher("/WEB-INF/view/board/annDetail.jsp").forward(req, resp);
	}
}

package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.vo.BoardVo;

/*
 *  카테고리 리스트 -최윤호가 적음-
 */

@WebServlet("/gg.do")
public class BoardController extends HttpServlet{
	BoardService boardservice = BoardServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		List<BoardVo> cateList = boardservice.cateList();
		System.out.println(cateList);
		
		req.setAttribute("cateList", cateList);
		req.getRequestDispatcher("/Includes/main.jsp").forward(req, resp);

	}

}

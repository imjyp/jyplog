package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.IQABoardService;
import kr.or.ddit.board.service.QABoardServiceImpl;
import kr.or.ddit.board.vo.QABoardVo;

@WebServlet("/board/question.do")
public class QABoardController extends HttpServlet {
	
	IQABoardService iQABoardService = QABoardServiceImpl.getInstance(); 
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String boardcodeStr = req.getParameter("inquiry");
		int inquiry = 1;
		if(boardcodeStr != null) {
			try {
				inquiry = Integer.parseInt(boardcodeStr);
			} catch (NumberFormatException e) {
			}
		}
		
		List<QABoardVo> boardList = iQABoardService.boardList(inquiry);
		
		System.out.println(boardList);
		req.setAttribute("boardList", boardList);
		
		req.getRequestDispatcher("/WEB-INF/view/board/question.jsp").forward(req, resp);
	}
}

package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.AnnServiceImpl;
import kr.or.ddit.board.service.IAnnService;
import kr.or.ddit.board.vo.BoardVo;

@WebServlet("/main/feed.do")
public class FeedController extends HttpServlet{
	
	IAnnService iAnnService = AnnServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<BoardVo> cateList = iAnnService.aCateList();
		System.out.println(cateList);
		
		req.setAttribute("aCateList", cateList);
		
		String fCode_noStr = req.getParameter("boardcode");		// boardcode_no를 AnnController 파라미터랑 다르게 해야하는지?
		int boardcode = 3;
		
		
//		if(fCode_noStr!=null) {
//			int code_no = Integer.parseInt(fCode_noStr);
//			List<BoardVo> fList = iAnnService.aList(code_no);
//			System.out.println(fList);
//			
//			req.setAttribute("fList", fList);
			
			// JSP로 포워딩
			req.getRequestDispatcher("/WEB-INF/view/board/communityBoard.jsp").forward(req, resp);
//		}else {
			// 메인페이지 이동
//	}
		
	}
	
}

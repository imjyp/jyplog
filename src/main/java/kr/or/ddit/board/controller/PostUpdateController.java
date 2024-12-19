package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/postupdate.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 3, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 50)
public class PostUpdateController extends HttpServlet {

	BoardService boardservice = BoardServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// URL 파라미터로 넘어온 board_no를 받음
		String boardNoStr = req.getParameter("board_no");

		if (boardNoStr == null || boardNoStr.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/boardList");
			return;
		}

		// board_no를 int로 변환
		int boardNo = Integer.parseInt(boardNoStr);

		// 게시글 정보를 DB에서 가져옴
		BoardVo board = boardservice.boardDetail(boardNo);

		// 게시글 정보가 없을 경우 처리
		if (board == null) {
			req.setAttribute("errorMessage", "해당 게시글을 찾을 수 없습니다.");
			req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
			return;
		}

		// 게시글 정보를 JSP로 전달
		req.setAttribute("board", board);

		// 게시글 수정 JSP로 포워딩
		req.getRequestDispatcher("/WEB-INF/view/board/postupdate.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");

		// 세션 정보 로그로 확인
		if (loginUser == null) {
			System.out.println("세션에 로그인 정보가 없습니다.");
			resp.sendRedirect(req.getContextPath() + "/member/login.do");
			return;
		} else {
			System.out.println("세션에 로그인된 사용자: " + loginUser.getMem_id());
		}

		req.setCharacterEncoding("UTF-8");
		// 이후 게시글 수정 처리 로직

		String boardNoStr = req.getParameter("board_no");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		content = content.replaceAll("<p>", "").replaceAll("</p>", "");
		System.out.println("boardNo: " + boardNoStr + ", title: " + title + ", content: " + content);
		if (boardNoStr == null || title == null || content == null || title.isEmpty() || content.isEmpty()) {
			req.setAttribute("errorMessage", "제목과 내용을 모두 입력해야 합니다.");
			req.getRequestDispatcher("/WEB-INF/view/board/postupdate.jsp").forward(req, resp);
			return;
		}

		int board_no = Integer.parseInt(boardNoStr);

		BoardVo post = new BoardVo();
		post.setBoard_no(board_no);
		post.setTitle(title);
		post.setContent(content);
		int result = boardservice.updatePost(post);
		
		  if (result > 0) { req.setAttribute("updateSuccess", true);
		  System.out.println("게시글 수정 성공"); 
		  resp.sendRedirect(req.getContextPath() +"/boardDetail?board_no="+board_no);
		 
		  
		  } else { req.setAttribute("errorMessage", "공지사항 수정에 실패했습니다." );
		  req.getRequestDispatcher("/WEB-INF/view/board/postupdate.jsp").forward(req,
		  resp); } }
		 
		

	}


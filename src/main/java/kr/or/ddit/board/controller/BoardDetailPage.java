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

@WebServlet("/boardDetail")
public class BoardDetailPage extends HttpServlet {
    
    BoardService boardService = BoardServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 게시글 번호 가져오기
        int boardNo = Integer.parseInt(req.getParameter("board_no"));
        
		// 조회수 증가 로직 추가
        int updateCount = boardService.updateBoardClickCount(boardNo);
        if (updateCount > 0) {
            System.out.println("조회수 증가 성공: 상품 번호 = " + boardNo);
        } else {
            System.out.println("조회수 증가 실패: 상품 번호 = " + boardNo);
        }
		
        
        // 게시글 정보 가져오기
        BoardVo board = boardService.boardDetail(boardNo);
        
        
        // 이미지 경로 가져오기
        if (board != null) {
            List<String> images = boardService.boardImgpath(board.getBoard_no());
            board.setImages(images); // BoardVo에 이미지 경로 설정
        }
        
        // JSP에 board 객체 전달
        req.setAttribute("board", board);
        
        // 게시글 상세 JSP로 포워딩
//        req.getRequestDispatcher("/WEB-INF/view/board/boardDetail.jsp").forward(req, resp);
        req.getRequestDispatcher("/comment/comment.do").forward(req, resp);
    }
}
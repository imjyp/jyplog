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
@WebServlet("/boardList")
public class BoardListController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private BoardService boardService = BoardServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // boardcode_no 파라미터 가져오기
        int boardcode_no = Integer.parseInt(req.getParameter("boardcode_no"));

        // 정렬 기준 확인
        String sortOrder = req.getParameter("sortOrder");
        
        List<BoardVo> boardList;

        // 정렬 기준에 따라 게시글 목록 가져오기
        if ("count".equals(sortOrder)) {
            // 조회수 기준으로 정렬
            boardList = boardService.boardListSortedByCount(boardcode_no);
        } else {
            // 기본적으로 조회수 기준으로 정렬
            boardList = boardService.boardList(boardcode_no);
        }
        
        // 각 보드에 이미지 경로 설정
        for (BoardVo board : boardList) {
            List<String> images = boardService.boardImgpath(board.getBoard_no());
            board.setImages(images); // BoardVo에 이미지 경로 설정
        }
        
        // 요청 속성에 boardList 설정
        req.setAttribute("boardList", boardList);
        
        // JSP로 포워드
        req.getRequestDispatcher("/WEB-INF/view/board/boardList.jsp").forward(req, resp);
    }
}

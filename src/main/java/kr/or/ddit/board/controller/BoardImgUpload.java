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

@WebServlet("/boardimg.do")
public class BoardImgUpload extends HttpServlet{
    
    private static final long serialVersionUID = 1L;
    private BoardService boardService = BoardServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int board_no = Integer.parseInt(req.getParameter("board_no"));
        System.out.println("Received board_no: " + board_no);
        
        // 보드 정보 가져오기
        BoardVo board = boardService.boardDetail(board_no);
        // 이미지 경로 리스트 가져오기
        List<String> path = boardService.boardImgpath(board_no);
        
        // 요청 속성에 추가
        req.setAttribute("board", board);
        req.setAttribute("path", path);
        
        req.getRequestDispatcher("/WEB-INF/view/board/boardDetail.jsp").forward(req, resp);
        System.out.println("Image paths: " + path);
    }
}

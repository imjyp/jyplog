package kr.or.ddit.comment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.Websocket;
import kr.or.ddit.comment.service.CommentServiceImpl;
import kr.or.ddit.comment.service.ICommentService;
import kr.or.ddit.comment.vo.CommentVo;

@WebServlet("/comment/comment.do")
public class CommentController extends HttpServlet {

    ICommentService commentService = CommentServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String boardNoStr = req.getParameter("board_no");
        String content = req.getParameter("content");

        // 세션에서 사용자 정보 가져오기
        HttpSession session = req.getSession();
        Integer memNo = (Integer) session.getAttribute("mem_no");
        String memNick = (String) session.getAttribute("userNickname");

        if (content == null || content.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Content cannot be empty");
            return;
        }
        
        if (memNo == null || memNick == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        try {
            int boardNo = Integer.parseInt(boardNoStr);

            CommentVo comment = new CommentVo();
            comment.setBoard_no(boardNo);
            comment.setMem_no(memNo);
            comment.setContent(content);
            comment.setMem_nick(memNick);

            int result = commentService.insertComment(comment);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            if (result > 0) {
                // 댓글 등록이 성공하면 JSON 응답으로 새로운 댓글 데이터 전송
                out.print("{\"success\": true, \"comment\": {\"mem_nick\": \"" + memNick + "\", \"content\": \"" + comment.getContent() + "\"}}");
             // 웹소켓 알림 로직 추가
                String notificationMessage = memNick + "님의 새로운 댓글이 달렸습니다";
                Websocket.sendNotification(notificationMessage);
                
            } else {
                out.print("{\"success\": false}");
            }
            out.flush();
        } catch (NumberFormatException e) {
        	System.err.println("Invalid board number format: " + boardNoStr);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format for board_no");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String boardNoStr = req.getParameter("board_no");

        try {
            int boardNo = Integer.parseInt(boardNoStr);
            List<CommentVo> comments = commentService.getCommentsByBoardNo(boardNo);

            if (comments != null && !comments.isEmpty()) {
                req.setAttribute("comments", comments); // 댓글 목록이 있을 경우 해당 리스트를 설정합니다.
            } else {
                req.setAttribute("comments", List.of()); // 댓글 목록이 없을 경우 빈 리스트를 설정합니다.
            }

            req.getRequestDispatcher("/WEB-INF/view/board/boardDetail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format for board_no");
        }
    }
}

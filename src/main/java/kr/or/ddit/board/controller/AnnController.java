package kr.or.ddit.board.controller;


/*
 * 공지사항 메인 게시판 가져오기
 */

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.AnnServiceImpl;
import kr.or.ddit.board.service.IAnnService;
import kr.or.ddit.board.service.IQABoardService;
import kr.or.ddit.board.service.QABoardServiceImpl;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.board.vo.QABoardVo;

@WebServlet("/member/customer.do")
public class AnnController extends HttpServlet{
    
    IAnnService iAnnService = AnnServiceImpl.getInstance();
    IQABoardService iQABoardService = QABoardServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String boardcodeStr = req.getParameter("boardcode");
        String inquiry = req.getParameter("inquiry");
        
        if(inquiry != null && inquiry.equals("1")) {
        	 // **1:1 문의 처리 로직**
             //   1:1 문의 데이터 로드
        	 List<QABoardVo> boardList = iQABoardService.getAllQuestions();
             req.setAttribute("boardList", boardList);
             
             
             // 활성 탭 설정
             req.setAttribute("activeTab", "inquiry");
             
             // JSP로 포워딩
             req.getRequestDispatcher("/WEB-INF/view/board/customer.jsp").forward(req, resp);
             return; // 이후 코드 실행 방지
        }
        
        int boardcode = 1; // 기본 카테고리 번호를 1로 설정
        
        // **공지사항 및 FAQ 처리 로직**
        if (boardcodeStr != null && !boardcodeStr.isEmpty()) {
            try {
                boardcode = Integer.parseInt(boardcodeStr);
            } catch (NumberFormatException e) {
                // 숫자 변환 실패 시 로그 출력 및 기본값 사용
                System.out.println("Invalid boardcode format: " + boardcodeStr);
            }
        }
        
        // 카테고리 목록 로드
        List<BoardVo> aCateList = iAnnService.aCateList();
        req.setAttribute("aCateList", aCateList);
        System.out.println(aCateList);
        
        // 선택된 카테고리의 게시글 목록 로드
        List<BoardVo> aList = iAnnService.aList(boardcode);
        req.setAttribute("aList", aList);
        System.out.println(aList);
       
        if (!aList.isEmpty()) {
            req.setAttribute("Boardcode_name", aList.get(0).getBoardcode_name());
            req.setAttribute("Boardcode_no", aList.get(0).getBoardcode_no());
        } else {
            req.setAttribute("Boardcode_name", "No Category");
            req.setAttribute("Boardcode_no", boardcode); // 사용자가 입력한 boardcode 사용
        }
        
        req.setAttribute("activeTab", "boardcode");
        req.setAttribute("currentBoardcode", boardcode);
        
        // JSP로 포워딩
        req.getRequestDispatcher("/WEB-INF/view/board/customer.jsp").forward(req, resp);
    }
}


package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.IQABoardService;
import kr.or.ddit.board.service.QABoardServiceImpl;
import kr.or.ddit.board.vo.QABoardVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/member/inquirySubmit.do")
public class InquirySubmitController extends HttpServlet{
	
	IQABoardService iQABoardService = QABoardServiceImpl.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 여부 확인
		HttpSession session = req.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
		if (loginUser == null) {
			resp.sendRedirect(req.getContextPath() + "/member/login.do");
			return;
		}
		
		// 요청 파라미터 인코딩 설정
		req.setCharacterEncoding("UTF-8");
		
		// 폼 데이터 가져오기
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		// QABoardVo 객체 생성 및 데이터 설정
		QABoardVo question = new QABoardVo();
        question.setQuestion_title(title);
        question.setQuestion_content(content);
        question.setMem_no(loginUser.getMem_no());
        question.setQuestion_date(new Date()); // 현재 날짜로 설정
        
        // 서비스 호출하여 데이터 저장
        int result = iQABoardService.insertQuestion(question);

        if (result > 0) {
            // 성공 시 문의 목록 페이지로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
        } else {
            // 실패 시 에러 페이지 또는 메시지 표시
            req.setAttribute("errorMessage", "문의 등록에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/board/inquiryForm.jsp").forward(req, resp);
		
        }
		
	}
}























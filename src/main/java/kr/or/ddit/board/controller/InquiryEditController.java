package kr.or.ddit.board.controller;

import java.io.IOException;

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

@WebServlet("/member/inquiryEdit.do")
public class InquiryEditController extends HttpServlet{

	IQABoardService iQABoardService = QABoardServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 여부 확인
		HttpSession session = req.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
		if(loginUser == null) {
			resp.sendRedirect(req.getContextPath() + "/member/login.do");
			return;
		}
		
		String questionNoStr = req.getParameter("question_no");
		if(questionNoStr == null || questionNoStr.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
			return;
		}
		
		int questionNo = Integer.parseInt(questionNoStr);
		
		// 문의글 정보 가져오기
		QABoardVo question = iQABoardService.getQuestionById(questionNo);
		
		if(question == null || "Y".equals(question.getDel_yn())) {
			// 존재하지 않거나 삭제된 글일 경우
			resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
			return;
		}
		
		// 작성자 본인인지 확인
		if(loginUser.getMem_no() != question.getMem_no()) {
			// 본인이 아니면 접근 불가
			resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
			return;
		}
		
		// 문의글 정보를 리퀘스트에 설정하고 JSP로 포워딩
		req.setAttribute("question", question);
		req.getRequestDispatcher("/WEB-INF/view/board/inquiryEdit.jsp").forward(req, resp);
	}
}














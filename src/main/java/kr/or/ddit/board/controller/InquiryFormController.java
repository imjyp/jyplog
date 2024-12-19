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

@WebServlet("/member/inquiryForm.do")
public class InquiryFormController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 여부 확인
		HttpSession session = req.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
		if (loginUser == null) {
			resp.sendRedirect(req.getContextPath() + "/member/login.do");
			return;
		}
		// inquiryForm.jsp로 포워딩
		req.getRequestDispatcher("/WEB-INF/view/board/inquiryForm.jsp").forward(req, resp);
	}
}

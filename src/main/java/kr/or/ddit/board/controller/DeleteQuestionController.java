package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.board.service.IQABoardService;
import kr.or.ddit.board.service.QABoardServiceImpl;
import kr.or.ddit.board.vo.QABoardVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/member/deleteQuestion.do")
public class DeleteQuestionController extends HttpServlet{
	
	IQABoardService iQABoardService = QABoardServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 여부 확인
		HttpSession session = req.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
		AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");
		
		String questionNoStr = req.getParameter("questionNo");
		if(questionNoStr != null) {
			try {
				int questionNo = Integer.parseInt(questionNoStr);
				
				// 게시글 정보 가져오기
				QABoardVo question = iQABoardService.getQuestionById(questionNo);
				
				if (question == null || "Y".equals(question.getDel_yn())) {
                    // 게시글이 존재하지 않는 경우
                    resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1&error=notFound");
                    return;
                }
				
				// 권한 확인
				boolean isOwner = (loginUser != null && loginUser.getMem_no() == question.getMem_no());
                boolean isAdmin = (loginAdmin != null);
                
                if (isOwner || isAdmin) {
                    // 삭제 처리
                    int result = iQABoardService.deleteQuestion(questionNo);

                    if (result > 0) {
                        resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1&error=deleteFailed");
                    }
                } else {
                    // 권한이 없는 경우
                    resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1&error=accessDenied");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1&error=invalidId");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1&error=missingId");
        }
    }
}























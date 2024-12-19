package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.IAnswerBoardService;
import kr.or.ddit.board.service.AnswerBoardServiceImpl;
import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.board.vo.AnswerVo;

@WebServlet("/admin/answerSubmit.do")
public class AnswerSubmitController extends HttpServlet {

    IAnswerBoardService iAnswerBoardService = AnswerBoardServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 관리자 로그인 여부 확인
        HttpSession session = req.getSession();
        AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");
        if (loginAdmin == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login.do");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String questionNoStr = req.getParameter("question_no");
        String content = req.getParameter("content");

        if (questionNoStr == null || content == null) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
            return;
        }

        int questionNo = Integer.parseInt(questionNoStr);

        // 기존 답변이 있는지 확인
        AnswerVo existingAnswer = iAnswerBoardService.getAnswerByQuestionNo(questionNo);

        int result = 0;

        if (existingAnswer == null) {
            // 답변 등록
            AnswerVo answer = new AnswerVo();
            answer.setQuestion_no(questionNo);
            answer.setAdmin_no(loginAdmin.getAdmin_no());
            answer.setAnswer_content(content);
            answer.setDate_of_pre(new Date());

            result = iAnswerBoardService.insertAnswer(answer);
        } else {
            // 답변 수정
            existingAnswer.setAnswer_content(content);
            existingAnswer.setDate_of_pre(new Date());

            result = iAnswerBoardService.updateAnswer(existingAnswer);
        }

        if (result > 0) {
            // 성공 시 문의 목록 페이지로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
        } else {
            // 실패 시 에러 메시지와 함께 답변 페이지로 이동
            req.setAttribute("errorMessage", "답변 저장에 실패했습니다.");
            req.setAttribute("question_no", questionNo);
            req.getRequestDispatcher("/WEB-INF/view/admin/answerForm.do").forward(req, resp);
        }
    }
}

package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.IAnswerBoardService;
import kr.or.ddit.board.service.IQABoardService;
import kr.or.ddit.board.service.AnswerBoardServiceImpl;
import kr.or.ddit.board.service.QABoardServiceImpl;
import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.board.vo.AnswerVo;
import kr.or.ddit.board.vo.QABoardVo;

@WebServlet("/admin/answerForm.do")
public class AnswerFormController extends HttpServlet {

     IQABoardService qaBoardService = QABoardServiceImpl.getInstance();
     IAnswerBoardService iAnswerBoardService = AnswerBoardServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 관리자 로그인 여부 확인
        HttpSession session = req.getSession();
        AdminVo loginAdmin = (AdminVo) session.getAttribute("loginAdmin");
        if (loginAdmin == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login.do");
            return;
        }

        String questionNoStr = req.getParameter("question_no");
        if (questionNoStr == null || questionNoStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
            return;
        }

        int questionNo = Integer.parseInt(questionNoStr);

        // 문의글 정보 가져오기
        QABoardVo question = qaBoardService.getQuestionById(questionNo);

        if (question == null || "Y".equals(question.getDel_yn())) {
            // 존재하지 않거나 삭제된 글일 경우
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
            return;
        }

        // 답변 정보 가져오기
        AnswerVo answer = iAnswerBoardService.getAnswerByQuestionNo(questionNo);

        // 문의글과 답변 정보를 리퀘스트에 설정하고 JSP로 포워딩
        req.setAttribute("question", question);
        req.setAttribute("answer", answer);
        req.getRequestDispatcher("/WEB-INF/view/admin/answerForm.jsp").forward(req, resp);
    }
}

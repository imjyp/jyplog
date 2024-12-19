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
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.board.vo.QABoardVo;

@WebServlet("/member/inquiryUpdate.do")
public class InquiryUpdateController extends HttpServlet {

    private IQABoardService iqaBoardService = QABoardServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 로그인 여부 확인
        HttpSession session = req.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login.do");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String questionNoStr = req.getParameter("question_no");
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        if (questionNoStr == null || title == null || content == null) {
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
            return;
        }

        int questionNo = Integer.parseInt(questionNoStr);

        // 문의글 정보 가져오기
        QABoardVo question = iqaBoardService.getQuestionById(questionNo);

        if (question == null || "Y".equals(question.getDel_yn())) {
            // 존재하지 않거나 삭제된 글일 경우
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
            return;
        }

        // 작성자 본인인지 확인
        if (loginUser.getMem_no() != question.getMem_no()) {
            // 본인이 아니면 접근 불가
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
            return;
        }

        // 수정 내용 설정
        question.setQuestion_title(title);
        question.setQuestion_content(content);

        // 서비스 호출하여 업데이트
        int result = iqaBoardService.updateQuestion(question);

        if (result > 0) {
            // 성공 시 문의 목록 페이지로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/member/customer.do?inquiry=1");
        } else {
            // 실패 시 에러 메시지와 함께 수정 페이지로 이동
            req.setAttribute("errorMessage", "문의 수정에 실패했습니다.");
            req.setAttribute("question", question);
            req.getRequestDispatcher("/WEB-INF/view/board/inquiryEdit.jsp").forward(req, resp);
        }
    }
}


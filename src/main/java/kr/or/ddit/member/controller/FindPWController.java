package kr.or.ddit.member.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/member/findPw.do")
public class FindPWController extends HttpServlet{
	
	IMemberService memberService = MemberServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	req.getRequestDispatcher("/WEB-INF/view/member/findPW.jsp").forward(req, resp);
	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String name = req.getParameter("mem_name");
		String id = req.getParameter("mem_id");
		String phone1 = req.getParameter("phone1");
		String phone2 = req.getParameter("phone2");
		String phone3 = req.getParameter("phone3");
	
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		
		System.out.println("name :" + name);
		System.out.println("id :" + id);
		System.out.println("phone :" + phone);
		
		// 파라미터 검증
        if (name == null || id == null || phone == null) {
            req.setAttribute("message", "입력된 정보가 올바르지 않습니다. 모든 필드를 입력해 주세요.");
            req.getRequestDispatcher("/WEB-INF/view/member/findPW.jsp").forward(req, resp);
            return;
        }
		MemberVo member = new MemberVo();
		member.setMem_name(name);
		member.setMem_id(id);
		member.setPhone(phone);
		
		System.out.println(member);
		
		// 데이터 검증 (DB 대조)
        boolean isMemberValid = memberService.chkMemberInfo(member);
        System.out.println("회원 정보 검증 결과: " + isMemberValid); // 디버깅 로그

        if (isMemberValid) {
        	// 검증 성공 시 세션에 mem_id 저장
            HttpSession session = req.getSession();
            session.setAttribute("mem_id", id); // 세션에 mem_id 저장
            System.out.println("FindPWController에서 세션에 저장된 mem_id: " + session.getAttribute("mem_id"));
            
            // 검증 성공 시 이메일 인증 페이지로 이동
            req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
        } else {
            // 검증 실패 시 메시지 출력 후 현재 페이지에 머무름
            req.setAttribute("message", "회원 정보를 찾을 수 없습니다.");
            req.getRequestDispatcher("/WEB-INF/view/member/findPW.jsp").forward(req, resp);
        }
    }
}
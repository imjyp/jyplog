package kr.or.ddit.member.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/member/join.do")
public class JoinController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IMemberService memberService = MemberServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/member/join.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 폼에서 입력된 값 수신
        String name = req.getParameter("name");
        String id = req.getParameter("id");
        String pw = req.getParameter("pw");
        
        String email = req.getParameter("email");
        String emailDomain = req.getParameter("emailDomain");
        String customDomain = req.getParameter("customDomain");
//        String fullEmail = req.getParameter("fullEmail"); // 조합된 전체 이메일을 받아옴

        String fullEmail = null;
        
        if (emailDomain != null && !emailDomain.isEmpty()) {
            if (emailDomain.equals("custom") && customDomain != null && !customDomain.isEmpty()) {
                fullEmail = email + "@" + customDomain;
            } else {
                fullEmail = email + "@" + emailDomain;
            }
        }
        
        String phone1 = req.getParameter("phone1");
        String phone2 = req.getParameter("phone2");
        String phone3 = req.getParameter("phone3");
        String phone = phone1 + "-" + phone2 + "-" + phone3; // 전화번호 조합
        String nick = req.getParameter("nick");

        // 디버깅용 출력 (입력된 정보 확인)
        System.out.println("Name: " + name);
        System.out.println("ID: " + id);
        System.out.println("PW: " + pw);
        System.out.println("Full Email: " + fullEmail);
        System.out.println("Phone: " + phone);
        System.out.println("Nick: " + nick);

        // 회원 번호 생성
        int memNo = memberService.getMaxMemNo();
        
        // MemberVo 객체에 회원 정보 설정
        MemberVo member = new MemberVo();
        member.setMem_no(memNo);
        member.setMem_name(name);
        member.setMem_id(id);
        member.setMem_pw(pw);
        member.setEmail(fullEmail); // 전체 이메일 설정
        member.setPhone(phone);
        member.setMem_nick(nick);

        System.out.println(member); // 멤버 객체 확인 (디버깅용 출력)

        // 회원 가입 처리
        memberService.insertMember(member);

        // 메인 페이지로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/main/main.do");
    }
}

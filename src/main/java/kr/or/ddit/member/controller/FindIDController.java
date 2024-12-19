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

@WebServlet("/member/findId.do")
public class FindIDController extends HttpServlet{
	
	IMemberService memberService = MemberServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	req.getRequestDispatcher("/WEB-INF/view/member/findID.jsp").forward(req, resp);
	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String name = req.getParameter("mem_name");
		String phone1 = req.getParameter("phone1");
		String phone2 = req.getParameter("phone2");
		String phone3 = req.getParameter("phone3");
	
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		
		System.out.println("name :" + name);
		System.out.println("phone :" + phone);
		
		MemberVo member = new MemberVo();
		member.setMem_name(name);
		member.setPhone(phone);
		
		System.out.println(member);
		
		String findId = memberService.findId(member);
		
		if(findId != null) {
			req.setAttribute("findId", "아이디 : " + findId);
			
		}else {
			req.setAttribute("message", "입력하신 정보가 일치하지 않습니다.");
		}
		
		req.getRequestDispatcher("/WEB-INF/view/member/findID.jsp").forward(req, resp);
	}
}

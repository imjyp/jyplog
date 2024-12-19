package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;
import mail.Mail;

@WebServlet("/member/verifyEmail.do")
public class VerifyEmailController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	IMemberDao memberDao = MemberDaoImpl.getInstance();
	IMemberService memberService = MemberServiceImpl.getInstance();

	private Mail mail = new Mail();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 인증 화면 이동
		req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action"); // 요청 액션 파라미터

		req.setCharacterEncoding("UTF-8"); // 요청 인코딩 설정
		resp.setCharacterEncoding("UTF-8"); // 응답 인코딩 설정

		// 세션이 존재하는지 확인 (세션이 없으면 false)
		HttpSession session = req.getSession(false);
		if (session == null) {
			System.out.println("세션이 만료되었거나 존재하지 않습니다. 세션을 다시 생성해야 합니다.");
			req.setAttribute("message", "세션이 만료되었습니다. 이메일 인증을 다시 진행해 주세요.");
			req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
			return;
		} else {
			System.out.println("세션 ID: " + session.getId());
		}
				
		if ("sendAuthCode".equals(action)) {
			sendAuthCode(req, resp);
		} else if ("verifyAuthCode".equals(action)) {
			verifyAuthCode(req, resp);
		} else if ("issueTempPassword".equals(action)) {
			issueTempPassword(req, resp);
		} else {
			req.setAttribute("message", "잘못된 요청입니다.");
			req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
		}
	}

	// 이메일 인증코드 발송
	private void sendAuthCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");

		if (email == null || email.isEmpty() || !isValidEmail(email)) {
			req.setAttribute("message", "올바른 이메일을 입력해 주세요.");
			req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
			return;
		}

		// 인증번호 생성
		String authCode = generateAuthCode();
		boolean emailSent = mail.sendEmail(email, "이메일 인증코드", "인증코드: " + authCode);

		if (emailSent) {
			HttpSession session = req.getSession();
			session.setAttribute("authCode", authCode); // 인증번호 세션에 저장
			session.setAttribute("email", email); // 이메일 세션에 저장
			System.out.println("세션에 저장된 인증번호: " + authCode);
			req.setAttribute("message", "인증코드가 이메일로 발송되었습니다.");
		} else {
			req.setAttribute("message", "인증코드 발송에 실패했습니다. 다시 시도해 주세요.");
		}
		req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
	}

	// 인증코드 확인
	private void verifyAuthCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String authCode = req.getParameter("authCode").trim(); // 공백 제거
	    String sessionAuthCode = ((String) req.getSession().getAttribute("authCode")).trim();

	    System.out.println("입력한 인증번호: [" + authCode + "]");
	    System.out.println("세션에 저장된 인증번호: [" + sessionAuthCode + "]");

	    if (authCode != null && authCode.equals(sessionAuthCode)) {
	        req.setAttribute("message", "인증코드가 확인되었습니다.");
	        req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
	    } else {
	        req.setAttribute("message", "인증코드가 일치하지 않습니다. 다시 확인해 주세요.");
	        req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
	    }
	}

	// 임시 비밀번호 발급
	private void issueTempPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		HttpSession session = req.getSession();
	    
	    String id = (String) session.getAttribute("mem_id"); // 세션에서 mem_id 사용
	    String email = (String) session.getAttribute("email");
	    
	    System.out.println("VerifyEmailController에서 세션에 저장된 mem_id: " + id);
	    System.out.println("세션에서 받아온 email: " + email);
	    
	    if (email == null || id == null) {
	        req.setAttribute("message", "이메일 인증을 다시 진행해 주세요.");
	        req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
	        return;
		}

		// 임시 비밀번호 생성
		
		String tempPw = mail.generateTempPw();
		boolean emailSent = mail.sendEmail(email, "임시 비밀번호 발급", "임시 비밀번호: " + tempPw);

		
		if (emailSent) {
			// 임시 비밀번호를 데이터베이스에 업데이트
			MemberVo member = new MemberVo();
			member.setMem_id(id);
			member.setMem_pw(tempPw); // 임시 비밀번호를 설정
			try {
			    int updateResult = memberDao.updateTempPw(member);
			    if (updateResult > 0) {
			        req.setAttribute("message", "임시 비밀번호가 이메일로 발송되었습니다.");
			        req.getRequestDispatcher("/WEB-INF/view/member/login.jsp").forward(req, resp);
			    } else {
			        req.setAttribute("message", "임시 비밀번호 업데이트에 실패했습니다.");
			        req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
			    }
			} catch (Exception e) {
			    e.printStackTrace();
			    req.setAttribute("message", "임시 비밀번호 업데이트 중 오류가 발생했습니다.");
			    req.getRequestDispatcher("/WEB-INF/view/member/verify.jsp").forward(req, resp);
    }
			}
		}

	// 인증코드 생성 메서드
	private String generateAuthCode() {
		Random random = new Random();
		return String.format("%06d", random.nextInt(1000000));
	}

	// 이메일 유효성 검증
	private boolean isValidEmail(String email) {
		return email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
	}
}

package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.service.MypageServiceImpl;

@WebServlet("/admin/memList.do")
public class AdminController extends HttpServlet{
	
	IAdminService adminService = AdminServiceImpl.getInstance();
	IMemberService memberService = MemberServiceImpl.getInstance();
	MypageServiceImpl mypageService = MypageServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 회원 리스트 가져오기
        List<MemberVo> memberList = memberService.getMemberList(); // 회원 리스트 가져오기
        
        // 가져온 회원 리스트를 요청 속성에 설정
        req.setAttribute("memberList", memberList);
		
		req.getRequestDispatcher("/WEB-INF/view/admin/memList.jsp").forward(req, resp);
		
		
	}
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 선택된 회원 ID 목록 가져오기
        System.out.println("doPost 시작");    // 로그
        String selectedMembersParam = req.getParameter("selectedMembers"); // 쉼표로 구분된 문자열
        
        // 선택된 회원 ID가 쉼표로 구분된 문자열로 전달된 경우 처리
        if (selectedMembersParam != null && !selectedMembersParam.isEmpty()) {
            String[] selectedMemberIds = selectedMembersParam.split(","); // 쉼표로 구분된 문자열을 배열로 변환
            System.out.println("선택된 회원 수: " + selectedMemberIds.length); // 로그
            
            // 각 회원 ID에 대해 탈퇴 처리
            for (String memberId : selectedMemberIds) {
                String id = memberId.trim();  // 공백 제거
                System.out.println("처리 중인 회원 ID: " + id);

                // 각 회원의 정보 가져오기
                MemberVo member = mypageService.getMemberInfo(id);
            
                if (member != null) {
                    // 회원 정보가 있을 경우 DEL_YN 값을 2로 업데이트 (회원 탈퇴)
                    member.setDel_yn(2);
                    mypageService.updateMemberDelYn(member); // DEL_YN 업데이트
                    System.out.println("탈퇴 처리 완료: " + id);
                } else {
                    // 회원 정보를 찾지 못한 경우 로그 출력
                    System.out.println("해당 회원을 찾을 수 없습니다: " + id);
                }
            }
        } else {
            System.out.println("선택된 회원이 없습니다.");
        }
        
        // 처리 후 다시 회원 리스트 페이지로 리다이렉트
	    System.out.println("doPost 종료 후 리다이렉트");
        resp.sendRedirect(req.getContextPath() + "/admin/memList.do");
    }
}

	
	
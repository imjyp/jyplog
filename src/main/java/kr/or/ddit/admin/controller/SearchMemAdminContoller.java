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
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.search.service.ISearchService;
import kr.or.ddit.search.service.SearchServiceImpl;

@WebServlet("/search/searchMemAdmin.do")
public class SearchMemAdminContoller  extends HttpServlet{

   private static final long serialVersionUID = 1L;
   IAdminService adminService = AdminServiceImpl.getInstance();
   
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

      String query = req.getParameter("query");  // 검색어 가져오기

        List<MemberVo> memberResults = null;

        // 검색어가 존재하면 회원 검색 수행
        if (query != null && !query.trim().isEmpty()) {
            memberResults = adminService.searchMemAdmin(query);
        }

        // HTML 테이블 형태로 응답을 준비
        StringBuilder htmlResponse = new StringBuilder();
        if (memberResults != null) {
            for (MemberVo member : memberResults) {
                htmlResponse.append("<tr>")
                            .append("<td><input type='checkbox' class='memberCheckbox' /></td>")
                            .append("<td>");
                
                // 탈퇴 여부에 따라 (탈퇴) 표시
                if (member.getDel_yn() == 2) {
                    htmlResponse.append(member.getMem_id()).append(" (탈퇴)");
                } else {
                    htmlResponse.append(member.getMem_id());
                }
                
                htmlResponse.append("</td>")
                            .append("<td>").append(member.getMem_pw()).append("</td>")
                            .append("<td>").append(member.getMem_name()).append("</td>")
                            .append("<td>").append(member.getEmail()).append("</td>")
                            .append("<td>").append(member.getPhone()).append("</td>")
                            .append("<td>").append(member.getMem_nick()).append("</td>")
                            .append("</tr>");
            }
        }

        // 응답을 HTML로 보내기
        resp.setContentType("text/html; charset=UTF-8");
        resp.getWriter().write(htmlResponse.toString());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);  // POST 요청도 GET 방식으로 처리
    }
}

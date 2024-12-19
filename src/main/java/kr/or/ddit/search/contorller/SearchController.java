package kr.or.ddit.search.contorller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.search.service.ISearchService;
import kr.or.ddit.search.service.SearchServiceImpl;

@WebServlet("/search/search.do")
public class SearchController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ISearchService searchService = SearchServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// 파라미터 받아오기
        
        String query = req.getParameter("query");
        String category = req.getParameter("category");
        String sort = req.getParameter("sort");
        int boardcode = 4; // 집들이 게시판 고정
        

        // 로그 출력
        System.out.println("Query: " + query);
        System.out.println("Category: " + category);
        System.out.println("Sort: " + sort);

        if (category == null || category.trim().isEmpty()) {
            category = "all"; // 기본값 설정
        }
        
        // 검색어가 유효한 경우에만 검색 수행
        if (query != null && !query.trim().isEmpty()) {
            if (category == null || category.trim().isEmpty()) {
                category = "all"; // 기본 카테고리 설정
            }

            
         // 카테고리별 검색 결과 초기화
            List<MemberVo> memberResults = null;
            List<ProdVo> productResults = null;
            List<BoardVo> boardResults = null;
            
            // 카테고리별로 검색 수행
            switch (category) {
            case "prod":
                productResults = searchService.searchProd(query, sort);
                req.setAttribute("productResults", productResults);
                break;
            case "board":
                boardResults = searchService.searchBoard(query, boardcode, sort);
                req.setAttribute("boardResults", boardResults);
                break;
                
                
            case "member":
                memberResults = searchService.searchMember(query);
                req.setAttribute("memberResults", memberResults);
                break;
                default:
                    // 통합 검색 수행 (상품, 회원, 피드 게시판, 집들이 게시판 검색)
                    memberResults = searchService.searchMember(query);
                    productResults = searchService.searchProd(query, sort);
                    boardResults = searchService.searchBoard(query, 4, sort);

                    // 검색 결과를 request에 설정
                    req.setAttribute("memberResults", memberResults);
                    req.setAttribute("productResults", productResults);
                    req.setAttribute("boardResults", boardResults);
                    break;
            }

            // 검색어와 카테고리를 request에 설정
            req.setAttribute("query", query);
            req.setAttribute("category", category);
        } else {
            req.setAttribute("message", "검색어를 입력해주세요.");
        }

        // 검색 결과 페이지로 포워딩
        req.getRequestDispatcher("/WEB-INF/view/search/search.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // POST 요청 시에도 GET 요청 처리 로직을 사용
    }
}
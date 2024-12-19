package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.IWishListService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.service.WishListServiceImpl;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/prod/prodlist.do")
public class ProdListController extends HttpServlet {

    private IProdService prodService = ProdServiceImpl.getInstance();
    private IWishListService wishListService = WishListServiceImpl.getInstance();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String cateNoStr = req.getParameter("cate_no");
        int cate_no = parseCateNo(cateNoStr);
        
        HttpSession session = req.getSession();
        Integer mem_no = (Integer) session.getAttribute("mem_no");
        
        String search = req.getParameter("search");
        String select = req.getParameter("select");

        // 검색 필터링 설정
        ProdVo searchProd = new ProdVo();
        searchProd.setCate_no(cate_no);
        
        if (mem_no != null) {
            searchProd.setMem_no(mem_no);
        }
        
        if ("prod_name".equals(select)) {
            searchProd.setProd_name(search);
        } else if ("cate_name".equals(select)) {
            searchProd.setCate_name(search);
        }

        // 상품 리스트 및 카테고리 리스트 조회
        List<ProdVo> prodList = prodService.prodList(searchProd);
        List<ProdVo> prodCateList = prodService.prodCateList();
        
         //첫 번째 카테고리 정보 설정 (기본값 설정)
        if (!prodCateList.isEmpty()) {
            req.setAttribute("cate_name", prodCateList.get(0).getCate_name());
            req.setAttribute("cate_no", prodCateList.get(0).getCate_no());
        } else {
            req.setAttribute("cate_name", "No Category");
            req.setAttribute("cate_no", 1);
        }

        // 요청 객체에 속성 설정
        req.setAttribute("prodCateList", prodCateList);
        req.setAttribute("prodList", prodList);

        // 페이지 포워딩
        req.getRequestDispatcher("/WEB-INF/view/prod/prodlist.jsp").forward(req, resp);
    }

    // cate_no 값을 파싱하여 유효한 값을 반환하는 메서드
    private int parseCateNo(String cateNoStr) {
        if (cateNoStr == null || cateNoStr.isEmpty()) {
            return 1; // 기본 카테고리 번호 (필요에 따라 수정)
        }
        try {
            return Integer.parseInt(cateNoStr);
        } catch (NumberFormatException e) {
            return 1; // 기본 카테고리 번호 (필요에 따라 수정)
        }
    }
}

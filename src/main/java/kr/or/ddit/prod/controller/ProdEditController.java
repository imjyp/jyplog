package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/prod/editProd.do")
public class ProdEditController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
    private IProdService prodService = ProdServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int prodNo = Integer.parseInt(req.getParameter("prod_no"));

        // 상품 정보 가져오기
        ProdVo prodVo = prodService.prodDetail(prodNo);
        req.setAttribute("prodVo", prodVo);

        // 카테고리 목록 가져오기 (선택 가능)
        List<ProdVo> cateList = prodService.prodCateList();
        req.setAttribute("cateList", cateList);

        req.getRequestDispatcher("/WEB-INF/view/admin/prodeditmanagement.jsp").forward(req, resp);
    }

}

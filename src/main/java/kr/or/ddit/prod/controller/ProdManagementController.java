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

@WebServlet("/admin/prodmanagement.do")
public class ProdManagementController extends HttpServlet{
	
	private IProdService prodService = ProdServiceImpl.getInstance();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// 제품 목록 조회
		List<ProdVo> prodManagementList = prodService.prodManagementList();
		
		// 제품 목록을 요청 객체에 저장
		req.setAttribute("prodManagementList", prodManagementList);
		
		// JSP로 포워딩
		req.getRequestDispatcher("/WEB-INF/view/admin/prodmanagement.jsp").forward(req, resp);
		
	}

}

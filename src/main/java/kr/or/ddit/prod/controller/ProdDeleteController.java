package kr.or.ddit.prod.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;

@WebServlet("/prod/deleteSelectedProd.do")
public class ProdDeleteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private IProdService prodService = ProdServiceImpl.getInstance();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String[] selectedProdNos = req.getParameterValues("prod_no");

	        if (selectedProdNos != null && selectedProdNos.length > 0) {
	            try {
	                for (String prodNo : selectedProdNos) {
	                    int prodNoInt = Integer.parseInt(prodNo);
	                    prodService.deleteProdCascade(prodNoInt);
	                }
	                resp.sendRedirect(req.getContextPath() + "/admin/prodmanagement.do");
	            } catch (Exception e) {
	                e.printStackTrace();
	                resp.sendRedirect(req.getContextPath() + "/admin/prodmanagement.do?error=deleteFailed");
	            }
	        } else {
	            resp.sendRedirect(req.getContextPath() + "/admin/prodmanagement.do?error=noSelection");
	        }
	    }
}

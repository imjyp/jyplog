package kr.or.ddit.main;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/main/main.do")
public class MainController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("메인 페이지");
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html");
		req.getRequestDispatcher("/Includes/main.jsp").forward(req, resp);
		
	}
	
}
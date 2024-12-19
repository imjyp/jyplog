package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.order.service.IOrderService;
import kr.or.ddit.order.service.OrderServiceImpl;
import kr.or.ddit.prod.service.IWishListService;
import kr.or.ddit.prod.service.WishListServiceImpl;
import kr.or.ddit.prod.vo.WishListVo;

@WebServlet("/wishlist.do")
public class WishListController extends HttpServlet {
	
	private IWishListService wishListService = WishListServiceImpl.getInstance();
	IOrderService orderService = OrderServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션에서 회원번호 (mem_no) 가져오기 (로그인한 사용자 정보를 가정)
		HttpSession session = req.getSession();
		Integer mem_no = (Integer) session.getAttribute("mem_no");
		if (mem_no == null) {
			// 로그인이 안되어 있는 경우 로그인 페이지로 리다이렉트
			resp.sendRedirect(req.getContextPath() + "/member/login.do");
			return;
		}
		
		// 위시 리스트 조회
		WishListVo wishListVo = new WishListVo();
		wishListVo.setMem_no(mem_no);
		List<WishListVo> wishList = wishListService.getWishList(wishListVo);
		
		// 요청 속성에 위시리스트 설정
		req.setAttribute("wishList", wishList);
		
		// 위시리스트 JSP 페이지로 포워딩
		req.getRequestDispatcher("/WEB-INF/view/prod/wishlist.jsp").forward(req, resp);
	}
}

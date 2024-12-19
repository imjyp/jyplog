package kr.or.ddit.prod.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.prod.service.IWishListService;
import kr.or.ddit.prod.service.WishListServiceImpl;
import kr.or.ddit.prod.vo.WishListVo;

@WebServlet("/wishlist/add.do")
public class WishListAddController extends HttpServlet {

    private IWishListService wishListService = WishListServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer memNo = (Integer) session.getAttribute("mem_no");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (memNo == null) {
            // 로그인되어 있지 않은 경우 JSON 응답으로 반환
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("{\"message\": \"로그인이 필요합니다.\"}");
            return;
        }

        try {
            int prodNo = Integer.parseInt(req.getParameter("prod_no"));

            WishListVo wishListVo = new WishListVo();
            wishListVo.setMem_no(memNo);
            wishListVo.setProd_no(prodNo);
            
         // 위시리스트 추가 또는 업데이트 처리
            wishListService.addOrUpdateWishList(wishListVo);
            
            resp.getWriter().write("{\"message\": \"장바구니에 추가되었습니다.\"}");

            
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"message\": \"잘못된 상품 번호 형식입니다.\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"message\": \"장바구니 추가 중 오류가 발생했습니다.\"}");
            e.printStackTrace();
        }
    }
}

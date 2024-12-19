package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.prod.service.IWishListService;
import kr.or.ddit.prod.service.WishListServiceImpl;
import kr.or.ddit.prod.vo.WishListVo;

@WebServlet("/wishlist/deleteSelected.do")
public class WishListDeleteController extends HttpServlet {

	private IWishListService wishListService = WishListServiceImpl.getInstance();

	@Override
	 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer memNo = (Integer) session.getAttribute("mem_no");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (memNo == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("{\"message\": \"로그인이 필요합니다.\"}");
            return;
        }

        try {
            // 여러 상품 번호를 받아서 리스트로 변환
            List<Integer> prodNos = Arrays.stream(req.getParameterValues("prod_no"))
                                          .map(Integer::parseInt)
                                          .collect(Collectors.toList());

            if (prodNos.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"message\": \"삭제할 상품을 선택하세요.\"}");
                return;
            }

            // 서비스 호출하여 선택된 위시리스트 항목 삭제
            int result = wishListService.removeSelectedWishItems(memNo, prodNos);
            if (result > 0) {
                resp.getWriter().write("{\"message\": \"선택한 항목이 삭제되었습니다.\"}");
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"message\": \"장바구니 삭제에 실패했습니다.\"}");
            }
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"message\": \"잘못된 상품 번호 형식입니다.\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"message\": \"장바구니 삭제 중 오류가 발생했습니다.\"}");
            e.printStackTrace();
        }
    }
}

package kr.or.ddit.prod.controller;

import java.io.IOException;

import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.prod.service.IWishListService;
import kr.or.ddit.prod.service.WishListServiceImpl;
import kr.or.ddit.prod.vo.WishListVo;

@WebServlet("/wishlist/remove.do")
public class WishListRemoveController extends HttpServlet {

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
            String[] prodNos = req.getParameterValues("prod_no");
            if (prodNos != null) {
                for (String prodNoStr : prodNos) {
                    int prodNo = Integer.parseInt(prodNoStr);
                    WishListVo wishListVo = new WishListVo();
                    wishListVo.setMem_no(memNo);
                    wishListVo.setProd_no(prodNo);
                    wishListService.updateWishListStateToRemove(wishListVo);
                }
            }

            resp.getWriter().write("{\"message\": \"삭제가 완료되었습니다.\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"message\": \"장바구니 삭제 중 오류가 발생했습니다.\"}");
            e.printStackTrace();
        }
    }
}

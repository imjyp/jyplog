package kr.or.ddit.order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/addToCart.do")
public class AddToCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 상품 정보 가져오기
        int prodNo = Integer.parseInt(req.getParameter("prod_no"));
        String prodName = req.getParameter("prod_name");
        String prodDescription = req.getParameter("prod_description");
        int prodPrice = Integer.parseInt(req.getParameter("prod_price"));

        // 이미지 경로는 여러 개일 수 있으므로 리스트로 처리
        String[] prodImages = req.getParameterValues("prod_image_url");
        List<String> imagePaths = new ArrayList<>();
        if (prodImages != null) {
            for (String imagePath : prodImages) {
                imagePaths.add(imagePath);
            }
        }

        // 상품 객체 생성
        ProdVo product = new ProdVo();
        product.setProd_no(prodNo);
        product.setProd_name(prodName);
        product.setProd_description(prodDescription);
        product.setProd_price(prodPrice);
        product.setImagePaths(imagePaths); // 이미지 경로 리스트 설정

        // 세션에서 장바구니 목록 가져오기 (없으면 새로 생성)
        List<ProdVo> cartItems = (List<ProdVo>) req.getSession().getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        // 장바구니에 해당 상품이 이미 존재하는지 확인
        boolean exists = false;
        for (ProdVo item : cartItems) {
            if (item.getProd_no() == prodNo) {
                exists = true;
                // 중복된 상품이 있을 경우, 장바구니에 수량을 추가하는 로직이 필요하면 여기서 추가 가능
                break;
            }
        }

        // 상품이 장바구니에 없으면 추가
        if (!exists) {
            cartItems.add(product);
        }

        // 세션에 장바구니 목록 저장
        req.getSession().setAttribute("cartItems", cartItems);

        // 장바구니 페이지로 리디렉션
        resp.sendRedirect("cart.do");
    }
}

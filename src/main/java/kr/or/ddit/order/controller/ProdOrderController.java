package kr.or.ddit.order.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.order.service.IProdOrderService;
import kr.or.ddit.order.service.ProdOrderServiceImpl;
import kr.or.ddit.order.vo.ProdOrderVo;

@WebServlet("/prodOrder.do")
public class ProdOrderController extends HttpServlet {

    private IProdOrderService prodOrderService = ProdOrderServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 디버깅: 전달된 모든 파라미터 확인
        System.out.println("=== ProdOrderController: Received Parameters ===");
        req.getParameterMap().forEach((key, value) -> System.out.println(key + " : " + String.join(",", value)));
        System.out.println("============================================");

        // 로그인된 사용자 확인
        MemberVo loginUser = (MemberVo) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            System.out.println("User not logged in. Redirecting to order page with error.");
            req.setAttribute("errorMessage", "로그인이 필요합니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }

        int memNo = loginUser.getMem_no();
        System.out.println("Received memNo from session: " + memNo);

        // 파라미터 수집 및 검증 (prodNo, orderCnt, totalPrice)
        String prodNoParam = req.getParameter("prodNo");
        String orderCntParam = req.getParameter("orderCnt");
        String totalPriceParam = req.getParameter("totalPrice");

        if (prodNoParam == null || orderCntParam == null || totalPriceParam == null ||
            prodNoParam.isEmpty() || orderCntParam.isEmpty() || totalPriceParam.isEmpty()) {
            System.out.println("Invalid product or price information received. Redirecting to order page with error.");
            req.setAttribute("errorMessage", "상품 정보 또는 가격 정보가 유효하지 않습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }

        int prodNo = Integer.parseInt(prodNoParam);
        int orderCnt = Integer.parseInt(orderCntParam);
        int totalPrice = Integer.parseInt(totalPriceParam); // 가격 정보 추가

        // 최근 생성된 orderNo 가져오기
        int orderNo = prodOrderService.getMostRecentOrderNoByMemNo(memNo);
        if (orderNo == 0) {
            System.out.println("Failed to fetch the most recent orderNo.");
            req.setAttribute("errorMessage", "주문번호를 생성할 수 없습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }
        System.out.println("Fetched most recent orderNo: " + orderNo);

        // ProdOrder 객체 생성 및 설정
        ProdOrderVo prodOrder = new ProdOrderVo();
        prodOrder.setOrderNo(orderNo); // 조회된 최근 order_no 사용
        prodOrder.setProdNo(prodNo);
        prodOrder.setOrderCnt(orderCnt);
        prodOrder.setOrderPrice(totalPrice); // 가격 정보를 설정
        prodOrder.setMemNo(memNo);

        // 데이터베이스에 주문 상품 삽입 시도
        try {
            int prodOrderResult = prodOrderService.insertProdOrder(prodOrder);
            if (prodOrderResult <= 0) {
                req.setAttribute("errorMessage", "주문 상품 처리에 실패했습니다.");
                req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/WEB-INF/view/pay/success.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "주문 상품 처리 중 오류가 발생했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
        }
    }
}

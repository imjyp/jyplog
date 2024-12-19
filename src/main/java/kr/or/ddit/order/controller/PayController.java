package kr.or.ddit.order.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.order.service.IPayService;
import kr.or.ddit.order.service.PayServiceImpl;
import kr.or.ddit.order.vo.PayVo;

@WebServlet("/pay.do")
public class PayController extends HttpServlet {

    private IPayService payService = PayServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 결제 정보 저장
        String orderNoParam = req.getParameter("orderNo");
        String payPriceParam = req.getParameter("payPrice");

        if (orderNoParam == null || orderNoParam.isEmpty() || payPriceParam == null || payPriceParam.isEmpty()) {
            req.setAttribute("errorMessage", "결제 정보가 유효하지 않습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }

        int orderNo = Integer.parseInt(orderNoParam);
        int payPrice = Integer.parseInt(payPriceParam);
        System.out.println("Payment info: orderNo = " + orderNo + ", payPrice = " + payPrice); // 디버깅

        PayVo pay = new PayVo();
        pay.setOrderNo(orderNo);
        pay.setPayPrice(payPrice);

        int payResult = payService.insertPay(pay);
        System.out.println("Payment result: " + payResult); // 디버깅

        if (payResult <= 0) {
            req.setAttribute("errorMessage", "결제 처리에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/view/pay/receipt.jsp").forward(req, resp);
        }
    }
}

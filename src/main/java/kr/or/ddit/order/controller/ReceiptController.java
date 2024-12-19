package kr.or.ddit.order.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/receipt.do")
public class ReceiptController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // GET 요청이 발생하는 경우, 파라미터가 없을 수 있으므로 세션에서 값을 가져옵니다.
        HttpSession session = req.getSession();

        // 세션에서 파라미터를 가져옴
        String orderProduct = (String) session.getAttribute("orderProduct");
        String optionDetail = (String) session.getAttribute("optionDetail");
        String quantity = (String) session.getAttribute("quantity");
        String deliveryAddress = (String) session.getAttribute("deliveryAddress");
        String detailedAddress = (String) session.getAttribute("detailedAddress");
        String requestNote = (String) session.getAttribute("requestNote");
        String paymentAmount = (String) session.getAttribute("paymentAmount");

        // JSP 페이지로 포워딩
        req.setAttribute("orderProduct", orderProduct);
        req.setAttribute("optionDetail", optionDetail);
        req.setAttribute("quantity", quantity);
        req.setAttribute("deliveryAddress", deliveryAddress);
        req.setAttribute("detailedAddress", detailedAddress);
        req.setAttribute("requestNote", requestNote);
        req.setAttribute("paymentAmount", paymentAmount);

        req.getRequestDispatcher("/WEB-INF/view/pay/receipt.jsp").forward(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 로그인 정보 확인
        HttpSession session = req.getSession();
        Object loginUser = session.getAttribute("loginUser");  // 세션에서 loginUser 확인
        
        if (loginUser == null) {
            // 사용자가 로그인되어 있지 않다면, 주문 페이지로 리다이렉트
            System.out.println("User not logged in. Redirecting to order page with error.");
            resp.sendRedirect(req.getContextPath() + "/order.do?action=loginRequired");  // 로그인 페이지 또는 주문 페이지로 이동
            return;
        }
        
        System.out.println("User is logged in: " + loginUser);  // 로그인 확인

        // 파라미터 수신
        String orderProduct = req.getParameter("orderProduct");
        String optionDetail = req.getParameter("optionDetail");
        String quantity = req.getParameter("quantity");
        String deliveryAddress = req.getParameter("deliveryAddress");
        String detailedAddress = req.getParameter("detailedAddress");
        String requestNote = req.getParameter("requestNote");
        String paymentAmount = req.getParameter("paymentAmount");

        // 파라미터 출력 (디버깅)
        System.out.println("Order Product: " + orderProduct);
        System.out.println("Option Detail: " + optionDetail);
        System.out.println("Quantity: " + quantity);
        System.out.println("Delivery Address: " + deliveryAddress);
        System.out.println("Detailed Address: " + detailedAddress);
        System.out.println("Request Note: " + requestNote);
        System.out.println("Payment Amount: " + paymentAmount);

        // 파라미터를 세션에 저장
        session.setAttribute("orderProduct", orderProduct);
        session.setAttribute("optionDetail", optionDetail);
        session.setAttribute("quantity", quantity);
        session.setAttribute("deliveryAddress", deliveryAddress);
        session.setAttribute("detailedAddress", detailedAddress);
        session.setAttribute("requestNote", requestNote);
        session.setAttribute("paymentAmount", paymentAmount);

        // 세션 저장 확인
        System.out.println("Session values set:");
        System.out.println("Order Product: " + session.getAttribute("orderProduct"));
        System.out.println("Option Detail: " + session.getAttribute("optionDetail"));
        System.out.println("Quantity: " + session.getAttribute("quantity"));
        System.out.println("Delivery Address: " + session.getAttribute("deliveryAddress"));
        System.out.println("Detailed Address: " + session.getAttribute("detailedAddress"));
        System.out.println("Request Note: " + session.getAttribute("requestNote"));
        System.out.println("Payment Amount: " + session.getAttribute("paymentAmount"));

        // POST 요청이므로 GET 방식으로 페이지를 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/receipt.do");
    }
}

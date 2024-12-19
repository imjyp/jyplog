package kr.or.ddit.order.controller;

import java.io.IOException;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.Websocket;
import kr.or.ddit.order.service.DelivServiceImpl;
import kr.or.ddit.order.service.IDelivService;
import kr.or.ddit.order.service.IOrderService;
import kr.or.ddit.order.service.IPayService;
import kr.or.ddit.order.service.OrderServiceImpl;
import kr.or.ddit.order.service.PayServiceImpl;
import kr.or.ddit.order.vo.DelivVo;
import kr.or.ddit.order.vo.OrderVo;
import kr.or.ddit.order.vo.PayVo;

@WebServlet("/order.do")
public class OrderController extends HttpServlet {

    private IOrderService orderService = OrderServiceImpl.getInstance();
    private IDelivService delivService = DelivServiceImpl.getInstance();
    private IPayService payService = PayServiceImpl.getInstance(); // 결제 서비스 추가

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println("Action: " + action); // 디버깅: action 값 출력

        if ("home".equals(action)) {
            System.out.println("Home action detected.");
            req.getRequestDispatcher("/Includes/main.jsp").forward(req, resp);
        } else if ("getRecentDelivery".equals(action)) {
            try {
                int memNo = Integer.parseInt(req.getParameter("memNo"));
                System.out.println("Received memNo: " + memNo); // 디버깅

                DelivVo recentDelivery = delivService.getLatestDelivery(memNo);
                System.out.println("Recent delivery: " + recentDelivery); // 디버깅

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                if (recentDelivery == null) {
                    System.out.println("최근 배송 정보가 없습니다.");
                    resp.getWriter().write("{}"); // 빈 JSON 객체 반환
                } else {
                    System.out.println("최근 배송 정보: " + recentDelivery);
                    resp.getWriter().write(new JSONObject(recentDelivery).toString());
                }
            } catch (NumberFormatException e) {
                System.out.println("NumberFormatException: " + e.getMessage()); // 디버깅
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\": \"Invalid member number.\"}");
            }
        } else {
            System.out.println("Forwarding to order page.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String memNoParam = req.getParameter("memNo");
        System.out.println("Received memNoParam: " + memNoParam); // 디버깅
        Integer mem_no = null;
        try {
            mem_no = Integer.parseInt(memNoParam);
            System.out.println("Parsed mem_no: " + mem_no); // 디버깅
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage()); // 디버깅
            req.setAttribute("errorMessage", "유효하지 않은 회원 번호입니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }

        // 배송 정보 수집
        String deliv_name = req.getParameter("deliveryName");
        String recipient = req.getParameter("recipientName");
        String phone = req.getParameter("phone");
        String base_addr = req.getParameter("address");
        String detail_addr = req.getParameter("detailedAddress");
        String request_note = req.getParameter("request");
        String totalPriceParam = req.getParameter("totalPrice");
        System.out.println("Collected delivery info: " + deliv_name + ", " + recipient + ", " + phone); // 디버깅

        int total_price = 0;

        try {
            if (totalPriceParam != null && !totalPriceParam.isEmpty()) {
                totalPriceParam = totalPriceParam.replaceAll("[,원]", "");
                total_price = Integer.parseInt(totalPriceParam);
                System.out.println("Parsed total_price: " + total_price); // 디버깅
            }
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException for totalPrice: " + e.getMessage()); // 디버깅
            req.setAttribute("errorMessage", "유효하지 않은 총 금액입니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }

        // 배송 정보 저장
        DelivVo delivery = new DelivVo();
        delivery.setBase_addr(base_addr);
        delivery.setDetail_addr(detail_addr);
        delivery.setDeliv_name(deliv_name);
        delivery.setRequest_note(request_note);
        delivery.setRecipient(recipient);
        delivery.setPhone(phone);
        delivery.setMem_no(mem_no);  // 폼에서 가져온 회원번호 설정
        delivery.setPhone(phone);
        delivery.setMem_no(mem_no);  // 폼에서 가져온 회원번호 설정
        delivery.setPhone(phone);
        delivery.setMem_no(mem_no);

        int deliveryResult = delivService.insertDelivery(delivery);
        System.out.println("Delivery result: " + deliveryResult); // 디버깅

        if (deliveryResult <= 0) {
            req.setAttribute("errorMessage", "배송 정보 처리에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }

        // 주문 정보 저장
        int deliv_no = delivery.getDeliv_no();
        OrderVo order = new OrderVo();
        order.setMem_no(mem_no);
        order.setDeliv_no(deliv_no);
        order.setOrder_stat("주문완료");
        order.setOrder_price(total_price);
        order.setTotal_price(total_price);

        int orderResult = orderService.insertOrder(order);
        System.out.println("Order result: " + orderResult); // 디버깅

        if (orderResult <= 0) {
            req.setAttribute("errorMessage", "주문 처리에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
            return;
        }

        System.out.println("생성된 주문 번호: " + order.getOrder_no());

        // 결제 정보 저장
        PayVo pay = new PayVo();
        pay.setOrderNo(order.getOrder_no());
        pay.setPayPrice(total_price);

        int payResult = payService.insertPay(pay);
        System.out.println("Payment result: " + payResult); // 디버깅

        if (payResult > 0) {
            // WebSocket을 통해 주문 완료 알림 전송

        	String notificationMessage = "주문번호 [" + order.getOrder_no() + "] 주문이 완료되었습니다";
            req.setAttribute("notificationMessage", notificationMessage);
            Websocket.sendNotification(notificationMessage);  // 웹소켓을 통한 알림 전송
            
            req.getRequestDispatcher("/WEB-INF/view/pay/receipt.jsp").forward(req, resp);  // 영수증 페이지로 포워딩
        } else {
            req.setAttribute("errorMessage", "결제 처리에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/order.jsp").forward(req, resp);
        }
    }
}

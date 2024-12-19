package kr.or.ddit.order.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.order.service.IOrderService;
import kr.or.ddit.order.service.OrderServiceImpl;
import kr.or.ddit.order.vo.OrderCancelVo;
import kr.or.ddit.order.vo.OrderDetailVo;
import kr.or.ddit.order.vo.OrderVo;

@WebServlet("/orders")
public class OrdersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private IOrderService orderService = OrderServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("[OrdersController] doGet() 호출됨");

        // 요청 파라미터에서 action 값 가져오기
        String action = req.getParameter("action");
        System.out.println("[OrdersController] action 파라미터: " + action);
        if (action == null) {
            action = "list"; // 기본 값 설정
            System.out.println("[OrdersController] action이 null이므로 기본값 'list'로 설정");
        }

        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = req.getSession(false);
        MemberVo loginUser = (MemberVo) (session != null ? session.getAttribute("loginUser") : null);
        System.out.println("[OrdersController] 로그인 사용자: " + (loginUser != null ? loginUser.getMem_id() : "null"));

        // 로그인 여부 확인
        if (loginUser == null) {
            System.out.println("[OrdersController] 로그인하지 않은 사용자입니다. 로그인 페이지로 리다이렉트합니다.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            switch (action) {
                case "list":
                    System.out.println("[OrdersController] 주문 목록 조회 처리 시작");
                    // 주문 목록 조회
                    processOrderList(req, resp, loginUser.getMem_no());
                    break;
                default:
                    System.out.println("[OrdersController] 잘못된 action 요청: " + action);
                    // 잘못된 action 처리
                    req.setAttribute("message", "잘못된 요청입니다.");
                    req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            System.out.println("[OrdersController] 오류 발생: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("message", "처리 중 오류가 발생했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
        }
    }

    /**
     * 주문 목록 조회 처리
     */
    private void processOrderList(HttpServletRequest req, HttpServletResponse resp, int memNo)
            throws ServletException, IOException {
        System.out.println("[OrdersController] processOrderList() 호출됨 - 회원 번호: " + memNo);
        try {
            // 주문 내역 조회
            List<OrderDetailVo> orderDetails = orderService.getOrderHistory(memNo);
            System.out.println("[OrdersController] 조회된 주문 상세 내역 개수: " + (orderDetails != null ? orderDetails.size() : 0));

            req.setAttribute("orderDetails", orderDetails);
            req.getRequestDispatcher("/WEB-INF/view/mypage/order.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println("[OrdersController] 주문 목록 조회 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("message", "주문 목록 조회 중 오류가 발생했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
        }
    }

    /**
     * 주문 취소 처리 (POST 요청)
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("[OrdersController] doPost() 호출됨");

        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = req.getSession(false);
        MemberVo loginUser = (MemberVo) (session != null ? session.getAttribute("loginUser") : null);
        System.out.println("[OrdersController] 로그인 사용자: " + (loginUser != null ? loginUser.getMem_id() : "null"));

        // 로그인 여부 확인
        if (loginUser == null) {
            System.out.println("[OrdersController] 로그인하지 않은 사용자입니다. 로그인 페이지로 리다이렉트합니다.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        System.out.println("[OrdersController] action 파라미터: " + action);

        if ("cancel".equals(action)) {
            System.out.println("[OrdersController] 주문 취소 처리 시작");
            // 주문 취소 처리
            try {
                processOrderCancel(req, resp, loginUser.getMem_no());
            } catch (Exception e) {
                System.out.println("[OrdersController] 주문 취소 처리 중 오류 발생: " + e.getMessage());
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\": false, \"message\": \"주문 취소 중 오류가 발생했습니다.\"}");
            }
        } else {
            System.out.println("[OrdersController] 잘못된 POST 요청: action=" + action);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
        }
    }

    private void processOrderCancel(HttpServletRequest req, HttpServletResponse resp, int memNo) throws Exception {
        System.out.println("[OrdersController] processOrderCancel() 호출됨 - 회원 번호: " + memNo);
        try {
            int orderNo = Integer.parseInt(req.getParameter("orderNo"));
            System.out.println("[OrdersController] 취소할 주문 번호: " + orderNo);

            // 주문 정보 조회
            OrderVo order = orderService.getOrder(orderNo);
            System.out.println("[OrdersController] 조회된 주문 정보: " + order);

            if (order == null || order.getMem_no() != memNo) {
                System.out.println("[OrdersController] 해당 주문을 취소할 권한이 없습니다.");
                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                resp.getWriter().write("{\"success\": false, \"message\": \"해당 주문을 취소할 권한이 없습니다.\"}");
                return;
            }

            // 주문 상태를 '주문취소'로 업데이트
            order.setOrder_stat("주문취소");
            int result = orderService.updateOrder(order);
            System.out.println("[OrdersController] 주문 상태 업데이트 결과: " + result);

            if (result > 0) {
                // 주문 취소 내역 삽입
                OrderCancelVo cancelVo = new OrderCancelVo();
                cancelVo.setOrder_no(orderNo);
                cancelVo.setCancel_amount(order.getOrder_price());
                int cancelResult = orderService.insertOrderCancel(cancelVo);
                System.out.println("[OrdersController] 주문 취소 내역 삽입 결과: " + cancelResult);

                // 성공 응답
                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\": true, \"message\": \"주문이 성공적으로 취소되었습니다.\"}");
                System.out.println("[OrdersController] 주문 취소 처리 성공");
            } else {
                // 실패 응답
                System.out.println("[OrdersController] 주문 상태 업데이트 실패");
                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\": false, \"message\": \"주문 취소에 실패하였습니다.\"}");
            }

        } catch (NumberFormatException e) {
            System.out.println("[OrdersController] 잘못된 주문 번호 형식");
            resp.setContentType("application/json");
            resp.getWriter().write("{\"success\": false, \"message\": \"잘못된 주문 번호입니다.\"}");
        }
    }
}

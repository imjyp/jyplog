package kr.or.ddit.notification.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.notification.service.INotificationService;
import kr.or.ddit.notification.service.NotificationServiceImpl;
import kr.or.ddit.order.vo.ProdOrderVo;

@WebServlet("/notification/notification.do")
public class NotificationContoller extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	INotificationService notificationService = NotificationServiceImpl.getInstance();


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String type = req.getParameter("type"); // 알림 유형을 구분하기 위한 파라미터 (주문, 게시글 등)
		resp.setContentType("application/json; charset=UTF-8");
		
		StringBuilder jsonResponse = new StringBuilder();
		jsonResponse.append("{");

        if (type == null || type.equals("all")) {
            // 전체 알림 조회
            List<ProdOrderVo> orderNotifications = notificationService.getOrderNotifications();
            List<BoardVo> boardNotifications = notificationService.getBoardNotifications();

            // JSON 문자열 수동 생성
            jsonResponse.append("\"orderNotifications\":[");
            for (int i = 0; i < orderNotifications.size(); i++) {
                ProdOrderVo order = orderNotifications.get(i);
                jsonResponse.append("{\"orderNo\":\"").append(order.getOrderNo()).append("\",")
                            .append("\"prodNo\":\"").append(order.getProdNo()).append("\",")
                            .append("\"orderCnt\":\"").append(order.getOrderCnt()).append("\"}");
                if (i < orderNotifications.size() - 1) {
                    jsonResponse.append(",");
                }
            }
            jsonResponse.append("],");

            jsonResponse.append("\"boardNotifications\":[");
            for (int i = 0; i < boardNotifications.size(); i++) {
                BoardVo board = boardNotifications.get(i);
                jsonResponse.append("{\"boardNo\":\"").append(board.getBoard_no()).append("\",")
                            .append("\"title\":\"").append(board.getTitle()).append("\"}");
                if (i < boardNotifications.size() - 1) {
                    jsonResponse.append(",");
                }
            }
            jsonResponse.append("]");
        } else if (type.equals("order")) {
            // 주문 알림만 조회
            List<ProdOrderVo> orderNotifications = notificationService.getOrderNotifications();
            jsonResponse.append("\"orderNotifications\":[");
            for (int i = 0; i < orderNotifications.size(); i++) {
                ProdOrderVo order = orderNotifications.get(i);
                jsonResponse.append("{\"orderNo\":\"").append(order.getOrderNo()).append("\",")
                            .append("\"prodNo\":\"").append(order.getProdNo()).append("\",")
                            .append("\"orderCnt\":\"").append(order.getOrderCnt()).append("\"}");
                if (i < orderNotifications.size() - 1) {
                    jsonResponse.append(",");
                }
            }
            jsonResponse.append("]");
        } else if (type.equals("board")) {
            // 게시글 알림만 조회
            List<BoardVo> boardNotifications = notificationService.getBoardNotifications();
            jsonResponse.append("\"boardNotifications\":[");
            for (int i = 0; i < boardNotifications.size(); i++) {
                BoardVo board = boardNotifications.get(i);
                jsonResponse.append("{\"boardNo\":\"").append(board.getBoard_no()).append("\",")
                            .append("\"title\":\"").append(board.getTitle()).append("\"}");
                if (i < boardNotifications.size() - 1) {
                    jsonResponse.append(",");
                }
            }
            jsonResponse.append("]");
        }

        jsonResponse.append("}");

        resp.getWriter().write(jsonResponse.toString());
    }
}
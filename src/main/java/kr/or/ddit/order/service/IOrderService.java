package kr.or.ddit.order.service;

import kr.or.ddit.order.vo.OrderCancelVo;
import kr.or.ddit.order.vo.OrderDetailVo;
import kr.or.ddit.order.vo.OrderVo;
import kr.or.ddit.order.vo.ProdOrderVo;

import java.util.List;

public interface IOrderService {
    int insertOrder(OrderVo orderVo);    // 주문 삽입
    OrderVo getOrder(int orderNo);       // 주문 조회
    List<OrderVo> getAllOrders(int memNo);  // 모든 주문 조회
    int updateOrder(OrderVo orderVo);    // 주문 업데이트
    int deleteOrder(int orderNo);        // 주문 삭제 (지원되지 않음)

    // 주문 상태 업데이트 (주문 취소 등)
    int updateOrderToCancel(int orderNo);

    // 주문 취소 내역 삽입 (ORDER_CANCEL 테이블)
    int insertOrderCancel(OrderCancelVo orderCancelVo);

    // 주문된 상품 목록 조회 메서드 (주문 번호로 조회)
    List<ProdOrderVo> selectProdOrdersByOrderNo(int orderNo);

    // 회원 번호로 주문 내역 조회 메서드 (조인하여 주문 상세 정보 가져오기)
    List<OrderDetailVo> getOrderHistory(int memNo);
}

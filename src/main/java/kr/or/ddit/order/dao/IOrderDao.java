package kr.or.ddit.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.order.vo.OrderCancelVo;
import kr.or.ddit.order.vo.OrderDetailVo;
import kr.or.ddit.order.vo.OrderVo;
import kr.or.ddit.order.vo.ProdOrderVo;

public interface IOrderDao {
    // 주문 삽입 메서드
    int insertOrder(SqlSession sqlSession, OrderVo orderVo);

    // 주문 번호로 주문 조회 메서드
    OrderVo getOrder(SqlSession sqlSession, int orderNo);

    // 회원 번호로 모든 주문 조회 메서드
    List<OrderVo> getAllOrders(SqlSession sqlSession, int memNo);

    // 주문 상태 업데이트 (주문 취소 등)
    int updateOrderToCancel(SqlSession sqlSession, int orderNo);

    // 주문 취소 정보 삽입 (ORDER_CANCEL 테이블)
    int insertOrderCancel(SqlSession sqlSession, OrderCancelVo orderCancelVo);

    // 주문 업데이트 메서드
    int updateOrder(SqlSession sqlSession, OrderVo orderVo);

    // 주문 삭제 메서드 (지원되지 않음)
    int deleteOrder(int orderNo);

    // 주문 번호로 주문된 상품 목록 조회 메서드
    List<ProdOrderVo> selectProdOrdersByOrderNo(SqlSession sqlSession, int orderNo);

    // 회원 번호로 주문 상세 정보 조회 메서드 (조인한 결과)
    // 기존 getAllOrderDetails를 getOrderHistory로 수정
    List<OrderDetailVo> getOrderHistory(SqlSession sqlSession, int memNo);
}

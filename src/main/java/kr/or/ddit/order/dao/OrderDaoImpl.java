package kr.or.ddit.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.order.vo.OrderCancelVo;
import kr.or.ddit.order.vo.OrderDetailVo;
import kr.or.ddit.order.vo.OrderVo;
import kr.or.ddit.order.vo.ProdOrderVo;

public class OrderDaoImpl implements IOrderDao {

    // Singleton instance
    private static OrderDaoImpl instance;

    // Private constructor for Singleton pattern
    private OrderDaoImpl() {
    }

    // Get the singleton instance
    public static OrderDaoImpl getInstance() {
        if (instance == null) {
            instance = new OrderDaoImpl();
        }
        return instance;
    }

    // 주문 등록 메서드
    @Override
    public int insertOrder(SqlSession sqlSession, OrderVo orderVo) {
        int result = sqlSession.insert("OrderMapper.insertOrder", orderVo);
        return result;
    }

    // 주문 조회 메서드 (주문 번호로 조회)
    @Override
    public OrderVo getOrder(SqlSession sqlSession, int orderNo) {
        return sqlSession.selectOne("OrderMapper.getOrder", orderNo);
    }

    // 모든 주문 조회 메서드 (회원 번호로 조회)
    @Override
    public List<OrderVo> getAllOrders(SqlSession sqlSession, int memNo) {
        return sqlSession.selectList("OrderMapper.getAllOrders", memNo);
    }

    // 회원 번호로 주문 내역 조회 메서드 (조인 결과)
    @Override
    public List<OrderDetailVo> getOrderHistory(SqlSession sqlSession, int memNo) {
        return sqlSession.selectList("OrderMapper.getOrderHistory", memNo);
    }

    // 주문 상태 업데이트 메서드 (주문 취소로 상태 변경)
    @Override
    public int updateOrderToCancel(SqlSession sqlSession, int orderNo) {
        int result = sqlSession.update("OrderMapper.updateOrderToCancel", orderNo);
        return result;
    }

    // 주문 취소 내역 삽입 (ORDER_CANCEL 테이블)
    @Override
    public int insertOrderCancel(SqlSession sqlSession, OrderCancelVo orderCancelVo) {
        int result = sqlSession.insert("OrderMapper.insertOrderCancel", orderCancelVo);
        return result;
    }

    // 주문 업데이트 메서드
    @Override
    public int updateOrder(SqlSession sqlSession, OrderVo orderVo) {
        int result = sqlSession.update("OrderMapper.updateOrder", orderVo);
        return result;
    }

    // 주문 삭제 메서드 (사용되지 않음)
    @Override
    public int deleteOrder(int orderNo) {
        throw new UnsupportedOperationException("주문 삭제는 지원되지 않습니다. 주문 취소 기능을 사용하세요.");
    }

    // 주문된 상품 목록 조회 메서드 (주문 번호로 조회)
    @Override
    public List<ProdOrderVo> selectProdOrdersByOrderNo(SqlSession sqlSession, int orderNo) {
        return sqlSession.selectList("OrderMapper.selectProdOrdersByOrderNo", orderNo);
    }
}

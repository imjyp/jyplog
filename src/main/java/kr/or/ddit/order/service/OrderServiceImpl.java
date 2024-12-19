package kr.or.ddit.order.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.mybatis.MybatisUtil;
import kr.or.ddit.order.dao.IOrderDao;
import kr.or.ddit.order.dao.OrderDaoImpl;
import kr.or.ddit.order.vo.OrderCancelVo;
import kr.or.ddit.order.vo.OrderDetailVo;
import kr.or.ddit.order.vo.OrderVo;
import kr.or.ddit.order.vo.ProdOrderVo;

public class OrderServiceImpl implements IOrderService {

    private static OrderServiceImpl instance;
    private IOrderDao orderDao = OrderDaoImpl.getInstance();

    private OrderServiceImpl() { }

    public static OrderServiceImpl getInstance() {
        if (instance == null) {
            instance = new OrderServiceImpl();
        }
        return instance;
    }

    // 주문 등록
    @Override
    public int insertOrder(OrderVo order) {
        System.out.println("주문 등록 중: " + order);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            int result = orderDao.insertOrder(sqlSession, order);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("주문 등록 중 오류 발생", e);
        }
    }

    // 특정 주문 가져오기
    @Override
    public OrderVo getOrder(int orderNo) {
        System.out.println("주문 정보 가져오는 중: 주문 번호 - " + orderNo);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            return orderDao.getOrder(sqlSession, orderNo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("주문 조회 중 오류 발생", e);
        }
    }

    // 회원의 모든 주문 가져오기
    @Override
    public List<OrderVo> getAllOrders(int memNo) {
        System.out.println("회원의 모든 주문 가져오는 중: 회원 번호 - " + memNo);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            return orderDao.getAllOrders(sqlSession, memNo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("모든 주문 조회 중 오류 발생", e);
        }
    }

    // 회원의 주문 내역 조회 (주문 상세 정보)
    @Override
    public List<OrderDetailVo> getOrderHistory(int memNo) {
        System.out.println("회원의 주문 내역 가져오는 중: 회원 번호 - " + memNo);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            return orderDao.getOrderHistory(sqlSession, memNo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("주문 내역 조회 중 오류 발생", e);
        }
    }

    // 주문 상태 업데이트
    @Override
    public int updateOrder(OrderVo order) {
        System.out.println("주문 상태 업데이트 중: " + order);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            int result = orderDao.updateOrder(sqlSession, order);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("주문 상태 업데이트 중 오류 발생", e);
        }
    }

    // 주문 취소 상태로 업데이트
    @Override
    public int updateOrderToCancel(int orderNo) {
        System.out.println("주문을 취소 상태로 업데이트 중: 주문 번호 - " + orderNo);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            int result = orderDao.updateOrderToCancel(sqlSession, orderNo);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("주문 취소 처리 중 오류 발생", e);
        }
    }

    // 주문 취소 내역 추가
    @Override
    public int insertOrderCancel(OrderCancelVo orderCancelVo) {
        System.out.println("주문 취소 내역 추가 중: " + orderCancelVo);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            int result = orderDao.insertOrderCancel(sqlSession, orderCancelVo);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("주문 취소 내역 추가 중 오류 발생", e);
        }
    }

    // 특정 주문 번호로 상품 주문 목록 가져오기
    @Override
    public List<ProdOrderVo> selectProdOrdersByOrderNo(int orderNo) {
        System.out.println("주문 번호로 상품 주문 목록 가져오는 중: 주문 번호 - " + orderNo);
        try (SqlSession sqlSession = MybatisUtil.getInstance()) {
            return orderDao.selectProdOrdersByOrderNo(sqlSession, orderNo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("상품 주문 목록 조회 중 오류 발생", e);
        }
    }

    // 주문 삭제 (취소)
    @Override
    public int deleteOrder(int orderNo) {
        System.out.println("주문 삭제 중: 주문 번호 - " + orderNo);
        throw new UnsupportedOperationException("주문 삭제는 지원되지 않습니다. 주문 취소 기능을 사용하세요.");
    }
}

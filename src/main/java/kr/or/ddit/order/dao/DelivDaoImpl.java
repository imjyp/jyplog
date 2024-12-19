package kr.or.ddit.order.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import kr.or.ddit.mybatis.MybatisUtil;
import kr.or.ddit.order.vo.DelivVo;

public class DelivDaoImpl implements IDelivDao {

    // 싱글턴 인스턴스
    private static DelivDaoImpl instance = new DelivDaoImpl();
    private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

    // private 생성자 (외부 인스턴스 생성 방지)
    private DelivDaoImpl() { }

    // getInstance() 메서드로 싱글턴 인스턴스 반환
    public static DelivDaoImpl getInstance() {
        return instance;
    }

    @Override
    public int insertDelivery(DelivVo delivery) {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.insert("kr.or.ddit.order.dao.IDelivDao.insertDelivery", delivery);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;  // 오류 발생 시 0 반환
        }
    }

    // 회원 번호로 가장 최근 배송 정보를 가져오는 메서드 구현
    @Override
    public DelivVo getLatestDelivery(int memNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("kr.or.ddit.order.dao.IDelivDao.getLatestDelivery", memNo);
        } catch (Exception e) {
            e.printStackTrace();
            return null;  // 오류 발생 시 null 반환
        }
    }

    // 주문 번호로 배송 정보를 조회하는 메서드 구현
    public DelivVo selectDeliveryByOrderId(int orderId) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("kr.or.ddit.order.dao.IDelivDao.selectDeliveryByOrderId", orderId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;  // 오류 발생 시 null 반환
        }
    }
}

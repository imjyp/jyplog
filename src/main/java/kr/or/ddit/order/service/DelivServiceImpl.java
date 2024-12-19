package kr.or.ddit.order.service;

import kr.or.ddit.order.dao.DelivDaoImpl;
import kr.or.ddit.order.vo.DelivVo;

public class DelivServiceImpl implements IDelivService {

    private static IDelivService instance;
    private DelivDaoImpl delivDao;

    private DelivServiceImpl() {
        delivDao = DelivDaoImpl.getInstance();  // 수정: new 대신 getInstance() 사용
    }

    public static IDelivService getInstance() {
        if (instance == null) {
            instance = new DelivServiceImpl();
        }
        return instance;
    }

    @Override
    public int insertDelivery(DelivVo delivery) {
    	System.out.println("delivery 등록 중: " + delivery);
        return delivDao.insertDelivery(delivery);
    }

    @Override
    public DelivVo getLatestDelivery(int memNo) {
        return delivDao.getLatestDelivery(memNo);
    }

    // 주문 ID로 배송 정보를 조회하는 메서드 구현
    @Override
    public DelivVo getDeliveryByOrderId(int orderId) {
        return delivDao.selectDeliveryByOrderId(orderId);  // 다음 단계에서 구현할 메서드
    }
}

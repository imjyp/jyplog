package kr.or.ddit.order.service;

import kr.or.ddit.order.dao.IPayDao;
import kr.or.ddit.order.dao.PayDaoImpl;
import kr.or.ddit.order.vo.PayVo;

public class PayServiceImpl implements IPayService {

    private IPayDao payDao = PayDaoImpl.getInstance();  // DAO 인스턴스 가져오기

    private static IPayService instance;

    private PayServiceImpl() {
    }

    public static IPayService getInstance() {
        if (instance == null) {
            instance = new PayServiceImpl();
        }
        return instance;
    }

    @Override
    public int insertPay(PayVo payVo) {
        // 결제 정보를 삽입하는 비즈니스 로직 처리
    	System.out.println("pay 등록 중: " + payVo);
        return payDao.insertPay(payVo);
    }

    @Override
    public PayVo getPay(int orderNo) {
        // 주문 번호로 결제 정보를 조회하는 비즈니스 로직 처리
        return payDao.selectPay(orderNo);
    }
}

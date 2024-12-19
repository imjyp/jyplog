package kr.or.ddit.order.dao;

import kr.or.ddit.order.vo.PayVo;

public interface IPayDao {
    // 결제 정보를 DB에 삽입하는 메소드
    int insertPay(PayVo payVo);

    // 주문 번호로 결제 정보를 조회하는 메소드
    PayVo selectPay(int orderNo);
}

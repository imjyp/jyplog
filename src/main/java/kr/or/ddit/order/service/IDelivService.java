package kr.or.ddit.order.service;

import kr.or.ddit.order.vo.DelivVo;

public interface IDelivService {
    int insertDelivery(DelivVo delivery);

    DelivVo getLatestDelivery(int memNo);

    // 주문 번호로 배송 정보 조회
    DelivVo getDeliveryByOrderId(int orderId);  
}

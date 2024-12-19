package kr.or.ddit.order.dao;

import kr.or.ddit.order.vo.DelivVo;

public interface IDelivDao {
    
    // 배송 정보 삽입
    int insertDelivery(DelivVo delivery);
    
    // 회원 번호를 기반으로 가장 최근의 배송 정보 조회
    DelivVo getLatestDelivery(int memNo);
    
    // 주문 번호(orderId)를 기반으로 배송 정보 조회
    DelivVo selectDeliveryByOrderId(int orderId);
}

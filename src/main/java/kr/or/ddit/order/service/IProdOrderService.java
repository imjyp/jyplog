package kr.or.ddit.order.service;

import kr.or.ddit.order.vo.ProdOrderVo;

public interface IProdOrderService {
    // 주문 상품 정보를 삽입하는 메소드
    int insertProdOrder(ProdOrderVo prodOrderVo);

    // 주문 번호로 주문 상품 정보를 조회하는 메소드
    ProdOrderVo getProdOrder(int prodOrderNo);

    // 회원 번호로 가장 최근의 주문 번호를 조회하는 메소드 추가
    int getMostRecentOrderNoByMemNo(int memNo);
}

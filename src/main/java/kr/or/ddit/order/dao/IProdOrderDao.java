package kr.or.ddit.order.dao;

import kr.or.ddit.order.vo.ProdOrderVo;

public interface IProdOrderDao {
    // 주문 상품 정보를 삽입하는 메소드
    int insertProdOrder(ProdOrderVo prodOrderVo);

    // 주문 상품 번호로 주문 상품 정보를 조회하는 메소드
    ProdOrderVo selectProdOrder(int prodOrderNo);

    // 회원번호로 가장 최근의 주문번호를 조회하는 메소드
    int selectMostRecentOrderNoByMemNo(int memNo);
}

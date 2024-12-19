package kr.or.ddit.order.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ProdOrderVo {
    private int prodOrderNo;    // 주문 상품 번호 (기본 키)
    private int orderNo;        // 주문 번호 (외래 키)
    private int memNo;          // 회원 번호 (외래 키)
    private int prodNo;         // 상품 번호
    private int orderCnt;       // 주문 수량
    private int orderPrice;     // 주문 가격
    private Date orderDate = new Date();   // 주문 날짜 (문자열로 처리)
    private String orderStatus = "주문완료"; // 주문 상태
}



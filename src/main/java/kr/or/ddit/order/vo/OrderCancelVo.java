package kr.or.ddit.order.vo;

import lombok.Data;

@Data
public class OrderCancelVo {
    private int order_no;        // 주문 번호
    private String cancel_date;  // 취소 일자
    private double cancel_amount; // 취소 금액
}

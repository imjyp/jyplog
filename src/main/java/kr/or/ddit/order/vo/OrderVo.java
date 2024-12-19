package kr.or.ddit.order.vo;

import lombok.Data;

@Data
public class OrderVo {
	private int order_no; // 주문 번호
	private int deliv_no; // 배송 번호
	private int mem_no; // 회원 번호
	private int order_price; // 주문 가격
	private String order_date; // 주문 일자
	private String order_stat; // 주문 상태
	private int total_price; // 총 금액
}

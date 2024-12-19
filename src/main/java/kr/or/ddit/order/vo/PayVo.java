package kr.or.ddit.order.vo;

import java.util.Date;
import lombok.Data;

@Data
public class PayVo {
	private int payNo; // 결제 번호 (기본 키)
	private int orderNo; // 주문 번호 (외래 키)
	private String payDate; // 결제 날짜
	private double payPrice; // 결제 금액
}

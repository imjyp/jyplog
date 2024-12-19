package kr.or.ddit.order.vo;

import lombok.Data;
import java.util.Date;

@Data
public class OrderDetailVo {
    private int PROD_ORDER_NO;     // 주문 상품 번호
    private int ORDER_NO;          // 주문 번호
    private int MEM_NO;            // 회원 번호
    private int PROD_NO;           // 상품 번호
    private int ORDER_CNT;         // 주문 수량
    private int ORDER_PRICE;       // 주문 가격
    private Date ORDER_DATE;       // 주문 일자 (Date 타입으로 변경)
    private String ORDER_STATUS;   // 주문 상태
    private String PROD_NAME;      // 상품 이름
    private String PATH;           // 상품 이미지 경로
    private String ORDER_STAT;     // 주문 상태 (추가)
}

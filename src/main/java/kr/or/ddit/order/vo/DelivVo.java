package kr.or.ddit.order.vo;

import lombok.Data;

@Data
public class DelivVo {
    private Integer deliv_no;   // 배송 번호 (자동 증가 값), Integer로 변경
    private String base_addr;
    private String detail_addr;
    private String deliv_name;
    private String request_note;
    private String recipient;
    private String phone;
    private int mem_no;
}

package kr.or.ddit.prod.vo;

import lombok.Data;

@Data
public class ProdOptionVo {
	private int prod_option_no;
	private int prod_no;
	private String prod_option_detail;
	private int prod_option_price;
	private String prod_color;
	private int add_prod_price;
	private String add_prod_option;

}

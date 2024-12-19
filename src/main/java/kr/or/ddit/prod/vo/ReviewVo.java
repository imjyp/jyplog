package kr.or.ddit.prod.vo;

import lombok.Data;

@Data
public class ReviewVo {
	 private int review_no;
	 private int prod_no;
	 private int rating;
	 private String content;
	 private String date_of_pre;
	 private int mem_no;
	 private String mem_nick;
}

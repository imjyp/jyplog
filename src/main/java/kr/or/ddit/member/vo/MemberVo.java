package kr.or.ddit.member.vo;

import lombok.Data;

@Data
public class MemberVo {
	private int mem_no;
	private String mem_name;
	private String mem_id;
	private String mem_pw;
	private String email;
	private String phone;
	private String mem_nick;
	private int del_yn;
	private String reg_date;
	private int mem_type;
	private int follower_cnt;
	private int following_cnt;
	
}

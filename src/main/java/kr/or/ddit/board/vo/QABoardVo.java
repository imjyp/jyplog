package kr.or.ddit.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class QABoardVo {
	// ANSWER_BOARD 컬럼
	private int answer_no;
	private int admin_no;
	private int question_no;
	private String title;
	private String content;
	private String date_of_pre;
	private int view_count;

	// QUESTION_BOARD 중 안겹치는 컬럼
	private int mem_no;

	private String mem_id;
	// 조인되어 AS 해논 컬럼
	private String question_title;

	private Date question_date;

	private Date answer_date;

	private String question_content;

	private String answer_title;

	private String answer_content;

	private String admin_nick;

	private String del_yn;

}

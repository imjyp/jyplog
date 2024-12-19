package kr.or.ddit.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AnswerVo {
	 private int answer_no;
	 private int admin_no;
	 private int question_no;
	 private String title;
	 private Date date_of_pre;
	 private int view_count;
		
	 private String answer_content;
}

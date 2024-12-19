package kr.or.ddit.file;

import lombok.Data;

@Data
public class AnswerBoardFileVo {
	 private int answer_no;
	 private int admin_no;
	 private int question_no;
	 private String title;
	 private String content;
	 private String date_of_pre;
	 private int view_count;
}

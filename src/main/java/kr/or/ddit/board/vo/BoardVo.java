package kr.or.ddit.board.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVo {
	private int board_no;
	private int mem_no; 
	private String title;
	private String content;
	private Date date_of_pre;
	private int board_cnt;
	private int boardcode_no;
	private int admin_no;
	private String del_yn;
    private List<String> images; // 이미지 경로 리스트 추가
    private int board_img_no;
    private String img_date;
    private String img_size;
    private String path;
    private String writer;
    private String boardcode_name;
    private String detail;
    private String imgpath;
    
    public String getWriter() {
        if (writer == null || writer.isEmpty()) {
            return "관리자";
        }
        return writer;
    }
    
}
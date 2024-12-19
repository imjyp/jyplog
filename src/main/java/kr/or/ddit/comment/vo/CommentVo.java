package kr.or.ddit.comment.vo;

import lombok.Data;

@Data
public class CommentVo {
    private int comment_no;
    private int board_no;
    private int mem_no;
    private String content;
    private String mem_nick;  // 댓글 작성자의 닉네임을 저장할 필드 추가
}

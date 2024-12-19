package kr.or.ddit.comment.service;

import java.util.List;

import kr.or.ddit.comment.vo.CommentVo;

public interface ICommentService {

	// 댓글 추가
	int insertComment(CommentVo commentVo);

    // 게시글에 해당하는 댓글 조회
    List<CommentVo> getCommentsByBoardNo(int boardNo);
}

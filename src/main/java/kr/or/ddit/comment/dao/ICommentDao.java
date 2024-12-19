package kr.or.ddit.comment.dao;

import java.util.List;

import kr.or.ddit.comment.vo.CommentVo;

public interface ICommentDao {

	int insertComment(CommentVo commentVo);
	
	// 게시글에 해당하는 댓글 목록 조회
    List<CommentVo> selectCommentsByBoardNo(int boardNo);
    
}

package kr.or.ddit.comment.service;

import java.util.List;

import kr.or.ddit.comment.dao.CommentDaoImpl;
import kr.or.ddit.comment.dao.ICommentDao;
import kr.or.ddit.comment.vo.CommentVo;
import kr.or.ddit.mybatis.MyBatisDao;

public class CommentServiceImpl extends MyBatisDao implements ICommentService {

    ICommentDao commentDao = CommentDaoImpl.getInstance();
    private static CommentServiceImpl instance;

    private CommentServiceImpl() {
    }

    public static CommentServiceImpl getInstance() {
        if (instance == null) {
            instance = new CommentServiceImpl();
        }
        return instance;
    }

    

    @Override
    public List<CommentVo> getCommentsByBoardNo(int boardNo) {
        // 댓글 목록 조회
        List<CommentVo> comments = commentDao.selectCommentsByBoardNo(boardNo);
        
        // 각 댓글의 닉네임을 로그로 출력
        for (CommentVo comment : comments) {
            System.out.println("Comment Nickname: " + comment.getMem_nick()); // 여기에 추가
        }
        
        return comments;
    }

	@Override
	public int insertComment(CommentVo commentVo) {
		return commentDao.insertComment(commentVo);
	}
}

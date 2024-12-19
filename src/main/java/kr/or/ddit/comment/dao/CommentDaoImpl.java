package kr.or.ddit.comment.dao;

import java.util.List;
import kr.or.ddit.comment.vo.CommentVo;
import kr.or.ddit.mybatis.MyBatisDao;

public class CommentDaoImpl extends MyBatisDao implements ICommentDao {

    private static CommentDaoImpl instance;

    private CommentDaoImpl() {
    }

    public static CommentDaoImpl getInstance() {
        if (instance == null) {
            instance = new CommentDaoImpl();
        }
        return instance;
    }

    @Override
    public int insertComment(CommentVo comment) {
        return insert("comment.insertComment", comment);
    }

    @Override
    public List<CommentVo> selectCommentsByBoardNo(int boardNo) {
        // MyBatis 매퍼를 통해 댓글 목록을 가져오는 메소드
        return selectList("comment.selectCommentsByBoardNo", boardNo);
    }
}

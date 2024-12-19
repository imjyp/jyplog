package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.mybatis.MyBatisDao;

public class BoardDaoImpl extends MyBatisDao implements BoardDao {

	private static BoardDaoImpl instance;

	private BoardDaoImpl() {

	}

	public static BoardDaoImpl getInstance() {
		if (instance == null) {
			instance = new BoardDaoImpl();
		}
		return instance;
	}

	
	@Override
	public List<BoardVo> cateList() {
		return selectList("board.cateList");
	}

	@Override
	public List<BoardVo> boardList(int boardcode_no) {
		return selectList("board.boardList",boardcode_no);
	}

	@Override
	public int PostAdd(BoardVo boardVo) {
		return insert("board.PostAdd",boardVo);
	}

	@Override
	public List<BoardVo> boardCnt() {
		return selectOne("board.boardCnt");
	}

	@Override
	public BoardVo boardDetail(int board_no) {
		return selectOne("board.boardDetail",board_no);
	}


	@Override
	public void savePostImage(Map<String, Object> paramMap) {
		insert("board.savePostImage" ,paramMap);
	}

	@Override
	public List<String> boardImgpath(int board_no) {
		return selectList("board.boardImgpath",board_no);
	}

	@Override
	public int updateBoardClickCount(int board_no) {
		return update("board.updateBoardClickCount",(board_no));
	}

	@Override
	public int updatePost(BoardVo post) {
		return update("board.updatePost",post);
	}

	@Override
	public int deletePost(int board_no) {
		return update("board.deletePost",board_no);
	}

	@Override
	public List<BoardVo> boardListSortedByCount(int boardcode_no) {
		return selectList("board.boardListSortedByCount",boardcode_no);
	}

	

}

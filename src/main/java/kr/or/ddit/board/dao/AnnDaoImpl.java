package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.board.mybatis.MyBatisDao;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.file.AnswerBoardFileVo;

public class AnnDaoImpl extends MyBatisDao implements IAnnDao {

	private static AnnDaoImpl instance;

	private AnnDaoImpl() {

	}

	public static AnnDaoImpl getInstance() {
		if (instance == null) {
			instance = new AnnDaoImpl();
		}
		return instance;
	}
	
	/**
	 *  공지사항, 피드 카테고리 리스트
	 */
	@Override
	public List<BoardVo> aCateList() {
		return selectList("ann.aCateList");
	}
	
	/**
	 * 공지사항 게시판 리스트 
	 */
	@Override
	public List<BoardVo> aList(int boardcode_no) {
		return selectList("ann.aList", boardcode_no);
	}
	
	/**
	 *  공지사항 게시물
	 */
	@Override
	public BoardVo aDetail(int board_no) {
		return selectOne("ann.aDetail", board_no);
	}

	@Override
	public int insertNotice(BoardVo board) {
		// TODO Auto-generated method stub
		return insert("ann.insertNotice", board);
	}

	@Override
	public int updateNotice(BoardVo board) {
		// TODO Auto-generated method stub
		return update("ann.updateNotice", board);
	}

	@Override
	public int deleteNotice(int board_no) {
		// TODO Auto-generated method stub
		return update("ann.deleteNotice", board_no);
	}


	
	



}

package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.dao.AnnDaoImpl;
import kr.or.ddit.board.dao.IAnnDao;
import kr.or.ddit.board.mybatis.MyBatisDao;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.file.AnswerBoardFileVo;

public class AnnServiceImpl implements IAnnService {

	private static AnnServiceImpl instance;

	private AnnServiceImpl() {

	}

	public static AnnServiceImpl getInstance() {
		if (instance == null) {
			instance = new AnnServiceImpl();
		}
		return instance;
	}

	IAnnDao iAnnDao = AnnDaoImpl.getInstance();
	
	
	/**
	 *  공지사항, 피드 카테고리 리스트
	 */
	@Override
	public List<BoardVo> aCateList() {
		return iAnnDao.aCateList();
	}

	/**
	 *  공지사항 게시판 리스트
	 */
	@Override
	public List<BoardVo> aList(int boardcode_no) {
		return iAnnDao.aList(boardcode_no);
	}

	/**
	 *  공지사항 게시물
	 */
	@Override
	public BoardVo aDetail(int board_no) {
		return iAnnDao.aDetail(board_no);
	}

	@Override
	public int insertNotice(BoardVo board) {
		// TODO Auto-generated method stub
		return iAnnDao.insertNotice(board);
	}

	@Override
	public int updateNotice(BoardVo board) {
		// TODO Auto-generated method stub
		return iAnnDao.updateNotice(board);
	}

	@Override
	public int deleteNotice(int board_no) {
		// TODO Auto-generated method stub
		return iAnnDao.deleteNotice(board_no);
	}



}

package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.file.AnswerBoardFileVo;

public interface IAnnDao {
	/**
	 * 공지사항 카테고리 리스트
	 * 
	 * @return
	 */
	public List<BoardVo> aCateList();

	/**
	 * 공지사항 게시판 리스트
	 * 
	 * @param boardcode_no
	 * @return
	 */
	public List<BoardVo> aList(int boardcode_no);

	public BoardVo aDetail(int board_no);

	public int insertNotice(BoardVo board);

	public int updateNotice(BoardVo board);

	public int deleteNotice(int board_no);

}

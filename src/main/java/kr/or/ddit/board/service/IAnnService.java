package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.file.AnswerBoardFileVo;

public interface IAnnService {
	// 공지사항 카테고리 리스트
	public List<BoardVo> aCateList();

	// 공지사항 게시판 리스트
	public List<BoardVo> aList(int boardcode_no);

	// 공지사항 게시물
	public BoardVo aDetail(int board_no);

	public int insertNotice(BoardVo board);

	public int updateNotice(BoardVo board);

	public int deleteNotice(int board_no);

}

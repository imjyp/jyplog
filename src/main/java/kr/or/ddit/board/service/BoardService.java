package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;

public interface BoardService {
	
	public List<BoardVo> cateList();

	public List<BoardVo> boardList(int boardcode_no);
	
	public int PostAdd(BoardVo boardVo);
	public List<BoardVo>boardCnt();
	public BoardVo boardDetail(int board_no);



	public void savePostImage(int board_no, String fileName);

	public List<String>boardImgpath(int board_no);
	
	public int updateBoardClickCount(int board_no);
	public int updatePost(BoardVo post) ;
	public int deletePost(int board_no);
	public List<BoardVo> boardListSortedByCount(int boardcode_no); 
}

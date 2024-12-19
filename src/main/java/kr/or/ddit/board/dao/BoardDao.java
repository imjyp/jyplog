package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVo;

public interface BoardDao {
	
	public List<BoardVo> cateList();

	public List<BoardVo> boardList(int boardcode_no);
	public int PostAdd(BoardVo boardVo);
	
	public List<BoardVo>boardCnt();
	public BoardVo boardDetail(int board_no);

	public void savePostImage(Map<String, Object> paramMap);
	
	public List<String> boardImgpath(int board_no);
	
	public int updateBoardClickCount(int board_no);
	
	public int updatePost(BoardVo post);
	public int deletePost(int board_no);
	public List<BoardVo> boardListSortedByCount(int boardcode_no);
	

}

package kr.or.ddit.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.dao.BoardDao;
import kr.or.ddit.board.dao.BoardDaoImpl;
import kr.or.ddit.board.vo.BoardVo;

public class BoardServiceImpl implements BoardService {
	private static BoardServiceImpl instance;

	private BoardServiceImpl() {

	}

	public static BoardServiceImpl getInstance() {
		if (instance == null) {
			instance = new BoardServiceImpl();
		}
		return instance;
	}

	private BoardDao boardDao = BoardDaoImpl.getInstance();

	@Override
	public List<BoardVo> cateList() {
		// TODO Auto-generated method stub
		return boardDao.cateList();
	}

	@Override
	public List<BoardVo> boardList(int boardcode_no) {
		return boardDao.boardList(boardcode_no);
	}

	@Override
	public int PostAdd(BoardVo boardVo) {
		int result = boardDao.PostAdd(boardVo);
		return boardVo.getBoard_no();

	}

	@Override
	public List<BoardVo> boardCnt() {
		// TODO Auto-generated method stub
		return boardDao.boardCnt();
	}

	@Override
	public BoardVo boardDetail(int board_no) {
		// TODO Auto-generated method stub
		return boardDao.boardDetail(board_no);
	}

	@Override
	public void savePostImage(int board_no, String fileName) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("board_no", board_no); // 게시글 번호
		paramMap.put("path", fileName); // 이미지 경로
		boardDao.savePostImage(paramMap); // DAO 호출

	}

	@Override
	public List<String> boardImgpath(int board_no) {
		// TODO Auto-generated method stub
		return boardDao.boardImgpath(board_no);
	}

	@Override
	public int updateBoardClickCount(int board_no) {
		return boardDao.updateBoardClickCount(board_no);
	}


	@Override
	public int updatePost(BoardVo post) {
		return boardDao.updatePost(post);
	}

	@Override
	public int deletePost(int board_no) {
		return boardDao.deletePost(board_no);
	}

	@Override
	public List<BoardVo> boardListSortedByCount(int boardcode_no) {
		return boardDao.boardListSortedByCount(boardcode_no);
	}


	
	
}

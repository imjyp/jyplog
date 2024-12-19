package kr.or.ddit.board.service;

import kr.or.ddit.board.dao.AnswerBoardDaoImpl;
import kr.or.ddit.board.dao.IAnswerBoardDao;
import kr.or.ddit.board.vo.AnswerVo;

public class AnswerBoardServiceImpl implements IAnswerBoardService {

	private static AnswerBoardServiceImpl instance;

	private AnswerBoardServiceImpl() {

	}

	public static AnswerBoardServiceImpl getInstance() {
		if (instance == null) {
			instance = new AnswerBoardServiceImpl();
		}
		return instance;
	}

	IAnswerBoardDao iAnswerBoardDao = AnswerBoardDaoImpl.getInstance();
	
	@Override
	public AnswerVo getAnswerByQuestionNo(int questionNo) {
		return iAnswerBoardDao.getAnswerByQuestionNo(questionNo);
	}

	@Override
	public int insertAnswer(AnswerVo answer) {
		return iAnswerBoardDao.insertAnswer(answer);
	}

	@Override
	public int updateAnswer(AnswerVo answer) {
		return iAnswerBoardDao.updateAnswer(answer) ;
	}

}

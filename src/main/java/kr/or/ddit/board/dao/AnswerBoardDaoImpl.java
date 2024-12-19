package kr.or.ddit.board.dao;

import kr.or.ddit.board.mybatis.MyBatisDao;
import kr.or.ddit.board.vo.AnswerVo;

public class AnswerBoardDaoImpl extends MyBatisDao implements IAnswerBoardDao{

	private static AnswerBoardDaoImpl instance;

	private AnswerBoardDaoImpl() {

	}

	public static AnswerBoardDaoImpl getInstance() {
		if (instance == null) {
			instance = new AnswerBoardDaoImpl();
		}
		return instance;
	}

	
	
	@Override
	public AnswerVo getAnswerByQuestionNo(int questionNo) {
		return selectOne("answerboard.getAnswerByQuestionNo", questionNo);
	}

	@Override
	public int insertAnswer(AnswerVo answer) {
		return insert("answerboard.insertAnswer", answer);
	}

	@Override
	public int updateAnswer(AnswerVo answer) {
		return update("answerboard.updateAnswer", answer);
	}
	

}

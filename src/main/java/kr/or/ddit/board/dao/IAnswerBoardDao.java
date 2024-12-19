package kr.or.ddit.board.dao;

import kr.or.ddit.board.vo.AnswerVo;

public interface IAnswerBoardDao {
	 AnswerVo getAnswerByQuestionNo(int questionNo);
	    int insertAnswer(AnswerVo answer);
	    int updateAnswer(AnswerVo answer);
}

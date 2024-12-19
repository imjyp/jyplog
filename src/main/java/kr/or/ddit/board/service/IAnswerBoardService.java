package kr.or.ddit.board.service;

import kr.or.ddit.board.vo.AnswerVo;

public interface IAnswerBoardService {
	public AnswerVo getAnswerByQuestionNo(int questionNo);
	int insertAnswer(AnswerVo answer);
	int updateAnswer(AnswerVo answer);
	
}

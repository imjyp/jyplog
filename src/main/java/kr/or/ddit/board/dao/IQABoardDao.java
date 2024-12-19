package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.board.vo.QABoardVo;

public interface IQABoardDao {

	public List<QABoardVo> getAllQuestions();
	
	public List<QABoardVo> boardList(int question_no);

	public int insertQuestion(QABoardVo question);
	
	public QABoardVo getQuestionById(int questionNo);

	public int deleteQuestion(int questionNo);

	public int updateQuestion(QABoardVo question);
	



}

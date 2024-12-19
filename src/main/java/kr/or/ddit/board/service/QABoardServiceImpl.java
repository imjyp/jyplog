package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.dao.IQABoardDao;
import kr.or.ddit.board.dao.QABoardDaoImpl;
import kr.or.ddit.board.vo.QABoardVo;

public class QABoardServiceImpl implements IQABoardService {
	
	private static QABoardServiceImpl instance;

	private QABoardServiceImpl() {

	}

	public static QABoardServiceImpl getInstance() {
		if (instance == null) {
			instance = new QABoardServiceImpl();
		}
		return instance;
	}

	IQABoardDao iQABoardDao = QABoardDaoImpl.getInstance();
	

	
	@Override
	public List<QABoardVo> boardList(int question_no) {
		return iQABoardDao.boardList(question_no);
	}

	@Override
	public List<QABoardVo> getAllQuestions() {
		return iQABoardDao.getAllQuestions();
	}

	@Override
	public int insertQuestion(QABoardVo question) {
		return iQABoardDao.insertQuestion(question);
	}

	    @Override
	    public QABoardVo getQuestionById(int questionNo) {
	        return iQABoardDao.getQuestionById(questionNo);
	    }


	@Override
	public int deleteQuestion(int questionNo) {
		return iQABoardDao.deleteQuestion(questionNo);
	}

	@Override
	public int updateQuestion(QABoardVo question) {
		return iQABoardDao.updateQuestion(question);
	}



}

package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.board.mybatis.MyBatisDao;
import kr.or.ddit.board.vo.QABoardVo;

public class QABoardDaoImpl extends MyBatisDao implements IQABoardDao {

	private static QABoardDaoImpl instance;

	private QABoardDaoImpl() {

	}

	public static QABoardDaoImpl getInstance() {
		if (instance == null) {
			instance = new QABoardDaoImpl();
		}
		return instance;
	}

	
	@Override
	public List<QABoardVo> getAllQuestions() {
		return selectList("qaboard.getAllQuestions");
	}
	
	@Override
	public List<QABoardVo> boardList(int question_no) {
		return selectList("qaboard.boardList", question_no);
	}

	@Override
	public int insertQuestion(QABoardVo question) {
		return insert("qaboard.insertQuestion", question);
	}

	@Override
    public QABoardVo getQuestionById(int questionNo) {
        return selectOne("qaboard.getQuestionById", questionNo);
    }

	@Override
	public int deleteQuestion(int questionNo) {
		return update("qaboard.deleteQuestion", questionNo);
	}

	@Override
	public int updateQuestion(QABoardVo question) {
		return update("qaboard.updateQuestion", question);
	}







}


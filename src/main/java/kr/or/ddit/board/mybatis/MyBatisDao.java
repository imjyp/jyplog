package kr.or.ddit.board.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

public class MyBatisDao {
	
	public <T> List<T> selectList(String statement, Object parameter){
		SqlSession session = MybatisUtil.getInstance(true);
		List<T> list = null;
		try {
			list = session.selectList(statement, parameter);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}
	
	public <T> List<T> selectList(String statement){
		SqlSession session = MybatisUtil.getInstance(true);
		List<T> list = null;
		try {
			list = session.selectList(statement);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}
	
	public <T> T selectOne(String statement, Object parameter){
		SqlSession session = MybatisUtil.getInstance(true);
		T obj = null;
		try {
			obj = session.selectOne(statement, parameter);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return obj;
	}
	
	public <T> T selectOne(String statement){
		SqlSession session = MybatisUtil.getInstance(true);
		T obj = null;
		try {
			obj = session.selectOne(statement);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return obj;
	}
	
	public int update(String statement, Object parameter) {
		int cnt = 0; 
		SqlSession session = MybatisUtil.getInstance();
		try {
			cnt = session.update(statement, parameter);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		return cnt;
	}
	
	public int update(String statement) {
		int cnt = 0; 
		SqlSession session = MybatisUtil.getInstance();
		try {
			cnt = session.update(statement);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		return cnt;
	}
	
	public int insert(String statement, Object parameter) {
		int cnt = 0; 
		SqlSession session = MybatisUtil.getInstance();
		try {
			cnt = session.insert(statement, parameter);
			session.commit();
		}catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		return cnt;
	}
	
	public int insert(String statement) {
		int cnt = 0; 
		SqlSession session = MybatisUtil.getInstance();
		try {
			cnt = session.insert(statement);
			session.commit();
		}catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		return cnt;
	}
	
	public int delete(String statement, Object parameter) {
		int cnt = 0; 
		SqlSession session = MybatisUtil.getInstance();
		try {
			cnt = session.delete(statement, parameter );
			session.commit();
		}catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		return cnt;
	}
	
	public int delete(String statement) {
		int cnt = 0; 
		SqlSession session = MybatisUtil.getInstance();
		try {
			cnt = session.delete(statement);
			session.commit();
		}catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		return cnt;
	}
	
	
	
	
	
	
}

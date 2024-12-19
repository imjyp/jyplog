package kr.or.ddit.mybatis;

import java.io.Reader;
import java.nio.charset.Charset;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {
	
	private static SqlSessionFactory sessionFactory;
	
	static {
		try {
			// 1-1 설정 파일 읽어오기
			
			// 한글 처리
			Charset charSet = Charset.forName("UTF-8");
			Resources.setCharset(charSet);
			
			Reader rd = Resources.getResourceAsReader("config/mybatis-config.xml");
			
			// 1-2 위에서 생성한 Reader 객체를 사용하여 sqlSessionFactory 객체 생성하기
			sessionFactory = new SqlSessionFactoryBuilder().build(rd);
			
			// 1-3 다 사용한 Read 객체 반납
			rd.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * SqlSession 객체를 제공하는 팩토리 메소드
	 * @return SqlSession 객체
	 */
	public static SqlSessionFactory getSqlSessionFactory() {
        return sessionFactory;
    }
	public static SqlSession getInstance() {
		// 기본 값은 autocommit : false
		return sessionFactory.openSession();
	}
	
	/**
	 * SqlSession 객체를 제공하는 팩토리 메소드
	 * @param autoCommit 오토커밋 여부
	 * @return SqlSession 객체
	 */
	public static SqlSession getInstance(boolean autoCommit) {
		return sessionFactory.openSession(autoCommit);
	}
	
	
	
	
	
}

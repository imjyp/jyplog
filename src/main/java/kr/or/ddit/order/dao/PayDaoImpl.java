package kr.or.ddit.order.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.mybatis.MybatisUtil;
import kr.or.ddit.order.vo.PayVo;

public class PayDaoImpl implements IPayDao {

    private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

    private static IPayDao instance;

    private PayDaoImpl() {
    }

    public static IPayDao getInstance() {
        if (instance == null) {
            instance = new PayDaoImpl();
        }
        return instance;
    }

    @Override
    public int insertPay(PayVo payVo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            int rows = session.insert("PayMapper.insertPay", payVo);
            session.commit();
            return rows;
        }
    }

    @Override
    public PayVo selectPay(int orderNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("PayMapper.selectPay", orderNo);
        }
    }
}

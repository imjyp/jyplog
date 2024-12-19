package kr.or.ddit.order.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.mybatis.MybatisUtil;
import kr.or.ddit.order.vo.ProdOrderVo;

public class ProdOrderDaoImpl implements IProdOrderDao {

    private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

    private static IProdOrderDao instance;

    private ProdOrderDaoImpl() {
    }

    public static IProdOrderDao getInstance() {
        if (instance == null) {
            instance = new ProdOrderDaoImpl();
        }
        return instance;
    }

    @Override
    public int insertProdOrder(ProdOrderVo prodOrderVo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            int rows = session.insert("ProdOrderMapper.insertProdOrder", prodOrderVo);
            session.commit();
            return rows;
        }
    }

    @Override
    public ProdOrderVo selectProdOrder(int prodOrderNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("ProdOrderMapper.selectProdOrder", prodOrderNo);
        }
    }

    // 회원번호(memNo)로 가장 최근의 주문번호를 조회하는 메서드 추가
    @Override
    public int selectMostRecentOrderNoByMemNo(int memNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("ProdOrderMapper.selectMostRecentOrderNoByMemNo", memNo);
        }
    }
}

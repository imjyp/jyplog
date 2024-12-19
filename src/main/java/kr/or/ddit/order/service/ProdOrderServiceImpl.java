package kr.or.ddit.order.service;

import kr.or.ddit.order.dao.IProdOrderDao;
import kr.or.ddit.order.dao.ProdOrderDaoImpl;
import kr.or.ddit.order.vo.ProdOrderVo;

public class ProdOrderServiceImpl implements IProdOrderService {

    private IProdOrderDao prodOrderDao = ProdOrderDaoImpl.getInstance();  // DAO 인스턴스 가져오기

    private static IProdOrderService instance;

    private ProdOrderServiceImpl() {
    }

    public static IProdOrderService getInstance() {
        if (instance == null) {
            instance = new ProdOrderServiceImpl();
        }
        return instance;
    }

    @Override
    public int insertProdOrder(ProdOrderVo prodOrderVo) {
        // 주문 상품 정보를 삽입하는 비즈니스 로직 처리
        System.out.println("ProdOrder 등록 중: " + prodOrderVo);
        return prodOrderDao.insertProdOrder(prodOrderVo);
    }

    @Override
    public ProdOrderVo getProdOrder(int prodOrderNo) {
        // 주문 상품 정보를 조회하는 비즈니스 로직 처리
        return prodOrderDao.selectProdOrder(prodOrderNo);
    }

    @Override
    public int getMostRecentOrderNoByMemNo(int memNo) {
        // 회원번호로 가장 최근의 주문번호를 가져오는 비즈니스 로직
        System.out.println("가장 최근의 주문번호 조회 중 - 회원번호: " + memNo);
        return prodOrderDao.selectMostRecentOrderNoByMemNo(memNo);
    }
}

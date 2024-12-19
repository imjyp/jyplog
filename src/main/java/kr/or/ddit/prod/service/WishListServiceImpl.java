package kr.or.ddit.prod.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.order.vo.OrderVo;
import kr.or.ddit.prod.dao.IWishListDao;
import kr.or.ddit.prod.dao.WishListDaoImpl;
import kr.or.ddit.prod.mybatissssssssssssss.MyBatisDao;
import kr.or.ddit.prod.vo.WishListVo;

public class WishListServiceImpl extends MyBatisDao implements IWishListService {

	private static WishListServiceImpl instance;

	private WishListServiceImpl() {

	}

	public static WishListServiceImpl getInstance() {
		if (instance == null) {
			instance = new WishListServiceImpl();
		}
		return instance;
	}

	IWishListDao wishListDao = WishListDaoImpl.getInstance();
	

	@Override
	public List<WishListVo> getWishList(WishListVo wishListVo) {
		return wishListDao.getWishList(wishListVo);
	}

	@Override
	public List<Integer> getWishListProdNos(int mem_no) {
		return wishListDao.getWishListProdNos(mem_no);
	}

	@Override
	public int addWishList(WishListVo wishListVo) {
		return wishListDao.addWishList(wishListVo);
	}

	@Override
	public boolean isWishListExist(WishListVo wishListVo) {
		return wishListDao.isWishListExist(wishListVo);
	}

	@Override
	public int updateWishListStateToAdd(WishListVo wishListVo) {
		return wishListDao.updateWishListStateToAdd(wishListVo);
	}

	@Override
	public int updateWishListStateToRemove(WishListVo wishListVo) {
		return wishListDao.updateWishListStateToRemove(wishListVo);
	}

	@Override
	public void addOrUpdateWishList(WishListVo wishListVo) {
		if (isWishListExist(wishListVo)) {
			// 위시리스트에 이미 존재하는 경우 상태를 2로 변경
			updateWishListStateToAdd(wishListVo);
		} else {
			// 존재하지 않는 경우 새로 추가
			addWishList(wishListVo);
		}

	}

	@Override
	public int deleteWishList(WishListVo wishListVo) {
		return wishListDao.deleteWishList(wishListVo);
	}

	@Override
	public int removeSelectedWishItems(int memNo, List<Integer> prodNos) {
		Map<String, Object> params = new HashMap<>();
		params.put("mem_no", memNo);
		params.put("prodNos", prodNos);

		return wishListDao.removeSelectedWishItems(params);
	}


}

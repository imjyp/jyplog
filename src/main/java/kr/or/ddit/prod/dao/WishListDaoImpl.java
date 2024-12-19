package kr.or.ddit.prod.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.prod.mybatissssssssssssss.MyBatisDao;
import kr.or.ddit.prod.vo.WishListVo;

public class WishListDaoImpl extends MyBatisDao implements IWishListDao{
	
	private static WishListDaoImpl instance;

	private WishListDaoImpl() {

	}

	public static WishListDaoImpl getInstance() {
		if (instance == null) {
			instance = new WishListDaoImpl();
		}
		return instance;
	}

	

	@Override
	public List<WishListVo> getWishList(WishListVo wishListVo) {
		return selectList("wishlist.getWishList", wishListVo);
	}
	
	@Override
	public List<Integer> getWishListProdNos(int mem_no) {
		return selectList("wishlist.getWishListProdNos", mem_no);
	}

	@Override
	public int addWishList(WishListVo wishListVo) {
		return insert("wishlist.addWishList", wishListVo);
	}

	
	@Override
	public boolean isWishListExist(WishListVo wishListVo) {
		WishListVo result = selectOne("wishlist.isWishListExist", wishListVo);
        return result != null;
	}

	@Override
	public int updateWishListStateToAdd(WishListVo wishListVo) {
		return update("wishlist.updateWishListStateToAdd", wishListVo);
	}
	
	
	@Override
	public int updateWishListStateToRemove(WishListVo wishListVo) {
		return update("wishlist.updateWishListStateToRemove", wishListVo);
	}

	@Override
	public void addOrUpdateWishList(WishListVo wishListVo) {
		
	}

	@Override
	public int deleteWishList(WishListVo wishListVo) {
		return delete("wishlist.deleteWishList", wishListVo);
	}

	@Override
	public int removeSelectedWishItems(Map<String, Object> params) {
		return update("wishlist.removeSelectedWishItems", params);
	}

	@Override
	public int buySelectedItems(List<WishListVo> selectedItems) {
        int totalInserted = 0;
        for (WishListVo item : selectedItems) {
            int memNo = item.getMem_no();
            int prodNo = item.getProd_no();
//            int quantity = item.
//            int totalPrice = item.getProd_price() * quantity;

            // 주문 추가
//            totalInserted += insert("order.insertOrder", OrderVo); // 주문 추가
        }
        return totalInserted;
    }
    }

package kr.or.ddit.prod.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.prod.vo.WishListVo;

public interface IWishListDao {
	
	/**
	 * 위시리스트 조회
	 * @param wishListVo
	 * @return
	 */
	public List<WishListVo> getWishList(WishListVo wishListVo);
	
	/**
	 * 한사람의 위시리스트만 조회
	 * @param mem_no
	 * @return
	 */
	public List<Integer> getWishListProdNos(int mem_no);
	
	/**
     * 위시리스트에 항목 추가
     * @param wishListVo - 추가할 위시리스트 정보
     * @return state = 2
     */
    public int addWishList(WishListVo wishListVo);
    /**
     * 위시리스트에 항목 추가
     * @param wishListVo
     * @return
     */
    public int updateWishListStateToAdd(WishListVo wishListVo);
    
    /**
     * 위시리스트에서 항목 삭제
     * @param wishListVo - 삭제할 항목의 사용자 번호와 상품 번호
     * @return state = 1
     */
    public int updateWishListStateToRemove(WishListVo wishListVo);
    
    
    /**
     * 특정 회원의 특정 상품이 위시리스트에 존재하는지 확인
     * @param wishListVo - 사용자 번호와 상품 번호
     * @return 위시리스트 항목 존재 여부
     */
    public boolean isWishListExist(WishListVo wishListVo);
    
    /**
     * 
     * @param wishListVo
     */
    public void addOrUpdateWishList(WishListVo wishListVo);
    
    
    /**
     * 위시리스트에서 선택한 항목 삭제
     * @param wishListVo
     * @return
     */
    public int deleteWishList(WishListVo wishListVo);
    
    /**
     * 위시리스트에서 선택한 항목 삭제
     * @param wishListVo
     * @return
     */
    public int removeSelectedWishItems(Map<String, Object> params);
    
    /**
     * 위시리스트에서 선택 항목 구매
     * @param selectedItems - 선택된 위시리스트 항목들
     * @return int
     */
    public int buySelectedItems(List<WishListVo> selectedItems);

}

package kr.or.ddit.prod.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.prod.vo.ProdImgVo;
import kr.or.ddit.prod.vo.ProdOptionVo;
import kr.or.ddit.prod.vo.ProdReviewVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.prod.vo.ReviewVo;

public interface IProdDao {
	
	/**
	 * 상품 관리 리스트
	 * @return
	 */
	
	public List<ProdVo> prodManagementList();
	/**
	 * 상품카테고리 리스트
	 * @return
	 */

	public List<ProdVo> prodCateList();
	

	/**
	 * 상품카테고리
	 * @param cate_no
	 * @return
	 */
	public ProdVo prodCate(int cate_no);
	
	
	/**
	 * 상품 리스트
	 * @param prod
	 * @return
	 */
	
	public List<ProdVo> prodList(ProdVo prod_no);
	
	/**
	 * 상품 상세
	 * @param prod_no
	 * @return
	 */
	public ProdVo prodDetail(int prod_no);
	
	/**
	 * 상품 이미지 리스트
	 * @param prod_no
	 * @return
	 */
	public List<ProdImgVo> prodImages(int prod_no);
	
	/**
	 * 상품 옵션
	 * @param prod_no
	 * @return
	 */
	public List<ProdOptionVo> prodOptions(int prod_no);
	
	/**
	 * 상품 리뷰
	 * @param prod_no
	 * @return
	 */
	public List<ProdReviewVo> reviewList(int prod_no);
	
	/**
	 * 추천 상품 조회
	 * @param cate_no
	 * @return
	 */
	public List<ProdVo> recommendedProd(int cate_no);
	
	
	/**
	 * 조회수 
	 * @param prod_no
	 * @return
	 */
	public int getProdClickCount(int prod_no);
	
	
	/**
	 * 상품 클릭시 조회수 증가
	 * @param prod_no
	 */
	public int updateProdClickCount(int prod_no);
	
	/**
	 * 상품 등록
	 * @param prodVo
	 * @return
	 */
	public int insertProd(ProdVo prodVo);
	
	/**
	 * 상품 가격 등록
	 * @param prodVo
	 * @return
	 */
    public int insertPrice(ProdVo prodVo);
    
    /**
     * 상품 이미지 등록
     * @param prodImgVo
     * @return
     */
       
    public int insertProdImage(ProdImgVo prodImgVo);
    
    /**
     * 상품 옵션 등록
     * @param prodOptionVo
     * @return
     */
    public int insertProdOption(ProdOptionVo prodOptionVo);


    /**
     * 리뷰 등록
     * @param review
     * @return
     */
	public int insertReview(ReviewVo review);
	public int updateReview(ReviewVo review);
	public int deleteReview(ReviewVo review);
	
	/**
	 * 상품 업데이트
	 * @param prodVo
	 * @return
	 */
	public int updateProd(ProdVo prodVo);
	
	/**
	 * 상품 가격업데이트
	 * @param prodVo
	 * @return
	 */
	public int updatePrice(ProdVo prodVo);
	
	/**
	 * 상품 옵션삭제
	 * @param prod_no
	 * @return
	 */
	public int deleteProdOptions(int prod_no);
	
	public int deletePrice(int prod_no);
	
	public int deleteProd(int prod_no);
	
	/**
	 * 이미지 삭제
	 * @param prod_no
	 * @return
	 */
	public int deleteProdImages(int prod_no);
	
	/**
	 * 옵션 업데이트
	 * @param prodOptionVo
	 * @return
	 */
	public int updateProdOptions(ProdOptionVo prodOptionVo);
	
	
	/**
	 * 상품 삭제
	 * @param prodNo
	 * @return
	 */
	public int deleteProdCascade(int prodNo);
	
	
	
	
	
	
	
	
	
	
}

package kr.or.ddit.prod.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.prod.vo.ProdImgVo;
import kr.or.ddit.prod.vo.ProdOptionVo;
import kr.or.ddit.prod.vo.ProdReviewVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.prod.vo.ReviewVo;

public interface IProdService {
	

	/**
	 * 상품 관리 리스트
	 * @return
	 */
	
	public List<ProdVo> prodManagementList();
	
	/**
	 * 상품 카테고리 리스트
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
	int insertProd(ProdVo prodVo);
	
	/**
	 * 상품 가격 등록
	 * @param prodVo
	 * @return
	 */
    int insertPrice(ProdVo prodVo);
    
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
    int insertProdOption(ProdOptionVo prodOptionVo);
	
    /**
     * 리뷰 등록
     * @param review
     * @return
     */
    public int insertReview(ReviewVo review);
    
    public int updateReview(ReviewVo review);
    
    public int deleteReview(ReviewVo review);
    
  
    public int updateProd(ProdVo prodVo, List<ProdOptionVo> options, List<ProdImgVo> images);
    
    
    public int deleteProdCascade(int prodNo);
    
    		
    
}

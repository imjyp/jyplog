package kr.or.ddit.prod.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import kr.or.ddit.prod.dao.IProdDao;
import kr.or.ddit.prod.dao.ProdDaoImpl;
import kr.or.ddit.prod.mybatissssssssssssss.MyBatisDao;
import kr.or.ddit.prod.vo.ProdImgVo;
import kr.or.ddit.prod.vo.ProdOptionVo;
import kr.or.ddit.prod.vo.ProdReviewVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.prod.vo.ReviewVo;

public class ProdServiceImpl extends MyBatisDao implements IProdService{
	
	private static ProdServiceImpl instance;

	private ProdServiceImpl() {

	}

	public static ProdServiceImpl getInstance() {
		if (instance == null) {
			instance = new ProdServiceImpl();
		}
		return instance;
	}
	
	private IProdDao prodDao = ProdDaoImpl.getInstance();


	@Override
	public List<ProdVo> prodCateList() {
		return prodDao.prodCateList();
	}

	@Override
	public List<ProdVo> prodList(ProdVo prodVo) {
		return prodDao.prodList(prodVo);
	}

	@Override
	public ProdVo prodDetail(int prod_no) {
		ProdVo prodDetail = prodDao.prodDetail(prod_no); // 상품 기본 정보 조회
	    
	    if (prodDetail == null) {
	        throw new NullPointerException("해당 상품 정보를 찾을 수 없습니다. 상품번호: " + prod_no);
	    }

	    // 상품 이미지 리스트 조회
	    List<ProdImgVo> imageList = prodDao.prodImages(prod_no);
	    if (imageList != null && !imageList.isEmpty()) {
	        // 이미지 경로 리스트 설정
	        List<String> imagePaths = imageList.stream()
	                                           .map(ProdImgVo::getPath)
	                                           .collect(Collectors.toList());
	        prodDetail.setImagePaths(imagePaths);
	        // 메인 이미지: 첫 번째 이미지
	        prodDetail.setPath(imageList.get(0).getPath());
	    } else {
	        // 이미지가 없을 때 처리
	        prodDetail.setImagePaths(List.of()); // 빈 리스트 설정
	    }

	    // 상품 옵션 조회
	    List<ProdOptionVo> options = prodDao.prodOptions(prod_no);
	    if (options != null && !options.isEmpty()) {
	        prodDetail.setProdOptions(options);
	    } else {
	        // 옵션이 없을 때 처리
	        prodDetail.setProdOptions(List.of()); // 빈 리스트 설정
	    }

	    return prodDetail;
	}

	@Override
	public List<ProdImgVo> prodImages(int prod_no) {
		return prodDao.prodImages(prod_no);
	}

	@Override
	public List<ProdOptionVo> prodOptions(int prod_no) {
		return prodDao.prodOptions(prod_no);
	}

	
	@Override
	public List<ProdReviewVo> reviewList(int prod_no) {
		return prodDao.reviewList(prod_no);
	}

	@Override
	public List<ProdVo> recommendedProd(int cate_no) {
		return prodDao.recommendedProd(cate_no);
	}

	@Override
	public int getProdClickCount(int prod_no) {
		return prodDao.getProdClickCount(prod_no);
	}

	@Override
	public int updateProdClickCount(int prod_no) {
		return prodDao.updateProdClickCount(prod_no);
	}

	@Override
	public ProdVo prodCate(int cate_no) {
		return prodDao.prodCate(cate_no);
	}

	@Override
	public int insertProd(ProdVo prodVo) {
		return prodDao.insertProd(prodVo);
	}

	@Override
	public int insertPrice(ProdVo prodVo) {
		return prodDao.insertPrice(prodVo);
	}


	@Override
	public int insertProdOption(ProdOptionVo prodOptionVo) {
		return prodDao.insertProdOption(prodOptionVo);
	}

	@Override
	public int insertReview(ReviewVo review) {
		return prodDao.insertReview(review);
	}

	@Override
	public List<ProdVo> prodManagementList() {
		return prodDao.prodManagementList();
	}

	@Override
	public int updateReview(ReviewVo review) {
		return prodDao.updateReview(review);
	}

	@Override
	public int deleteReview(ReviewVo review) {
		return prodDao.deleteReview(review);
	}
	

		
	@Override
	public int updateProd(ProdVo prodVo, List<ProdOptionVo> options, List<ProdImgVo> images) {
		try {
	        // 기본 상품 정보 업데이트
	        int updateResult = prodDao.updateProd(prodVo);
	        if (updateResult <= 0) {
	            throw new RuntimeException("상품 기본 정보 수정에 실패했습니다.");
	        }

	        // 가격 정보 업데이트
	        int priceUpdateResult = prodDao.updatePrice(prodVo);
	        if (priceUpdateResult <= 0) {
	            throw new RuntimeException("상품 가격 수정에 실패했습니다.");
	        }

	        // 기존 옵션 삭제 및 새로운 옵션 삽입
	        prodDao.deleteProdOptions(prodVo.getProd_no());
	        if (options != null && !options.isEmpty()) {
	            for (ProdOptionVo option : options) {
	                option.setProd_no(prodVo.getProd_no());
	                int insertOptionResult = prodDao.insertProdOption(option);
	                if (insertOptionResult <= 0) {
	                    throw new RuntimeException("새로운 옵션 삽입에 실패했습니다.");
	                }
	            }
	        }

	        // 기존 이미지 삭제 및 새로운 이미지 삽입
	        prodDao.deleteProdImages(prodVo.getProd_no());
	        if (images != null && !images.isEmpty()) {
	            for (ProdImgVo image : images) {
	                image.setProd_no(prodVo.getProd_no());
	                int insertImageResult = prodDao.insertProdImage(image);
	                if (insertImageResult <= 0) {
	                    throw new RuntimeException("새로운 이미지 삽입에 실패했습니다.");
	                }
	            }
	        }
	    } catch (Exception e) {
	        throw new RuntimeException("상품 수정 중 오류가 발생했습니다: " + e.getMessage(), e);
	    }

	    return 1; // 모든 업데이트 성공 시 반환값
	}
	@Override
	public int insertProdImage(ProdImgVo prodImgVo) {
		return prodDao.insertProdImage(prodImgVo);
	}

	@Override
	public int deleteProdCascade(int prodNo) {
		return prodDao.deleteProdCascade(prodNo);
	}

	

	

}

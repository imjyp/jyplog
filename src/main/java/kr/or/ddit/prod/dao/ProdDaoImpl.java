package kr.or.ddit.prod.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.prod.mybatissssssssssssss.MyBatisDao;
import kr.or.ddit.prod.vo.ProdImgVo;
import kr.or.ddit.prod.vo.ProdOptionVo;
import kr.or.ddit.prod.vo.ProdReviewVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.prod.vo.ReviewVo;

public class ProdDaoImpl extends MyBatisDao implements IProdDao {
	
	private static ProdDaoImpl instance;

	private ProdDaoImpl() {
		
	}

	public static ProdDaoImpl getInstance() {
		if (instance == null) {
			instance = new ProdDaoImpl();
		}
		return instance;
	}

	

	@Override
	public List<ProdVo> prodCateList() {
		return selectList("prod.prodCateList");
		
	}

	@Override
	public List<ProdVo> prodList(ProdVo prodVo) {
		return selectList("prod.prodList",prodVo);
	}

	@Override
	public ProdVo prodDetail(int prod_no) {
		return selectOne("prod.prodDetail",prod_no);
	}

	@Override
	public List<ProdImgVo> prodImages(int prod_no) {
		return selectList("prod.prodImages",prod_no);
	}

	@Override
	public List<ProdOptionVo> prodOptions(int prod_no) {
		return selectList("prod.prodOptions",prod_no);
	}

	
	@Override
	public List<ProdReviewVo> reviewList(int prod_no) {
		return selectList("prod.reviewList",prod_no);
	}

	@Override
	public List<ProdVo> recommendedProd(int cate_no) {
		return selectList("prod.recommendedProd",cate_no);
	}


	@Override
	public int getProdClickCount(int prod_no) {
		return selectOne("prod.getProdClickCount",prod_no);
	}

	@Override
	public int updateProdClickCount(int prod_no) {
		return update("prod.updateProdClickCount",prod_no);
	}

	@Override
	public ProdVo prodCate(int cate_no) {
		return selectOne("prod.prodCate",cate_no);
	}

	@Override
	public int insertProd(ProdVo prodVo) {
		int result = insert("prodmanager.insertProd",prodVo);
		if (result > 0) {
	        // MyBatis의 useGeneratedKeys 속성으로 키 값을 제대로 받아오지 못한 경우를 확인
	        if (prodVo.getProd_no() == 0) {
	            throw new RuntimeException("상품 번호를 가져오지 못했습니다. 프로덕트 데이터: " + prodVo.toString());
	        }
	    } else {
	        throw new RuntimeException("상품 등록에 실패했습니다. 데이터베이스에 삽입되지 않았습니다.");
	    }
	    return result;
	}

	@Override
	public int insertPrice(ProdVo prodVo) {
		return insert("prodmanager.insertPrice",prodVo);
	}

	@Override
	public int insertProdImage(ProdImgVo prodImgVo) {
	    return insert("prodmanager.insertProdImage", prodImgVo);
	}

	@Override
	public int insertProdOption(ProdOptionVo prodOptionVo) {
		return insert("prodmanager.insertProdOption",prodOptionVo);
	}

	@Override
	public int insertReview(ReviewVo review) {
		return insert("prod.insertReview", review);
	}

	@Override
	public List<ProdVo> prodManagementList() {
		return selectList("prodmanager.prodManagementList");
	}

	@Override
	public int updateReview(ReviewVo review) {
		return update("prod.updateReview", review);
	}

	@Override
	public int deleteReview(ReviewVo review) {
		return delete("prod.deleteReview", review);
	}

	@Override
	public int updateProd(ProdVo prodVo) {
		return update("prodmanager.updateProd",prodVo);
	}

	@Override
	public int deleteProdOptions(int prod_no) {
		return delete("prodmanager.deleteProdOptions", prod_no);
	}

	@Override
	public int deleteProdImages(int prod_no) {
		return delete("prod.deleteProdImages", prod_no);
	}

	@Override
	public int updateProdOptions(ProdOptionVo prodOptionVo) {
		return update("prodmanager.updateProdOptions", prodOptionVo);
	}

	@Override
	public int updatePrice(ProdVo prodVo) {
		return update("prodmanager.updatePrice",prodVo);
	}

	@Override
	public int deleteProdCascade(int prodNo) {
		int result = 0;
		 // 이미지 정보 삭제
	    int imageDeleteResult = deleteProdImages(prodNo);
	    if (imageDeleteResult < 0) {
	        throw new RuntimeException("상품 이미지 삭제에 실패했습니다.");
	    }
	    result += imageDeleteResult;

	    // 옵션 정보 삭제
	    int optionDeleteResult = deleteProdOptions(prodNo);
	    if (optionDeleteResult < 0) {
	        throw new RuntimeException("상품 옵션 삭제에 실패했습니다.");
	    }
	    result += optionDeleteResult;

	    // 가격 정보 삭제
	    int priceDeleteResult = delete("prodmanager.deletePrice", prodNo);
	    if (priceDeleteResult < 0) {
	        throw new RuntimeException("상품 가격 정보 삭제에 실패했습니다.");
	    }
	    result += priceDeleteResult;

	    // 상품 삭제
	    int prodDeleteResult = delete("prodmanager.deleteProd", prodNo);
	    if (prodDeleteResult <= 0) {
	        throw new RuntimeException("상품 삭제에 실패했습니다.");
	    }
	    result += prodDeleteResult;

	    return result;
	}

	@Override
	public int deletePrice(int prod_no) {
		return delete("prodmanager.deleteProdImages",prod_no);
	}

	@Override
	public int deleteProd(int prod_no) {
		return delete("prodmanager.deleteProd",prod_no);
	}

	


}

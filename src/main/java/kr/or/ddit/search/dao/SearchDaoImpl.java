package kr.or.ddit.search.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mybatis.MyBatisDao;
import kr.or.ddit.prod.vo.ProdVo;

public class SearchDaoImpl extends MyBatisDao implements ISearchDao {

	private static SearchDaoImpl instance;

	private SearchDaoImpl() {

	}

	public static SearchDaoImpl getInstance() {
		if (instance == null) {
			instance = new SearchDaoImpl();
		}
		return instance;
	}

	

    @Override
    public List<MemberVo> searchMember(String query) {
        return selectList("search.searchMember", query);
    }

    @Override
    public List<ProdVo> searchProd(String query, String sort) {
    	 // 정렬 기준에 따라 다른 쿼리 실행
        if ("price_high".equals(sort)) {
            return selectList("search.searchProdByPriceDesc", query);
        } else if ("price_low".equals(sort)) {
            return selectList("search.searchProdByPriceAsc", query);
        } else if ("views".equals(sort)) {
            return selectList("search.searchProdByClicks", query);
        } else {
            return selectList("search.searchProd", query); // 기본 검색
        }
    }

    @Override
    public List<BoardVo> searchBoard(String query, int boardcode, String sort) {
    	Map<String, Object> params = new HashMap<>();
        params.put("query", query);
        params.put("boardcode", boardcode);

        // 정렬 기준에 따라 다른 쿼리 실행
        if ("latest".equals(sort)) {
            return selectList("search.searchBoardByLatest", params);
        } else if ("views".equals(sort)) {
            return selectList("search.searchBoardByViews", params);
        } else {
            return selectList("search.searchBoardByCode", params); // 기본 검색
        }
    }

    @Override
    public List<Object> searchAll(String query) {
        List<Object> results = new ArrayList<>();
        
        // 회원과 상품 검색 결과 추가
        results.addAll(searchMember(query));
        results.addAll(searchProd(query, null));
        results.addAll(searchBoard(query, 4, null)); 

        return results;
    }
    }

	

	

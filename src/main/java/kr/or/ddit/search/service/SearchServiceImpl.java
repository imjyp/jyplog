package kr.or.ddit.search.service;

import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.search.dao.ISearchDao;
import kr.or.ddit.search.dao.SearchDaoImpl;

public class SearchServiceImpl implements ISearchService {

    private static SearchServiceImpl instance;

    private SearchServiceImpl() {}

    public static SearchServiceImpl getInstance() {
        if (instance == null) {
            instance = new SearchServiceImpl();
        }
        return instance;
    }

    ISearchDao searchDao = SearchDaoImpl.getInstance();

    @Override
    public List<MemberVo> searchMember(String query) {
        return searchDao.searchMember(query);
    }

    @Override
    public List<ProdVo> searchProd(String query, String sort) {
        return searchDao.searchProd(query, sort);
    }

    @Override
    public List<BoardVo> searchBoard(String query, int boardcode, String sort) {
        return searchDao.searchBoard(query, boardcode, sort);
    }

    @Override
    public List<Object> searchAll(String query) {
        List<Object> results = new ArrayList<>();
        
        // Null 체크 후 추가
        List<MemberVo> memberResults = searchMember(query);
        if (memberResults != null && !memberResults.isEmpty()) {
            results.addAll(memberResults);
        } else {
            System.out.println("Member results empty");
        }

        List<ProdVo> prodResults = searchProd(query, null);
        if (prodResults != null && !prodResults.isEmpty()) {
            results.addAll(prodResults);
        } else {
            System.out.println("Prod results empty");
        }

     // 보드코드 4 (집들이 게시판) 검색 결과 추가
        List<BoardVo> boardResultsHouse = searchBoard(query, 4, null); // 보드코드 4에 대한 검색
        if (boardResultsHouse != null && !boardResultsHouse.isEmpty()) {
            results.addAll(boardResultsHouse);
        } else {
            System.out.println("집들이 게시판 results empty");
        }

        System.out.println("Search Results: " + results); // 검색 결과 확인을 위한 디버깅 로그
        return results;
    }

}

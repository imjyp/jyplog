package kr.or.ddit.search.dao;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.prod.vo.ProdVo;

public interface ISearchDao {
	
	List<MemberVo> searchMember(String query);
    List<ProdVo> searchProd(String query, String sort);
    List<BoardVo> searchBoard(String query, int boardcode, String sort);
    List<Object> searchAll(String query); // 통합 검색 메소드

    
    
}

package kr.or.ddit.admin.dao;

import java.util.List;

import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.member.vo.MemberVo;

public interface IAdminDao {
	public List<AdminVo> cateList();
	
	// 로그인
	public AdminVo adminLogin(AdminVo admin);
	
	// 회원 관리용 회원 검색
    List<MemberVo> searchMemAdmin(String query);

    // 회원 정보 수정

}	

package kr.or.ddit.admin.dao;

import java.util.List;

import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mybatis.MyBatisDao;

public class AdminDaoImpl extends MyBatisDao implements IAdminDao {

	private static AdminDaoImpl instance;

	private AdminDaoImpl() {

	}

	public static AdminDaoImpl getInstance() {
		if (instance == null) {
			instance = new AdminDaoImpl();
		}
		return instance;
	}


	@Override
	public AdminVo adminLogin(AdminVo admin) {
		AdminVo result = selectOne("admin.adminLogin", admin);
	    System.out.println("AdminDaoImpl: adminLogin 결과 - " + result); // 로그 추가
	    return result;
	}


	@Override
	public List<MemberVo> searchMemAdmin(String query) {
		return selectList("search.searchMemAdmin", query);
	}

	@Override
	public List<AdminVo> cateList() {
		return null;
	}


	

}

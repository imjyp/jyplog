package kr.or.ddit.admin.service;

import java.util.List;

import kr.or.ddit.admin.dao.AdminDaoImpl;
import kr.or.ddit.admin.dao.IAdminDao;
import kr.or.ddit.admin.vo.AdminVo;
import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mybatis.MyBatisDao;

public class AdminServiceImpl extends MyBatisDao implements IAdminService {

	private static AdminServiceImpl instance;

	private AdminServiceImpl() {

	}

	public static AdminServiceImpl getInstance() {
		if (instance == null) {
			instance = new AdminServiceImpl();
		}
		return instance;
	}

	IAdminDao adminDao = AdminDaoImpl.getInstance();
	IMemberDao iMemberDao = MemberDaoImpl.getInstance();	
	

	@Override
	public AdminVo adminLogin(AdminVo admin) {
		// 관리자 로그인 시도 시 로그 추가
        System.out.println("AdminServiceImpl: 관리자 로그인 시도 - ID: " + admin.getAdmin_id() + ", PW: " + admin.getAdmin_pw());
        AdminVo result = adminDao.adminLogin(admin);
        System.out.println("AdminDao에서 반환된 결과: " + result); // 로그 추가
        return result;
	}

	@Override
	public List<MemberVo> getMemberList() {
	    return iMemberDao.getMemberList(); // MemberDao를 통해 리스트를 가져옵니다.
	}

	
	@Override
	public List<AdminVo> cateList() {
		return null;
	}

	@Override
	public List<MemberVo> searchMemAdmin(String query) {
		return adminDao.searchMemAdmin(query);
	}


}

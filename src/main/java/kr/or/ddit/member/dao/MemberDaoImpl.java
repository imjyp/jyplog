package kr.or.ddit.member.dao;

import java.util.List;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mybatis.MyBatisDao;

public class MemberDaoImpl extends MyBatisDao implements IMemberDao {
    private static MemberDaoImpl instance;

    private MemberDaoImpl() {}

    public static MemberDaoImpl getInstance() {
        if (instance == null) {
            instance = new MemberDaoImpl();
        }
        return instance;
    }

    @Override
    public int insertMember(MemberVo member) {
        return insert("member.insertMember", member);
    }

    @Override
    public int getMaxMemNo() {
        return selectOne("member.getMaxMemNo");
    }

    @Override
    public MemberVo login(MemberVo member) {
        System.out.println("로그인 시도 중: " + member.getMem_id() + ", " + member.getMem_pw());  // 입력값 로그
        MemberVo result = selectOne("member.login", member);
        System.out.println("로그인 쿼리 결과: " + result);  // 쿼리 결과 로그
        return result;
    }

    @Override
    public String findId(MemberVo member) {
        return selectOne("member.findId", member);
    }

    @Override
    public boolean chkMemberInfo(MemberVo member) {
        MemberVo result = selectOne("member.chkMemberInfo", member);
        return result != null;
    }

    @Override
    public int updateTempPw(MemberVo member) {
        return update("member.updateTempPw", member);
    }

    @Override
    public boolean checkIdExists(String id) {
        Integer count = selectOne("member.checkIdExists", id);
        return count != null && count > 0;
    }

    @Override
    public boolean checkNickExists(String nick) {
        Integer count = selectOne("member.checkNickExists", nick);
        return count != null && count > 0;
    }

    @Override
    public List<MemberVo> getMemberList() {
        return selectList("member.getMemberList");
    }

    // 탈퇴 여부 확인 (DEL_YN = 2)
    @Override
    public boolean isWithdrawnMember(String mem_id) {
        System.out.println("탈퇴한 회원인지 확인하는 중: " + mem_id);  // 로그 추가
        Integer count = selectOne("member.isWithdrawnMember", mem_id);
        System.out.println("탈퇴한 회원 확인 결과 (count): " + count);  // 로그 추가
        return count != null && count > 0;
    }
}

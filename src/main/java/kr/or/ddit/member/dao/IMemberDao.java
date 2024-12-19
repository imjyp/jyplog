package kr.or.ddit.member.dao;

import java.util.List;
import kr.or.ddit.member.vo.MemberVo;

public interface IMemberDao {

    // 회원가입
    int insertMember(MemberVo member);

    // mem_no 시퀀스
    int getMaxMemNo();

    // 로그인
    MemberVo login(MemberVo member);

    // 아이디 찾기
    String findId(MemberVo member);

    // 사용자 정보 검증 (비밀번호 찾기 시)
    boolean chkMemberInfo(MemberVo member);

    // 임시 비밀번호 업데이트
    int updateTempPw(MemberVo member);

    // 아이디 중복 검사
    boolean checkIdExists(String id);

    // 닉네임 중복 검사
    boolean checkNickExists(String nick);

    // 회원 리스트
    List<MemberVo> getMemberList();

    // 탈퇴 여부 확인 (DEL_YN 값 체크) -> int로 수정
    boolean isWithdrawnMember(String mem_id);
}

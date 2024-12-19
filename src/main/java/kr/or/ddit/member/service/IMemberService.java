package kr.or.ddit.member.service;

import java.util.List;
import kr.or.ddit.member.vo.MemberVo;

public interface IMemberService {

    // 회원 리스트
    List<MemberVo> getMemberList();

    // 아이디, 닉네임 중복검사
    boolean isIdExists(String id);
    boolean isNickExists(String nick);

    // 사용자 정보 검증 (비밀번호 찾기 시 사용)
    boolean chkMemberInfo(MemberVo member);

    // 임시 비밀번호 발급 및 업데이트
    String issueTempPw(MemberVo member);

    // 아이디 찾기
    String findId(MemberVo member);

    // 회원가입
    int insertMember(MemberVo member);

    // mem_no 시퀀스w
    int getMaxMemNo();

    // 로그인
    MemberVo login(MemberVo member);

    // 탈퇴 여부 확인 (boolean 반환)
    boolean isWithdrawnMember(String mem_id);
}

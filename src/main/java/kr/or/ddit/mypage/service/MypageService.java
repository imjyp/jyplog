package kr.or.ddit.mypage.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;

public interface MypageService {

    // 비밀번호 확인
    int checkPassword(MemberVo member);

    // 비밀번호 업데이트
    int updatePassword(MemberVo member);

    // 회원 정보 업데이트
    int updateMemberInfo(MemberVo member);

    // 회원 탈퇴 (DEL_YN 업데이트)
    int updateMemberDelYn(MemberVo member);

    int withdrawMember(MemberVo loginUser);

    int deleteMember(int memNo);

    // 회원 정보 조회
    MemberVo getMemberInfo(String memId); // String으로 변경

    // 팔로우 상태 확인 후 토글
    boolean toggleFollow(String followerId, String followingId);

    // 팔로워 수 조회
    int getFollowerCount(String memberId);

    // 팔로잉 수 조회
    int getFollowingCount(String memberId);

    List<BoardVo> getMyPosts(int memNo);
}

package kr.or.ddit.mypage.dao;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;

public interface MypageDao {

    // 비밀번호 확인 메서드
    int checkPassword(MemberVo member);

    // 비밀번호 업데이트 메서드
    int updatePassword(MemberVo member);

    // 회원 정보 업데이트 메서드
    int updateMemberInfo(MemberVo member); // 회원 정보 수정용 메서드

    // 회원 탈퇴 메서드
    int updateMemberDelYn(MemberVo member);

    // 회원 삭제 메서드
    int deleteMember(int memNo);

    // 회원 정보 조회
    MemberVo getMemberInfo(String memId); // memId를 매개변수로 받음

    // 팔로우 상태 확인 메서드
    boolean isFollowing(String followerId, String followingId);

    // 팔로우 메서드
    int followUser(String followerId, String followingId);

    // 언팔로우 메서드
    int unfollowUser(String followerId, String followingId);

    // 팔로워 수 조회 메서드
    int getFollowerCount(String memberId);

    // 팔로잉 수 조회 메서드
    int getFollowingCount(String memberId);

    // 게시글 목록 조회 메서드
    List<BoardVo> selectMyPosts(int memNo);
}

package kr.or.ddit.mypage.dao;

import java.util.List;
import java.util.Map;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mybatis.MyBatisDao;

public class MypageDaoImpl extends MyBatisDao implements MypageDao {

    private static MypageDaoImpl instance;

    private MypageDaoImpl() {}

    public static MypageDaoImpl getInstance() {
        if (instance == null) {
            instance = new MypageDaoImpl();
        }
        return instance;
    }

    // 비밀번호 확인 메서드
    @Override
    public int checkPassword(MemberVo member) {
        System.out.println("쿼리 실행 전: checkPassword 호출됨");
        int result = selectOne("mypage.checkPassword", member);
        System.out.println("쿼리 실행 후: 결과 - " + result);
        return result;
    }

    // 비밀번호 업데이트 메서드
    @Override
    public int updatePassword(MemberVo member) {
        System.out.println("비밀번호 업데이트 실행");
        int result = update("mypage.updatePassword", member);
        System.out.println("비밀번호 업데이트 후: 결과 - " + result);
        return result;
    }

    // 회원 정보 업데이트 메서드
    @Override
    public int updateMemberInfo(MemberVo member) {
        System.out.println("회원 정보 업데이트 실행");
        int result = update("mypage.updateMemberInfo", member);
        System.out.println("회원 정보 업데이트 후: 결과 - " + result);
        return result;
    }

    // 회원 탈퇴 처리 메서드 (DEL_YN 업데이트)
    @Override
    public int updateMemberDelYn(MemberVo member) {
        System.out.println("회원 탈퇴 처리 실행");
        int result = update("mypage.updateMemberDelYn", member);
        System.out.println("회원 탈퇴 처리 후: 결과 - " + result);
        return result;
    }

    // 회원 삭제 메서드
    @Override
    public int deleteMember(int memNo) {
        int result = update("mypage.deleteMember", memNo);
        System.out.println("회원 삭제 처리 후: 결과 - " + result);
        return result;
    }

    // 회원 정보 조회 메서드
    @Override
    public MemberVo getMemberInfo(String memId) {
        System.out.println("회원 정보 조회 실행: " + memId);
        MemberVo member = selectOne("mypage.getMemberInfo", memId);
        System.out.println("회원 정보 조회 결과: " + member);
        return member;
    }

    // 팔로우 상태 확인 메서드
    @Override
    public boolean isFollowing(String followerId, String followingId) {
        System.out.println("팔로우 상태 확인: " + followerId + " -> " + followingId);
        int count = selectOne("mypage.isFollowing", Map.of("followerId", followerId, "followingId", followingId));
        System.out.println("팔로우 상태: " + (count > 0));
        return count > 0;
    }

    // 팔로우 메서드
    @Override
    public int followUser(String followerId, String followingId) {
        System.out.println("팔로우 처리: " + followerId + " -> " + followingId);
        int result = insert("mypage.followUser", Map.of("followerId", followerId, "followingId", followingId));
        System.out.println("팔로우 처리 후: 결과 - " + result);
        return result;
    }

    // 언팔로우 메서드
    @Override
    public int unfollowUser(String followerId, String followingId) {
        System.out.println("언팔로우 처리: " + followerId + " -> " + followingId);
        int result = delete("mypage.unfollowUser", Map.of("followerId", followerId, "followingId", followingId));
        System.out.println("언팔로우 처리 후: 결과 - " + result);
        return result;
    }

    // 팔로워 수 조회 메서드
    @Override
    public int getFollowerCount(String memberId) {
        System.out.println("팔로워 수 조회: " + memberId);
        int count = selectOne("mypage.getFollowerCount", memberId);
        System.out.println("팔로워 수: " + count);
        return count;
    }

    // 팔로잉 수 조회 메서드
    @Override
    public int getFollowingCount(String memberId) {
        System.out.println("팔로잉 수 조회: " + memberId);
        int count = selectOne("mypage.getFollowingCount", memberId);
        System.out.println("팔로잉 수: " + count);
        return count;
    }

    // 게시글 조회 메서드
    @Override
    public List<BoardVo> selectMyPosts(int memNo) {
        return selectList("mypage.selectMyPosts", memNo);
    }
}

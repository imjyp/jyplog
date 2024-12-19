package kr.or.ddit.mypage.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.dao.MypageDao;
import kr.or.ddit.mypage.dao.MypageDaoImpl;

public class MypageServiceImpl implements MypageService {
    private static MypageServiceImpl instance;

    private MypageServiceImpl() {
    }

    public static MypageServiceImpl getInstance() {
        if (instance == null) {
            instance = new MypageServiceImpl();
        }
        return instance;
    }

    MypageDao mypageDao = MypageDaoImpl.getInstance();

    // 비밀번호 확인
    @Override
    public int checkPassword(MemberVo member) {
        return mypageDao.checkPassword(member);
    }

    // 비밀번호 업데이트
    @Override
    public int updatePassword(MemberVo member) {
        return mypageDao.updatePassword(member);
    }

    // 회원 정보 업데이트
    @Override
    public int updateMemberInfo(MemberVo member) {
        return mypageDao.updateMemberInfo(member);
    }

    // 회원 탈퇴 (DEL_YN 업데이트)
    @Override
    public int updateMemberDelYn(MemberVo member) {
        return mypageDao.updateMemberDelYn(member);
    }

    @Override
    public int withdrawMember(MemberVo loginUser) {
        return mypageDao.updateMemberDelYn(loginUser);
    }

    @Override
    public int deleteMember(int memNo) {
        return mypageDao.deleteMember(memNo);
    }

    @Override
    public MemberVo getMemberInfo(String memId) {
        return mypageDao.getMemberInfo(memId);
    }

    // 팔로우 상태 확인 후 토글
    @Override
    public boolean toggleFollow(String followerId, String followingId) {
        boolean isFollowing = mypageDao.isFollowing(followerId, followingId);

        if (isFollowing) {
            // 이미 팔로우 상태인 경우 언팔로우 처리
            mypageDao.unfollowUser(followerId, followingId);
        } else {
            // 팔로우 상태가 아닌 경우 팔로우 처리
            mypageDao.followUser(followerId, followingId);
        }

        return !isFollowing; // 팔로우 상태를 반전하여 반환
    }

    // 팔로워 수 조회
    @Override
    public int getFollowerCount(String memberId) {
        return mypageDao.getFollowerCount(memberId);
    }

    // 팔로잉 수 조회
    @Override
    public int getFollowingCount(String memberId) {
        return mypageDao.getFollowingCount(memberId);
    }

    @Override
    public List<BoardVo> getMyPosts(int memNo) {
        return mypageDao.selectMyPosts(memNo);
    }
}

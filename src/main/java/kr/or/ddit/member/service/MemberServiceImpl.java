package kr.or.ddit.member.service;

import java.util.List;
import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVo;
import mail.Mail;

public class MemberServiceImpl implements IMemberService {

    private static MemberServiceImpl instance;

    private MemberServiceImpl() {}

    public static MemberServiceImpl getInstance() {
        if (instance == null) {
            instance = new MemberServiceImpl();
        }
        return instance;
    }

    IMemberDao memberDao = MemberDaoImpl.getInstance();
    Mail mail = new Mail();

    @Override
    public int insertMember(MemberVo member) {
        return memberDao.insertMember(member);
    }

    @Override
    public int getMaxMemNo() {
        return memberDao.getMaxMemNo();
    }

    @Override
    public MemberVo login(MemberVo member) {
        return memberDao.login(member);
    }

    @Override
    public String findId(MemberVo member) {
        return memberDao.findId(member);
    }

    @Override
    public boolean chkMemberInfo(MemberVo member) {
        return memberDao.chkMemberInfo(member);
    }

    @Override
    public String issueTempPw(MemberVo member) {
        String tempPw = mail.generateTempPw();
        member.setMem_pw(tempPw);

        if (memberDao.updateTempPw(member) > 0) {
            mail.sendEmail(member.getEmail(), tempPw, tempPw);
            return tempPw;
        }
        return null;
    }

    @Override
    public boolean isIdExists(String id) {
        return memberDao.checkIdExists(id);
    }

    @Override
    public boolean isNickExists(String nick) {
        return memberDao.checkNickExists(nick);
    }

    @Override
    public List<MemberVo> getMemberList() {
        return memberDao.getMemberList();
    }

    @Override
    public boolean isWithdrawnMember(String mem_id) {
        return memberDao.isWithdrawnMember(mem_id); // boolean 반환
    }
}

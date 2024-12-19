package kr.or.ddit.notification.service;

import java.time.LocalDateTime;
import java.util.List;

import kr.or.ddit.Websocket;
import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.mybatis.MyBatisDao;
import kr.or.ddit.notification.dao.INotificationDao;
import kr.or.ddit.notification.dao.NotificationDaoImpl;
import kr.or.ddit.order.vo.ProdOrderVo;

public class NotificationServiceImpl extends MyBatisDao implements INotificationService{

	private static NotificationServiceImpl instance;

	private NotificationServiceImpl() {

	}

	public static NotificationServiceImpl getInstance() {
		if (instance == null) {
			instance = new NotificationServiceImpl();
		}
		return instance;
	}

	INotificationDao notificationDao = NotificationDaoImpl.getInstance();

	@Override
    public void sendOrderNotification(ProdOrderVo prodOrderVo) {
        String content = "주문이 완료되었습니다: " + prodOrderVo.getProdOrderNo();
        String date = LocalDateTime.now().toString(); // 현재 시간 생성
        Websocket.sendNotification(content); // 실시간 알림 전송
        notificationDao.insertOrderNotification(prodOrderVo); // 알림 DB 저장
    }

    @Override
    public void sendBoardNotification(BoardVo boardVo) {
        String content = "게시글이 작성되었습니다: " + boardVo.getTitle();
        String date = LocalDateTime.now().toString(); // 현재 시간 생성
        Websocket.sendNotification(content); // 실시간 알림 전송
        notificationDao.insertBoardNotification(boardVo); // 알림 DB 저장
    }

    @Override
    public List<ProdOrderVo> getOrderNotifications() {
        return notificationDao.getOrderNotifications();
    }

    @Override
    public List<BoardVo> getBoardNotifications() {
        return notificationDao.getBoardNotifications();
    }
}

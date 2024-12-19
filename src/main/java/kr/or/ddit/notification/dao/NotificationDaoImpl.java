package kr.or.ddit.notification.dao;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.mybatis.MyBatisDao;
import kr.or.ddit.order.vo.ProdOrderVo;

public class NotificationDaoImpl extends MyBatisDao implements INotificationDao{

	private static NotificationDaoImpl instance;

	private NotificationDaoImpl() {

	}

	public static NotificationDaoImpl getInstance() {
		if (instance == null) {
			instance = new NotificationDaoImpl();
		}
		return instance;
	}

	@Override
	public void insertOrderNotification(ProdOrderVo prodOrderVo) {
		insert("notification.insertOrderNotification", prodOrderVo);
	}

	@Override
	public void insertBoardNotification(BoardVo boardVo) {
		// MyBatisDao의 insert 메서드 사용
		insert("notification.insertBoardNotification", boardVo);
	}

	@Override
	public List<ProdOrderVo> getOrderNotifications() {
		// MyBatisDao의 selectList 메서드 사용
		return selectList("notification.getOrderNotifications");
	}

	@Override
	public List<BoardVo> getBoardNotifications() {
		return selectList("notification.getBoardNotifications");
	}

}
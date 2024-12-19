package kr.or.ddit.notification.dao;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.order.vo.OrderVo;
import kr.or.ddit.order.vo.ProdOrderVo;

public interface INotificationDao {

	void insertOrderNotification(ProdOrderVo prodOrderVo); // 주문 알림 저장
    void insertBoardNotification(BoardVo boardVo); // 게시글 알림 저장
    List<ProdOrderVo> getOrderNotifications(); // 주문 알림 조회
    List<BoardVo> getBoardNotifications(); // 게시글 알림 조회
    
    // void sendCommentNotification(BoardVo boardVo); // 댓글 관련 알림
    // List<CommentVo> getBoardNotifications(); // 댓글 관련 알림 조회

}
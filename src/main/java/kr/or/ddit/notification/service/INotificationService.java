package kr.or.ddit.notification.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardVo;
import kr.or.ddit.order.vo.ProdOrderVo;

public interface INotificationService {
	
	void sendOrderNotification(ProdOrderVo prodOrderVo); // 주문 관련 알림
    void sendBoardNotification(BoardVo boardVo); // 게시글 관련 알림
   // void sendCommentNotification(BoardVo boardVo); // 댓글 관련 알림
    
    List<ProdOrderVo> getOrderNotifications(); // 주문 관련 알림 조회
    List<BoardVo> getBoardNotifications(); // 게시글 관련 알림 조회
   // List<CommentVo> getBoardNotifications(); // 댓글 관련 알림 조회

}
package kr.or.ddit;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/websocket")
public class Websocket {

	// 현재 연결된 클라이언트를 저장하는 Set
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    // 웹 소켓 연결 시 호출
    @OnOpen
    public void onOpen(Session session) {
        clients.add(session); // 세션을 클라이언트 리스트에 추가
        System.out.println("Client connected: " + session.getId());
    }

    // 웹소켓 메시지 수신 시 호출
    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Received message from client " + session.getId() + ": " + message);
        sendMessageToAll("Message from " + session.getId() + ": " + message); // 모든 클라이언트에 메시지 전송
    }

    // 모든 클라이언트에 메시지 전송
    private void sendMessageToAll(String message) {
        synchronized (clients) {
            for (Session client : clients) {
                if (client.isOpen()) {
                    try {
                        client.getBasicRemote().sendText(message);
                        System.out.println("Message sent to: " + client.getId());
                    } catch (IOException e) {
                        e.printStackTrace();
                        // 에러가 발생하면 해당 클라이언트를 제거
                        clients.remove(client);
                        System.out.println("Client removed due to error: " + client.getId());
                    }
                }
            }
        }
    }

    // 외부에서 알림 메시지를 모든 클라이언트에게 전송할 수 있는 메서드
    public static void sendNotification(String notification) {
        System.out.println("Sending notification: " + notification); // 로그 추가
        synchronized (clients) {
            for (Session client : clients) {
                if (client.isOpen()) {
                    try {
                        client.getBasicRemote().sendText(notification); // 알림을 클라이언트에게 전송
                        System.out.println("Notification sent to: " + client.getId()); // 로그 추가
                    } catch (IOException e) {
                        e.printStackTrace();
                        clients.remove(client);
                        System.out.println("Client removed due to error: " + client.getId());
                    }
                }
            }
        }
    }

    // 웹 소켓이 닫힐 때 세션 제거
    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        System.out.println("Client disconnected: " + session.getId());
    }

    // 웹 소켓이 에러가 나면 호출되는 이벤트
    @OnError
    public void handleError(Session session, Throwable t) {
        System.err.println("Error occurred with client " + (session != null ? session.getId() : "unknown"));
        t.printStackTrace();
        // 에러 발생 시 세션 제거
        if (session != null) {
            clients.remove(session);
            System.out.println("Client removed due to error: " + session.getId());
        }
    }
}
package mail;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class Mail {

	// 인증번호 생성 메서드
	public String generateAuthCode() {
		int authCode = (int) (Math.random() * 1000000);
		return String.format("%06d", authCode);
	}

	// 임시 비밀번호 생성 메서드
	public String generateTempPw() {
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		StringBuilder tempPw = new StringBuilder();
		for (int i = 0; i < 8; i++) {
			int index = (int) (Math.random() * characters.length());
			tempPw.append(characters.charAt(index));
		}
		return tempPw.toString();
	}

	// 이메일 발송 메서드
	public boolean sendEmail(String recipientEmail, String subject, String content) {
		final String username = "ddit401team1@gmail.com"; // 발송자 이메일 계정
		final String password = "alhzrssokilahiye "; // 앱 비밀번호 사용

		// 발송자 계정이 제대로 설정되었는지 확인
		if (username == null || password == null) {
			System.err.println("이메일 발송 계정 정보가 설정되지 않았습니다.");
			return false;
		}

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587"); // 포트 587로 변경 (TLS 사용)
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true"); // TLS 사용 설정
		props.put("mail.smtp.ssl.enable", "false"); // SSL 비활성화
		props.put("mail.debug", "true"); // SMTP 디버깅 활성화

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
			message.setSubject(subject);
			message.setText(content);

			System.out.println("이메일 발송 준비 완료: " + recipientEmail);
			Transport.send(message);
			System.out.println("이메일 전송 성공: " + recipientEmail);
			return true;

		} catch (MessagingException e) {
			// 이메일 발송 오류 시 예외 메시지 출력
			e.printStackTrace();
			System.err.println("이메일 발송 실패: " + e.getMessage());
			return false;
		} catch (Exception e) {
			// 기타 예외 발생 시 출력
			e.printStackTrace();
			System.err.println("예기치 않은 오류 발생: " + e.getMessage());
			return false;
		}
	}
}

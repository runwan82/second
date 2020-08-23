package mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;

public class SendMail {
	
	public static void main(String[] args) {
		new SendMail().sendMail();
		
	}
	
	public void sendMail() {
		
		
		String user = "joeune92@naver.com";
		String pwd = "wlstlfdmlqkd";
		
		Properties prop = new Properties();
		
		prop.put("mail.smtp.host", "smtp.naver.com");
		prop.put("mail.smtp.port", 587);
		prop.put("mail.smtp.auth", "true");
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, pwd);
			}
		});
		
		
		
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user));
			//수신자 메일주소
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress("joeune92@naver.com"));
			
			//메일 제목
			msg.setSubject("다모아방 비밀번호 안내 메일입니다");
			
			//메일 내용
			msg.setText("비밀번호를 [" +1111111111+ "]로 초기화 하였습니다.");
			//msg.setText("변경 후 사용해 주세요!");
			
			Transport.send(msg); /// 전송
			System.out.println("message sent 성공");

		
		}catch(AddressException e) {
			e.printStackTrace();
		}catch(MessagingException e) {
			e.printStackTrace();
		}
	}
	

}


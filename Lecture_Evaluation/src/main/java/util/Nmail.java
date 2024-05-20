package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Nmail extends Authenticator {
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("rapheo0913@naver.com", "@Dhkxkskqp12");
	}

}

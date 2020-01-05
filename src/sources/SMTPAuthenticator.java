package sources;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator
{
        public PasswordAuthentication getPasswordAuthentication() {
        	String username=System.getProperty("UNAME_CRED");
        	String password=System.getProperty("PASS_CRED");
        	return new PasswordAuthentication(username, password);
        }
} 
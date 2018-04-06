package com.drysign.utility;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import org.apache.log4j.Logger;
import org.springframework.mail.MailParseException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class EmailSender {
	private JavaMailSender mailSender;
	private SimpleMailMessage simpleMailMessage;
	private static final Logger logger = Logger.getLogger(EmailSender.class);
	
	public void setSimpleMailMessage(SimpleMailMessage simpleMailMessage) {
		this.simpleMailMessage = simpleMailMessage;
	}

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	/********
	 * Send Email with URL(Sign document email)
	 * 
	 * @param from
	 * @param to
	 * @param subject
	 * @param body
	 * @param url
	 * @return
	 *********/
	public String sendMail(String from, String to,String cc, String subject, String body, String url) {

		String emailTemplate = "<html xmlns='http://www.w3.org/1999/xhtml'>\r\n<head>\r\n<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\r\n<title>Dry sign</title>\r\n<link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\">\r\n<style>\r\n.emailer_header {\r\n\tmargin-left: auto;\r\n\tmargin-right: auto;\r\n\tbackground-repeat: no-repeat;\r\n\theight: 70px;\r\n}\r\n.emailer_body {\r\n\tfloat: left;\r\n\twidth: 100%;\r\n\tpadding: 25px;\r\n\theight: auto;\r\n\tfont-family:roboto;\r\n\tfont-size: 16px;\r\n\tcolor: #2C3D4F;\r\n\tline-height: 24px;\r\n}\r\n\ta {\r\n\t\tcolor: #00BC9C;\r\n\t\tfont-size: 15px;\r\n\t}\r\n</style>\r\n</head>\r\n<body>\r\n<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:768px; border: 1px solid #9297a7;\">\r\n  <tbody>\r\n    <tr>\r\n      <td><table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #00bc9c;\">\r\n          <tbody>\r\n            <tr>\r\n              <td align=\"left\" height=\"100px\" style=\"padding: 10px;\"><img src=\"https://drysign.global/images/1.0/logo_inner.png\"  alt=\"Logo\"></td>\r\n            </tr>\r\n          </tbody>\r\n        </table></td>\r\n    </tr>\r\n   \r\n\t  <tr>\r\n\t\t  <td>\r\n\t\t\t  <table class=\"emailer_body\" border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t\t\t  \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t<td>"
				+ body
				+ "</td>\r\n\t\t\t\t\t</tr>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td height=\"20px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t   <tr>\r\n\t\t\t\t\t  <td height=\"1px\" style=\"border-top: 1px solid #d4d4d4\"></td>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t    <tr>\r\n\t\t\t\t\t  <td height=\"20px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t\t  <td>\r\n\t\t\t\t\t\t  <p style=\"font-size: 12px\">If you are having trouble clicking the sign document button, copy and paste the URL below into your web browser:<br/>\r\n\t\t\t\t\t\t  <a href=\""+url+"\" style=\"color: #00BC9C\">"
				+ url
				+ "</a></p>\r\n\t\t\t\t\t  </td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td height=\"30px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t     \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td align=\"center\">\r\n\t\t\t\t\t\t  <a href=\"#\">"+"\"Thank you for using DrySign!"+"\" - DrySign Team</a> | <a href=\"#\">Unsubscribe</a>\r\n\t\t\t\t\t\t  <p style=\"font-size: 12px\">If you have any questions or comments, please contact us at <a style=\"font-size: 12px\" href=\"#\">support@drysign.global</a></p>\r\n\t\t\t\t\t  </td>\r\n\t\t\t\t  </tr>\r\n\t\t  \r\n\t\t\t  </table>\r\n\t\t  \t\r\n\t\t  </td>\r\n\t  </tr>\r\n\t \r\n   \r\n  </tbody>\r\n</table>\r\n</body>\r\n</html>";
		String emailStatus = null;
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
			mimeMessage.setContent(emailTemplate, "text/html");
			helper.setTo(to);
			if(cc != null){
			helper.setCc(cc);
			}
			helper.setSubject(subject);
			helper.setFrom(from, "DrySign");
			mailSender.send(mimeMessage);
			emailStatus = "1";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			emailStatus = "0";
			e.printStackTrace();
		}
		return emailStatus;

	}
	/********
	 * Send Email with URL(Sign document email)
	 * 
	 * @param from
	 * @param to
	 * @param subject
	 * @param body
	 * @param url
	 * @return
	 *********/
	public String sendMail1(String from, String to, String cc,String subject, String body) {

		String emailTemplate = "<html xmlns='http://www.w3.org/1999/xhtml'>\r\n<head>\r\n<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\r\n<title>Dry sign</title>\r\n<link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\">\r\n<style>\r\n.emailer_header {\r\n\tmargin-left: auto;\r\n\tmargin-right: auto;\r\n\tbackground-repeat: no-repeat;\r\n\theight: 70px;\r\n}\r\n.emailer_body {\r\n\tfloat: left;\r\n\twidth: 100%;\r\n\tpadding: 25px;\r\n\theight: auto;\r\n\tfont-family:roboto;\r\n\tfont-size: 16px;\r\n\tcolor: #2C3D4F;\r\n\tline-height: 24px;\r\n}\r\n\ta {\r\n\t\tcolor: #00BC9C;\r\n\t\tfont-size: 15px;\r\n\t}\r\n</style>\r\n</head>\r\n<body>\r\n<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:768px; border: 1px solid #9297a7;\">\r\n  <tbody>\r\n    <tr>\r\n      <td><table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #00bc9c;\">\r\n          <tbody>\r\n            <tr>\r\n              <td align=\"left\" height=\"100px\" style=\"padding: 10px;\"><img src=\"https://drysign.global/images/1.0/logo_inner.png\"  alt=\"Logo\"></td>\r\n            </tr>\r\n          </tbody>\r\n        </table></td>\r\n    </tr>\r\n   \r\n\t  <tr>\r\n\t\t  <td>\r\n\t\t\t  <table class=\"emailer_body\" border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t\t\t  \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t<td>"
				+ body
				+ "</td>\r\n\t\t\t\t\t</tr>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td height=\"20px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t   <tr>\r\n\t\t\t\t\t  <td height=\"1px\" style=\"border-top: 1px solid #d4d4d4\"></td>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t    <tr>\r\n\t\t\t\t\t  <td height=\"20px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t\t  <td>\r\n\t\t\t\t\t\t  <p style=\"font-size: 12px\"><br/>\r\n\t\t\t\t\t\t  <a href=\"#\" style=\"color: #00BC9C\">"
				+ "</a></p>\r\n\t\t\t\t\t  </td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td height=\"30px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t     \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td align=\"center\">\r\n\t\t\t\t\t\t  <a href=\"#\">"+"\"Thank you for using DrySign!"+"\" - DrySign Team</a> | <a href=\"#\">Unsubscribe</a>\r\n\t\t\t\t\t\t  <p style=\"font-size: 12px\">If you have any questions or comments, please contact us at <a style=\"font-size: 12px\" href=\"#\">support@drysign.global</a></p>\r\n\t\t\t\t\t  </td>\r\n\t\t\t\t  </tr>\r\n\t\t  \r\n\t\t\t  </table>\r\n\t\t  \t\r\n\t\t  </td>\r\n\t  </tr>\r\n\t \r\n   \r\n  </tbody>\r\n</table>\r\n</body>\r\n</html>";
		String emailStatus = null;
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
			mimeMessage.setContent(emailTemplate, "text/html");
			helper.setTo(to);
			if(cc != null){
				helper.setCc(cc);
				}
			helper.setSubject(subject);
			helper.setFrom(from, "DrySign");
			mailSender.send(mimeMessage);
			emailStatus = "1";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			emailStatus = "0";
			e.printStackTrace();
		}
		return emailStatus;

	}

	/****
	 * 
	 * Send with Attachment(SelfSign&GroupSign with Attachment)
	 * 
	 * @param from
	 * @param to
	 * @param cc
	 * @param subject
	 * @param body
	 * @param fileName
	 * @return
	 * @throws IOException
	 ****/
	public String sendMail(String from, String to, String cc, String subject, String body, String fileName, String name)
			throws IOException {
		String emailTemplate = "<html xmlns='http://www.w3.org/1999/xhtml'>\r\n<head>\r\n<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\r\n<title>Dry sign</title>\r\n<link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\">\r\n<style>\r\n.emailer_header {\r\n\tmargin-left: auto;\r\n\tmargin-right: auto;\r\n\tbackground-repeat: no-repeat;\r\n\theight: 70px;\r\n}\r\n.emailer_body {\r\n\tfloat: left;\r\n\twidth: 100%;\r\n\tpadding: 25px;\r\n\theight: auto;\r\n\tfont-family:roboto;\r\n\tfont-size: 16px;\r\n\tcolor: #2C3D4F;\r\n\tline-height: 24px;\r\n}\r\n\ta {\r\n\t\tcolor: #00BC9C;\r\n\t\tfont-size: 15px;\r\n\t}\r\n</style>\r\n</head>\r\n<body>\r\n<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:768px; border: 1px solid #9297a7;\">\r\n  <tbody>\r\n    <tr>\r\n      <td><table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #00bc9c;\">\r\n          <tbody>\r\n            <tr>\r\n              <td align=\"left\" height=\"100px\" style=\"padding: 10px;\"><img src=\"https://drysign.global/images/1.0/logo_inner.png\"  alt=\"Logo\"></td>\r\n            </tr>\r\n          </tbody>\r\n        </table></td>\r\n    </tr>\r\n   \r\n\t  <tr>\r\n\t\t  <td>\r\n\t\t\t  <table class=\"emailer_body\" border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t\t\t  \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t<td>"
				+ body
				+ "</td>\r\n\t\t\t\t\t</tr>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td height=\"20px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t   <tr>\r\n\t\t\t\t\t  <td height=\"1px\" style=\"border-top: 1px solid #d4d4d4\"></td>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t    <tr>\r\n\t\t\t\t\t  <td height=\"20px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t\t  <td>\r\n\t\t\t\t\t\t  <p style=\"font-size: 12px\"><br/>\r\n\t\t\t\t\t\t  <a href=\"#\" style=\"color: #00BC9C\"></a></p>\r\n\t\t\t\t\t  </td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td height=\"30px;\"></td>\r\n\t\t\t\t  </tr>\r\n\t\t\t\t     \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td align=\"center\">\r\n\t\t\t\t\t\t  <a href=\"#\">"+"\"Thank you for using DrySign!"+"\" - DrySign Team</a> | <a href=\"#\">Unsubscribe</a>\r\n\t\t\t\t\t\t  <p style=\"font-size: 12px\">If you have any questions or comments, please contact us at <a style=\"font-size: 12px\" href=\"#\">support@drysign.global</a></p>\r\n\t\t\t\t\t  </td>\r\n\t\t\t\t  </tr>\r\n\t\t  \r\n\t\t\t  </table>\r\n\t\t  \t\r\n\t\t  </td>\r\n\t  </tr>\r\n\t \r\n   \r\n  </tbody>\r\n</table>\r\n</body>\r\n</html>";
		String emailStatus = null;
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		Multipart multipart = new MimeMultipart();
		try {
			mimeMessage.setFrom(new InternetAddress(from, "DrySign"));
			mimeMessage.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(to));
			if(cc != null){
			mimeMessage.addRecipients(MimeMessage.RecipientType.CC, InternetAddress.parse(cc));
			}
			mimeMessage.setSubject(subject);
			MimeBodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setContent(emailTemplate, "text/html");
			multipart.addBodyPart(messageBodyPart);
			MimeBodyPart attachPart = new MimeBodyPart();
			DataSource source = new FileDataSource(fileName);
			attachPart.setDataHandler(new DataHandler(source));
			attachPart.setFileName(name);
			multipart.addBodyPart(attachPart);
			mimeMessage.setContent(multipart);
			mailSender.send(mimeMessage);
			emailStatus = "1";
		} catch (MessagingException | UnsupportedEncodingException e) {
			throw new MailParseException(e);
		}

		return emailStatus;
	}

	/***
	 * Send subscription email
	 * 
	 * @param from
	 * @param to
	 * @param subject
	 * @param body
	 * @param url
	 * @return
	 ****/
	public String sendMail(String from, String to, String subject, String body) {
		logger.info("===========Enter into sendEmail subscription===========");

		String emailTemplate = "<html xmlns='http://www.w3.org/1999/xhtml'>\r\n<head>\r\n<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\r\n<title>Dry sign</title>\r\n<link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\">\r\n<style>\r\n.emailer_header {\r\n\tmargin-left: auto;\r\n\tmargin-right: auto;\r\n\tbackground-repeat: no-repeat;\r\n\theight: 70px;\r\n}\r\n.emailer_body {\r\n\tfloat: left;\r\n\twidth: 100%;\r\n\tpadding: 25px;\r\n\theight: auto;\r\n\tfont-family:roboto;\r\n\tfont-size: 16px;\r\n\tcolor: #2C3D4F;\r\n\tline-height: 24px;\r\n}\r\n\ta {\r\n\t\tcolor: #00BC9C;\r\n\t\tfont-size: 15px;\r\n\t}\r\n</style>\r\n</head>\r\n<body>\r\n<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:768px; border: 1px solid #9297a7;\">\r\n  <tbody>\r\n    <tr>\r\n      <td><table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #00bc9c;\">\r\n          <tbody>\r\n            <tr>\r\n              <td align=\"left\" height=\"100px\" style=\"padding: 10px;\"><img src=\"https://drysign.global/images/1.0/logo_inner.png\"  alt=\"Logo\"></td>\r\n            </tr>\r\n          </tbody>\r\n        </table></td>\r\n    </tr>\r\n   \r\n\t  <tr>\r\n\t\t  <td>\r\n\t\t\t  <table class=\"emailer_body\" border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t\t\t  \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t<td>"
				+ body
				+ "</td>\r\n\t\t\t\t\t</tr>\r\n\t\t\t\t     \t\r\n\t\t\t\t  <tr>\r\n\t\t\t\t\t  <td align=\"center\">\r\n\t\t\t\t\t\t  <a href=\"#\">"+"\"Thank you for using DrySign!"+"\" - DrySign Team</a> | <a href=\"#\">Unsubscribe</a>\r\n\t\t\t\t\t\t  <p style=\"font-size: 12px\">If you have any questions or comments, please contact us at <a style=\"font-size: 12px\" href=\"#\">support@drysign.global</a></p>\r\n\t\t\t\t\t  </td>\r\n\t\t\t\t  </tr>\r\n\t\t  \r\n\t\t\t  </table>\r\n\t\t  \t\r\n\t\t  </td>\r\n\t  </tr>\r\n\t \r\n   \r\n  </tbody>\r\n</table>\r\n</body>\r\n</html>";
		String emailStatus = null;
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
			mimeMessage.setContent(emailTemplate, "text/html");
			helper.setTo(to);
			helper.setCc(from);// adding cc to drysign support.
			helper.setSubject(subject);
			helper.setFrom(from, "DrySign");
			mailSender.send(mimeMessage);
			emailStatus = "1";
		} catch (Exception e) {

			logger.error("Error while sending email subscription to " + to + ", error :  " + e);
		}

		logger.info("===========Exit from sendEmail subscription===========");
		return emailStatus;

	}

}
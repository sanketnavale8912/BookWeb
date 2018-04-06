package com.drysign.utility;


import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;


public class SendEmail {

	private static final Logger logger = Logger.getLogger(SendEmail.class);
	public  void SendingEmail(String from , String to, String subject, String body) throws UtilityException
	{
		logger.info(String.format("SendingEmali(from = %s, to = %s, subject = %s, body = %s )", from, to, subject, body));
		
		Properties prop = new Properties();
		InputStream input = null;
		final String username;
		final String password;
		
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			  
		}catch(Exception e){
			logger.error("Error while reading commonsutils file: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file: "+ e.getMessage());
		}
		
		username = prop.getProperty("smtp.username");
	    password = prop.getProperty("smtp.password");  
		logger.info(String.format("read mail properties:  username, password", username,password));
		
		
	    
	    if(from.equals(null))
		{
			from = username;
		}
	    
	    Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

	   
		Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username,password);
					}
				});
	    session.setDebug(true);

	    try {

	        Message message = new MimeMessage(session);
	        message.setFrom(new InternetAddress(username));
	        message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
	        message.setSubject(subject);
	        message.setContent(body, "text/html");
	        
	        
	        Transport.send(message);
	        System.out.println("Email Sent successfully");

	    } catch (MessagingException e) 
	    {
	        throw new UtilityException("Error while send mail: "+e.getMessage());
	    }
	
	}
	
	public  void SendingEmailWithImages(String from , String to, String subject, String body,Map<String, String> mapInlineImages,String FirstName) 
	{
		logger.info(String.format("SendingEmailWithImages(from = %s, to = %s, subject = %s, body = %s )", from, to, subject, body));
		



String emailTemplate = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"+
"<html xmlns=\"http://www.w3.org/1999/xhtml\">"+
"<head>"+
"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />"+
"<title>DrySign</title>"+
"<style type=\"text/css\">"+
"body { "+
"                padding: 0px; "+
"                margin: 0px;"+
"                font-family: Arial, Helvetica, sans-serif; "+
"                font-size:14px;"+
"                line-height: 16px;"+
"                color: #010101;"+
"				text-align:justify;"+
"}"+
"</style>"+
"</head>"+
"<body>"+
"<table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+
"  <tr>"+
"    <td align=\"center\" valign=\"top\"><table  border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #fff; max-width:768px;min-width:320px;\">"+
"      <tr>"+
"        <td align=\"center\" valign=\"top\" style=\"height:30px;\">"+
"        <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"+
"  <tr>"+
"    <td style=\"border-bottom:1px solid #d2d2d2;text-decoration: none;\"></td>"+
"  </tr>"+
"</table>"+
""+
"        </td>"+
"      </tr>"+
"<tr>"+
"        <td align=\"left\" valign=\"top\" style=\"width:90%;\">"+
"        <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"color:#666666;\">"+
"         <tr>"+
"        <td align=\"left\" valign=\"top\">"+
"        <table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+
"					<tr>"+
"						<td valign=\"top\" align=\"right\">"+
"                          <a href=\"http://qa.rule14.com/DrySign/\" target=\"_blank\" title=\"AT&T\" ><img src=\"http://hgmcloud-qa-ws.cloudapp.net/Drysign/img/drysignlogo.png\" width=\"158\" height=\"auto\" /></a>											"+
"						</td>"+
"					</tr>"+
"					"+
"				</table>"+
"        </td>"+
"        </tr>"+
"  <tr>"+
"    <td>"+
"	<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"text-align:justify;\">"+
"		  <tr>"+
"			<td colspan=\"2\"><strong style=\"font-size:16px; line-height:22px;\">Dear "+FirstName+" </strong> ,<br><br></td>"+
"		 </tr>"+
"		 "+
"          <tr>"+
"			<td colspan=\"2\">"+
"				<p style=\"color:#000000; font-size:16px; line-height:22px;\">"+body+"</p>"+
"			 </td>	  "+
"		  </tr>"+
""+
"		"+
"			<tr>"+
"			<td colspan=\"2\">"+
"				<p ><br><strong style=\"font-size:16px; line-height:22px;\"> Warm regards</strong>, <br />Team DrySign</p>"+
"			 </td>	 "+
" 			 "+
"		  </tr>"+
"		  <tr>"+
"			<td colspan=\"2\">"+
"				<p  style=\"color:#991B1E; font-size:12px; line-height:22px;\">&copy;Copyright 2016 SourceHOV L.L.C. All Rights Reserved.</p>"+
"			 </td>	  "+
"		  </tr>"+
"</tr>"+
"   "+
"</table>"+
""+
""+
"        </td>"+
"      </tr>"+
"                </table>"+
"            <!-- FOOTER ENDS -->"+
"        </td>"+
"      </tr>"+
"      "+
"      <tr>"+
"        <td align=\"center\" valign=\"top\" style=\"height:30px;\">"+
"        <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"+
"  <tr>"+
"    <td style=\"border-bottom:1px solid #d2d2d2;text-decoration: none;\"></td>"+
"  </tr>"+
"</table>"+
""+
"        </td>"+
"      </tr>"+
"      </table></td>"+
"  </tr>"+
"</table>"+
"</body>"+
"</html>";
	
	Properties prop = new Properties();
		InputStream input = null;
		final String username;
		final String password;
		
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			  
		}catch(Exception e){
			logger.error("Error while reading commonsutils file: "+ e.getMessage());
			try {
				throw new UtilityException("Error while reading commonsutils file: "+ e.getMessage());
			} catch (UtilityException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		
		username = prop.getProperty("smtp.username");
	    password = prop.getProperty("smtp.password");  
		  
		logger.info(String.format("read mail properties: username, password", username,password));
		
		
	    
	    if(from.equals(null))
		{
			from = username;
		}
	    
	    Properties props = new Properties();

		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

	    Session session = Session.getInstance(props,
	        new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(username, password);
	            }
	        });
	    session.setDebug(true);

	    try {

	    	MimeMessage msg = new MimeMessage(session);
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
			msg.addHeader("format", "flowed");
			msg.addHeader("Content-Transfer-Encoding", "8bit");
			  
			try {
				msg.setFrom(new InternetAddress(username, "NoReply"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			msg.setReplyTo(InternetAddress.parse(username, false));
			
			msg.setSubject(subject, "UTF-8");
			
			msg.setSentDate(new Date());
			
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
			  
			msg.setContent(emailTemplate, "text/html");
			
	        
	        
			 Transport.send(msg);
			 System.out.println("Email Sent successfully");


	    } catch (MessagingException e) 
	    {
	        try {
				throw new UtilityException("Error while send mail: "+e.getMessage());
			} catch (UtilityException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	    }
	
	}
	
	/***
	 * Send Email with Attachment
	 * @author Sanket.Navale
	 * @param from
	 * @param to
	 * @param subject
	 * @param body
	 * @param filename
	 * @param filePath
	 * @throws UtilityException
	 * @throws UnsupportedEncodingException
	 */
	public  void SendingEmailWithAttachment(String from , String to, String subject, String body,String filename,String filePath) throws UtilityException, UnsupportedEncodingException
	{
		//logger.info(String.format("SendingEmali(from = %s, to = %s, subject = %s, body = %s )", from, to, subject, body));
		String emailTemplate = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"+
				"<html xmlns=\"http://www.w3.org/1999/xhtml\">"+
				"<head>"+
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />"+
				"<title>DrySign</title>"+
				"<style type=\"text/css\">"+
				"body { "+
				"                padding: 0px; "+
				"                margin: 0px;"+
				"                font-family: Arial, Helvetica, sans-serif; "+
				"                font-size:14px;"+
				"                line-height: 16px;"+
				"                color: #010101;"+
				"				text-align:justify;"+
				"}"+
				"</style>"+
				"</head>"+
				"<body>"+
				"<table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+
				"  <tr>"+
				"    <td align=\"center\" valign=\"top\"><table  border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #fff; max-width:768px;min-width:320px;\">"+
				"      <tr>"+
				"        <td align=\"center\" valign=\"top\" style=\"height:30px;\">"+
				"        <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"+
				"  <tr>"+
				"    <td style=\"border-bottom:1px solid #d2d2d2;text-decoration: none;\"></td>"+
				"  </tr>"+
				"</table>"+
				""+
				"        </td>"+
				"      </tr>"+
				"<tr>"+
				"        <td align=\"left\" valign=\"top\" style=\"width:90%;\">"+
				"        <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"color:#666666;\">"+
				"         <tr>"+
				"        <td align=\"left\" valign=\"top\">"+
				"        <table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+
				"					<tr>"+
				"						<td valign=\"top\" align=\"right\">"+
				"                          <a href=\"http://qa.rule14.com/DrySign/\" target=\"_blank\" title=\"AT&T\" ><img src=\"http://hgmcloud-qa-ws.cloudapp.net/Drysign/img/drysignlogo.png\" width=\"158\" height=\"auto\" /></a>												"+
				"						</td>"+
				"					</tr>"+
				"					"+
				"				</table>"+
				"        </td>"+
				"        </tr>"+
				"  <tr>"+
				"    <td>"+
				"	<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"text-align:justify;\">"+
				"          <tr>"+
				"			<td colspan=\"2\">"+
				"				<p style=\"color:#991B1E; font-size:16px; line-height:22px;\">"+body+"</p>"+
				"			 </td>	  "+
				"		  </tr>"+
				""+
				"		"+
				"			<tr>"+
				"			<td colspan=\"2\">"+
				"				<p ><br><strong style=\"font-size:16px; line-height:22px;\"> Warm regards</strong>, <br />Team DrySign</p>"+
				"			 </td>	 "+
				" 			 "+
				"		  </tr>"+
				"		  <tr>"+
				"			<td colspan=\"2\">"+
				"				<p  style=\"color:#991B1E; font-size:12px; line-height:22px;\">&copy;Copyright 2016 SourceHOV L.L.C. All Rights Reserved.</p>"+
				"			 </td>	  "+
				"		  </tr>"+
				"</tr>"+
				"   "+
				"</table>"+
				""+
				""+
				"        </td>"+
				"      </tr>"+
				"                </table>"+
				"            <!-- FOOTER ENDS -->"+
				"        </td>"+
				"      </tr>"+
				"      "+
				"      <tr>"+
				"        <td align=\"center\" valign=\"top\" style=\"height:30px;\">"+
				"        <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"+
				"  <tr>"+
				"    <td style=\"border-bottom:1px solid #d2d2d2;text-decoration: none;\"></td>"+
				"  </tr>"+
				"</table>"+
				""+
				"        </td>"+
				"      </tr>"+
				"      </table></td>"+
				"  </tr>"+
				"</table>"+
				"</body>"+
				"</html>";

		Properties prop = new Properties();
		InputStream input = null;
		final String username;
		final String password;
		
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
		    
		}catch(Exception e){
			logger.error("Error while reading commonsutils file: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file: "+ e.getMessage());
		}
		username = prop.getProperty("smtp.username");
	    password = prop.getProperty("smtp.password");  
		  
		logger.info(String.format("read mail properties:  username, password"+username,password));
		
		
	    
	    if(from.equals(null))
		{
			from = username;
		}
	    
	    Properties props = new Properties();
	    props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

	    Session session = Session.getInstance(props,
	        new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(username, password);
	            }
	        });
	    session.setDebug(true);

	    try {

			MimeMessage msg = new MimeMessage(session);
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
			msg.addHeader("format", "flowed");
			msg.addHeader("Content-Transfer-Encoding", "8bit");
			  
			msg.setFrom(new InternetAddress(username, "NoReply"));
			
			msg.setReplyTo(InternetAddress.parse(username, false));
			
			msg.setSubject("DrySign:"+subject, "UTF-8");
			
			msg.setSentDate(new Date());
			
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
			  
			// Create the message body part
			MimeBodyPart  messageBodyPart = new MimeBodyPart();
			
			// Fill the message
			messageBodyPart.setContent(emailTemplate, "text/html");
			 
			// Create a multipart message for attachment
			Multipart multipart = new MimeMultipart();
			
			// Set text message part
			multipart.addBodyPart(messageBodyPart);
			
			// Second part is attachment
			messageBodyPart = new MimeBodyPart();
			//String filename = "D:\\123\\sanket.pdf";
			DataSource source = new FileDataSource(filePath);
			messageBodyPart.setDataHandler(new DataHandler(source));
			messageBodyPart.setFileName(filename);
			multipart.addBodyPart(messageBodyPart);
			
			// Send the complete message parts
			msg.setContent(multipart);
			
			// Send message
			Transport.send(msg);
			System.out.println("Email Sent successfully");

	    } catch (MessagingException e) 
	    {
	        throw new UtilityException("Error while send mail: "+e.getMessage());
	    }
	
	}
}
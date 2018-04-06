package com.drysign.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.drysign.model.SB_SendEmailToSubscribers;
import com.drysign.service.SubscriptionService;
import com.drysign.utility.EmailSender;


public class Schedular  extends SpringBeanAutowiringSupport
{
	private static final Logger logger = Logger.getLogger(Schedular.class);
	@Autowired
	private SubscriptionService subscriptionService;
	@Autowired
	private EmailSender emailSender;
	
	Properties prop = new Properties();
	InputStream input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
	
	@Scheduled(cron="0 0 10 * * *")// daily schedular 10 am
	//@Scheduled(cron="*/5 * * * * *")//  every 5 second
	public void sendEmailToSubscribers() 
	{
	int beforeDays = Integer.parseInt(prop.getProperty("subscription.prior.days"));
	  logger.info("sendEmailToSubscribers() start send email to subscribers before "+beforeDays+" days time: "+new Date());
	  try {
		prop.load(input);
	} catch (IOException e) {
		e.printStackTrace();
	}
	   String serverEmail = prop.getProperty("subscribing.model.username");
	   String url = prop.getProperty("server.url");
	   
	   
	   List<SB_SendEmailToSubscribers> subscribers = subscriptionService.sendEmailToSubscribers(beforeDays);

	   for(SB_SendEmailToSubscribers subscriber : subscribers)
	   {

			String firstName = subscriber.getFirstName();
			String lastName = subscriber.getLastName();
			String firstNameCap = firstName.substring(0, 1).toUpperCase() + firstName.substring(1);
			String lastNameCap = lastName.substring(0, 1).toUpperCase() + lastName.substring(1);
			String fullName = firstNameCap +" "+lastNameCap;
			String subject = "DrySign: Renew subscription  for "+fullName;
			
			//String url = SERVER_URL + "resetPassword?token=" + token + "&userid=" + status + "&email=" + email;
			String body="\t\t\t Hi <b>"+fullName+",</b><br/><br/>\t\t\t<b>Your DrySign plan subscription will expire on the "+subscriber.getEndTime()+", And you have utilised your plan volume "+subscriber.getVolumeInPercent() +"% </b><br />\r\n\t\t\t\t\t\t\t    <p>Your subscription details are: </b><br /><br />\r\n\t\t\t\t\t\t\t <a>"+fullName+"</a>.</p>\r\n\t\t\t\t\t\t\t    <p>Email ID : "+subscriber.getEmail()+"</p>\r\n\t\t\t\t\t\t\t    <p>Subscription plan name : "+subscriber.getPlanName()+"</p>\r\n\t\t\t\t\t\t\t    <p>We hope you decide to move forward with one of our subscription plans.</p><p>To confirm your subscription <a href='"+url+"'>log in</a> and visit the dashboard page. This will ensure uninterrupted access to your account and reporting.</p><br>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
			System.out.println(body);
			emailSender.sendMail(serverEmail, subscriber.getEmail(), subject, body);
			
	   }
	  
	  logger.info("sendEmailToSubscribers() end send email to subscribers before "+beforeDays+" days time: "+new Date());
	  
	}
	
	
	
	
}

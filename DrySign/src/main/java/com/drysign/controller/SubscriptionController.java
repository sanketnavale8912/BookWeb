package com.drysign.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.drysign.model.Registration;
import com.drysign.model.SB_Category;
import com.drysign.model.SB_Plan;
import com.drysign.model.SB_Subscription;
import com.drysign.model.banchub.Billingaddress;
import com.drysign.model.banchub.Carddetails;
import com.drysign.model.banchub.Header;
import com.drysign.model.banchub.InputContainer;
import com.drysign.model.banchub.Transactiondetails;
import com.drysign.service.SubscriptionService;
import com.drysign.utility.CommonUtils;
import com.drysign.utility.DateManipulation;
import com.drysign.utility.EmailSender;
import com.drysign.utility.GlobalFunctions;
import com.drysign.utility.UtilityException;


@Controller
 class SubscriptionController {
	
	@Autowired
	private SubscriptionService subscriptionService;
	/*@Autowired
    private ContactUsValidation contactUsValidation;*/
	@Autowired
	private EmailSender emailSender;
	
	Properties prop = new Properties();
	InputStream input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
	
	
	private static String SERVER_URL ;
	private static String EMAIL_BACKIMAGE ;
	private static String EMAIL_SOURCEHOV_LOGO ;
	private static String EMAIL_DRYSIGN_LOGO ;
	private static String SUPPORT_EMAIL;
	private static final Logger logger = Logger.getLogger(SubscriptionController.class);
	String className = this.getClass().getSimpleName();
	
		public SubscriptionController() 
		{
			try {
				SERVER_URL = new GlobalFunctions().getServerUrl();
				EMAIL_BACKIMAGE=new GlobalFunctions().getEmailBackGroundImage();
				EMAIL_SOURCEHOV_LOGO=new GlobalFunctions().getEmailSourceHOVlogo();
				EMAIL_DRYSIGN_LOGO=new GlobalFunctions().getEmailDrySignLogo();
				SUPPORT_EMAIL = new GlobalFunctions().getSupportUrl();
				
			} catch (UtilityException e) {
				logger.error("Error while getting upload path: "+e.getMessage());
			}
		}
	
	
	@RequestMapping(value="/pricing", method = RequestMethod.GET)
	public String pricing(Model model)
	{
		String classMethod = className+ ":  pricing()";
		logger.info(String.format("Enter into "+classMethod));
		
		List<SB_Category> categories = null;
		try{
		boolean flag = validSubscribingModel();
		if(flag)
		{
			Map<String,String> map = GlobalFunctions.getSubscriptionCredentials();
			categories = subscriptionService.getCategories(map.get("username"),map.get("password"));
			logger.info(categories);
		}
		model.addAttribute("categories", categories);
		}catch(Exception e){logger.error("Error while calling pricing methdo: "+e);}
		
		logger.info("exit from "+classMethod);
		return "category";
	}
	
	
	@RequestMapping(value="/termsandcondition", method = RequestMethod.GET)
	public String termsandcondition(Model model)
	{
		String classMethod = className+ ":  termsandcondition()";
		logger.info(String.format("Enter into "+classMethod));
		
		logger.info("exit from "+classMethod);
		return "termsandcondition";
	}
	
	/*@RequestMapping(value="/cart", method = RequestMethod.GET)
	public ModelAndView cart(@ModelAttribute("command") ContactUs contactUs)
	{
		SubscriptionPlan subscriptionPlan = subscriptionService.getSubscrptionPlan(product);
		Map<String, SubscriptionPlan> map = new HashMap<String,SubscriptionPlan>();
		map.put("subscriptionPlan", subscriptionPlan);
		//Map<String ,Object> map = new HashMap<String,Object>();
    	//map.put("registration", contactUs);
		return new ModelAndView("/1.0/cart");
	}
	
	@RequestMapping(value="/cartSubmit", method = RequestMethod.POST)
	public ModelAndView cartsubmit(@ModelAttribute("command") ContactUs contactUs, BindingResult result)
	{
		Map<String ,Object> map = new HashMap<String,Object>();
		contactUsValidation.validate(contactUs, result);
		if(result.hasErrors()){
			return new ModelAndView("/1.0/cart");
		}

		try{
		String body=""
				+ "New contact us enquiry from DrySign<br/><br/>"
				+ "Details are:<br/><br/>"
				+ "First Name : "+contactUs.getFirstName()+"<br/>"
				+ "Last Name : "+contactUs.getLastName()+"<br/>"
				+ "Email : "+contactUs.getEmail()+"<br/>"
				+ "Company : "+contactUs.getCompany()+"<br/>"
				+ "Message : "+contactUs.getMessage()+"<br/>";
		String subject = "DrySign: Contact us";
		Map<String, String> inlineImages = new HashMap<String, String>();
		inlineImages.put("image1", EMAIL_BACKIMAGE);
		inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
		inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
		new SendEmail().SendingEmailWithImages("", "support@drysign.me", subject, body, inlineImages,"Admin");
		
		contactUs.setFirstName(null);
		contactUs.setLastName(null);
		contactUs.setEmail(null);
		contactUs.setCompany(null);
		contactUs.setMessage(null);
		map.put("msg", "1");
		}catch(Exception e){
			logger.error(e);
			map.put("msg", e);
		}
		
		return new ModelAndView("/1.0/cart",map);
	}
	*/
	
	@RequestMapping("/plans")
	public ModelAndView plans(@RequestParam("category_name") String categoryName, @RequestParam("category") String categoryId)
	{
		String classMethod = className+ ":  plans()";
		logger.info(String.format("Enter into "+classMethod));
		Map<String,List<SB_Plan>> map = new HashMap<String,List<SB_Plan>>();
		
		try{
		Map<String,String> cred = GlobalFunctions.getSubscriptionCredentials();
		List<SB_Plan> plans = subscriptionService.getSubscriptionPlans(cred.get("username"),cred.get("password"),categoryName,categoryId);
		map.put("plans", plans);
		
		}catch(Exception e){logger.error("Error while calling plans: "+e);}
		
		logger.info("exit from "+classMethod);
		return new ModelAndView("plans",map);
	}
	
	public boolean validSubscribingModel()
	{
		String classMethod = className+ ":  validSubscribingModel()";
		logger.info(String.format("Enter into "+classMethod));
		
		boolean flag = false;
		try{
		Map<String,String> map = GlobalFunctions.getSubscriptionCredentials();
	  	flag = subscriptionService.validSubscribingModel(map.get("username"),map.get("password"));
		}catch(Exception e){logger.error("Error while getting ValidSuubscribingModel: "+e);}
	  	logger.info("exit from "+classMethod);
		return flag;
	}
	
	
	
	
	@RequestMapping(value="/checkout", method = RequestMethod.GET)
	public String checkout(Model model, @RequestParam("plan") String token)
	{
		String classMethod = className+ ":  checkout()";
		logger.info(String.format("Enter into "+classMethod));
		try{
		Map<String,String> map = GlobalFunctions.getSubscriptionCredentials();
		SB_Plan plan = subscriptionService.getSubscriptionPlan(map.get("username"), map.get("password"), token);
		model.addAttribute("plan",plan);
		model.addAttribute("token",token);
		}catch(Exception e){
			logger.error("Error while getting checkout: "+e);
		}
		logger.info("exit from "+classMethod);
		return "checkout";
	}
	
	
	
	@RequestMapping(value="/paymentresponse", method = RequestMethod.GET)
	public String paymentresponse(Model model, HttpServletRequest request)
	{
		String classMethod = className+ ":  paymentresponse()";
		logger.info(String.format("Enter into "+classMethod));
		
		String msg = "";
		String prodcut_token = request.getParameter("product");
		String transactionId = request.getParameter("transactionid");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		/*String paymetnMethod = null;
		String gatewayResponse = null;*/
		SB_Plan plan = null;
		java.sql.Timestamp todayDate = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
		
		Registration user = null;
		try{
		if((auth instanceof AnonymousAuthenticationToken) || auth==null)
		{
			msg="Kindly login to proceed.";
			
		}else if(prodcut_token==null || prodcut_token.isEmpty())
		{
			msg = "Kindly select plan to proceed.";
		}else
		{
			user =(Registration) auth.getPrincipal();
			Map<String,String> map = GlobalFunctions.getSubscriptionCredentials();
			plan = subscriptionService.getSubscriptionPlan(map.get("username"), map.get("password"), prodcut_token);
			
			if(plan.getId() == 0){
				msg = "No plan available.";
			}/*else
			{
				String checkPlanActiveOrNot = checkPlanActiveOrNot(user.getId(),todayDate);
				if(checkPlanActiveOrNot !=null && checkPlanActiveOrNot.equals("true"))
				{
					msg = "You already have active plan. You cant subscribe until your current plan over.";
				}else{
					msg = subscriptionService.createSubscripton(user.getId(),transactionID,paymetnMethod,gatewayResponse,plan);
				}
				
			}*/
		}
		}catch(Exception e){logger.error("Error while getting paymentresponse: "+e);}
		
		model.addAttribute("plan",plan);
		model.addAttribute("msg",msg);
		model.addAttribute("todayDate",todayDate);
		model.addAttribute("transactionID",transactionId);
		model.addAttribute("user",user);
		
		logger.info("exit from "+classMethod);
		/*if(msg !=null && msg.equals("success"))
		{
			return "paymentresponse";
		}else{
			return "paymenterror";
		}*/
		return "paymentresponse";
	}
	
	public String checkPlanActiveOrNot(int userId, Timestamp todayDate)
	{
		String classMethod = className+ ":  checkPlanActiveOrNot()";
		logger.info(String.format("Enter into "+classMethod));
		
		String status = "false";
		try{
		SB_Subscription sub = subscriptionService.checkValidSubscription(userId);
		if(sub !=null)
		{
			float days = new DateManipulation().daysCalculation(sub.getSubscriptionEndTime());
			if( (sub.getCreditedDocuments()-sub.getUsedDocuments())<= 0 ||  days <= 0)
			{status = "true";}
		}else{status = "true";}
		}catch(Exception e){
			status = e.getMessage();
			logger.error("Error while checkPlanAciveOrNot: "+e);
		}
		
		logger.info("exit from "+classMethod);
		return status;
	}
	
	
	/*
	* comment: start code of payment gateway
	* developer : matadeen sikarawar
	*/
	
		
	
	@RequestMapping(value="/checkusersession", method = RequestMethod.POST)
	@ResponseBody
	public String checkUserSession(@RequestBody Carddetails card,@RequestParam("token") String token ,Model model)
	{
		String classMethod = className+ ":  checkUserSession()";
		logger.info(String.format("Enter into "+classMethod));
		
		String transactionID = "";
		String gatewayResponse = "";
		String flag = "notlogin";
		String active = "0";
		java.sql.Timestamp todayDate = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
		try{
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth == null)
		{
			flag = "notlogin";
		}else if(!(auth instanceof AnonymousAuthenticationToken))
		{
			flag = "loggedin";
			Registration user =(Registration) auth.getPrincipal();
			String checkPlanActiveOrNot = checkPlanActiveOrNot(user.getId(),todayDate);
			if( checkPlanActiveOrNot!=null && !checkPlanActiveOrNot.equals("true"))
			{
				flag="activeplan";
			}else{
				
				Map<String,String> map = GlobalFunctions.getSubscriptionCredentials();
				SB_Plan plan = subscriptionService.getSubscriptionPlan(map.get("username"), map.get("password"), token);
				
				
				String paymetnMethod = "";
				java.sql.Timestamp validTill = CommonUtils.addDays(Integer.parseInt(plan.getDuration().getTime()));
				String clientReferId = UUID.randomUUID().toString();
				
				String createSubscription = subscriptionService.createSubscripton(user.getId(),transactionID,paymetnMethod,gatewayResponse,plan,clientReferId,todayDate,validTill,active);
				if(createSubscription !="" )
				{
					String paymentJson = modelPrepare(card,user,plan,todayDate,clientReferId);
					Map<String, String> payment = payment(paymentJson);
					if(payment != null)
					{   
						
						int subscriptionId = Integer.parseInt(createSubscription);
						paymetnMethod = "BancHub";
						
						gatewayResponse = payment.get("status").equalsIgnoreCase("success") ? "success" : payment.get("error_desc");
						transactionID = payment.get("transaction_id");
						active = payment.get("status").equalsIgnoreCase("success") ? "1" : "0";
						String updatestatus = subscriptionService.updateSubscription(subscriptionId,gatewayResponse,transactionID,active,paymetnMethod);
						if(updatestatus !="1"){
							flag = "Problem while updating transaction status in database.";
						}
						flag = "Your Transaction details: <br>";
						if(gatewayResponse == "success"){
							flag += " Status: "+gatewayResponse;
							flag += " <br> Transaction Id: "+transactionID;
							
							String subscriberId= "DRYSIGN"+subscriptionId;
							String firstName = user.getFirstName();
							String lastName = user.getLastname();
							String firstNameCap = firstName.substring(0, 1).toUpperCase() + firstName.substring(1);
							String lastNameCap = lastName.substring(0, 1).toUpperCase() + lastName.substring(1);
							String fullName = firstNameCap +" "+lastNameCap;
							String subject = "DrySign: Subscription for "+fullName;
							
							//String url = SERVER_URL + "resetPassword?token=" + token + "&userid=" + status + "&email=" + email;
							String body="\t\t\t<b>Thank you for subscribing to our service.</b><br />\r\n\t\t\t\t\t\t\t    <p>Your subscription details are: </b><br />\r\n\t\t\t\t\t\t\t <a>"+fullName+"</a>.</p>\r\n\t\t\t\t\t\t\t    <p>Email ID : "+user.getEmail()+"</p>\r\n\t\t\t\t\t\t\t    <p>Subscription ID : "+subscriberId+"</p>\r\n\t\t\t\t\t\t\t    <p>Transaction ID : "+transactionID+"</p>\r\n\t\t\t\t\t\t\t    <p>User Refer ID : "+clientReferId+"</p>\r\n\t\t\t\t\t\t\t    <p>Plan : "+plan.getName()+"</p></p>\r\n\t\t\t\t\t\t\t    <p>Plan Price : "+plan.getPrice() +" "+plan.getCurrency().getName()+"</p>\r\n\t\t\t\t\t\t\t\t<p>Your subscription is valid from "+todayDate+" to "+validTill+".</p><br>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
							emailSender.sendMail(SUPPORT_EMAIL, user.getEmail(), subject, body);
							
							
						}else{
							flag += "Error Message: "+gatewayResponse;
						}
						
								
						
					}else{
						flag = "Input details invalid.";
					}
					
				}
				else{
					flag = createSubscription;
				}
			}
			
		}
		}catch(Exception e){
			flag = "Error while getting checkUserSession: "+e;
			logger.error(flag);
		}
		logger.info("exit from "+classMethod);
		//"{\"status\":\""+gatewayResponse+"\",\"message\":\""+flag+"\",\"transactionid\":\""+transactionID+"\"}";
		
		return gatewayResponse+":"+transactionID+":"+flag;
	}

	
	
	
	public Map<String, String> payment(String paymentJson)
	{
		Map<String, String> paymentResponse = new HashMap<String,String>();
		try {
			prop.load(input);
			URL url = new URL(prop.getProperty("payment.gateway.url.cardpayment"));
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");			

			OutputStream os = conn.getOutputStream();
			os.write(paymentJson.getBytes());
			os.flush();
			
			BufferedReader br;
			if (200 <= conn.getResponseCode() && conn.getResponseCode() <= 299) {
			    br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			} else {
			    br = new BufferedReader(new InputStreamReader((conn.getErrorStream())));
			}

			

			String output;
			while ((output = br.readLine()) != null) 
			{
				logger.info("paymentJson: "+paymentJson);
				logger.info("result: "+output);
				
				DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
				InputSource src = new InputSource();
				src.setCharacterStream(new StringReader(output));

				Document doc = builder.parse(src);
				String status = doc.getElementsByTagName("a:status").item(0).getTextContent();
				String transaction_id = doc.getElementsByTagName("a:transaction_id").item(0).getTextContent();
				String error_desc = doc.getElementsByTagName("a:error_desc").item(0).getTextContent();
				
				
				paymentResponse.put("status", status);
				paymentResponse.put("transaction_id", transaction_id);
				paymentResponse.put("error_desc", error_desc);
			}
			
			conn.disconnect();
		}catch (MalformedURLException e){logger.error("Error while calling payment method MalformedURLException: "+e);}
		catch (IOException e) {logger.error("Error while calling payment method IOException: "+e);} 
		catch (SAXException e) {logger.error("Error while calling payment method SAXException: "+e);} 
		catch (ParserConfigurationException e) {logger.error("Error while calling payment method ParserConfigurationException: "+e);}
		catch(Exception e){logger.error("Error while calling payment: "+e);}
		return paymentResponse;
		
	}
	
	
	public String modelPrepare(Carddetails card, Registration user, SB_Plan plan, Timestamp todayDate, String clientReferId) 
	{
		String accessToken = accessToken();
		String jsonString = null;
		try {
			prop.load(input);
			Header header = new Header();
			header.setSession_token(accessToken);
			header.setUsername(prop.getProperty("payment.gateway.username"));
			
			card.setCard_present("1");
			card.setPayment_intent("0");
			
			Transactiondetails transaction = new Transactiondetails();
			transaction.setTotal_amount(plan.getPrice());
			transaction.setCurrency(plan.getCurrency().getName()+"");
			transaction.setClient_referid(clientReferId);
			transaction.setPurchase_level("1");
			transaction.setTransaction_date(todayDate+"");
			transaction.setTransaction_description("DrySign plan subscription");
			
			Billingaddress billing = new Billingaddress();
			billing.setBilling_username(user.getEmail());
			billing.setUser_zip(user.getPincode());
			billing.setUser_city(user.getCity());
			billing.setUser_state(user.getState());
			billing.setUser_address1(user.getAddress());
			billing.setUser_address2(user.getCountry());
			
			InputContainer container = new InputContainer();
			container.setHeader(header);
			container.setCarddetails(card);
			container.setTransactiondetails(transaction);
			container.setBillingaddress(billing);
			
			ObjectMapper mapper = new ObjectMapper();
			
			jsonString = mapper.writeValueAsString(container);
		} catch (IOException e) {
			logger.error("Error while modelPrepare: "+e);
		}
		logger.info("Generated jsonString: "+jsonString);
		return jsonString;
		
	}
	
	public String accessToken()
	{

	   String accessToken = null;
	   
	   try {
		prop.load(input);
		String apikey = prop.getProperty("payment.gateway.apikey");
		String username = prop.getProperty("payment.gateway.username");
		URL url = new URL(prop.getProperty("payment.gateway.url.authorize"));
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setDoOutput(true);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json");
		
		String input = "{\"userdetails\":{\"apikey\":\""+apikey+"\",\"username\": \""+username+"\"}}";

		OutputStream os = conn.getOutputStream();
		os.write(input.getBytes());
		os.flush();
		
		BufferedReader br;
		if (200 <= conn.getResponseCode() && conn.getResponseCode() <= 299) {
		    br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
		} else {
		    br = new BufferedReader(new InputStreamReader((conn.getErrorStream())));
		}		

		String output;
		while ((output = br.readLine()) != null) 
		{
			
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource src = new InputSource();
			src.setCharacterStream(new StringReader(output));

			Document doc = builder.parse(src);
			accessToken = doc.getElementsByTagName("AuthorizeResponse").item(0).getTextContent();	
		}

		conn.disconnect();

	  } catch (MalformedURLException e) {
		  logger.error("Error while accessToken MalformedURLException: "+e);
	  } catch (IOException e) {
		  logger.error("Error while accessToken IOException: "+e);	 
		  }catch (ParserConfigurationException e) {
			  logger.error("Error while accessToken ParserConfigurationException: "+e);
		} catch (SAXException e) {
			  logger.error("Error while accessToken SAXException: "+e);
	}
	return accessToken;
	}
	
	
	/*
	* comment: end code of payment gateway
	* developer : matadeen sikarawar
	*/
	
}

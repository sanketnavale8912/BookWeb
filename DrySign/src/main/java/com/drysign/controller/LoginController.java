package com.drysign.controller;

import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.drysign.dao.DaoException;
import com.drysign.dao.RegistrationDao;
import com.drysign.efa.ClientEFA;
import com.drysign.model.ApplicationDocument;
import com.drysign.model.Document;
import com.drysign.model.DocumentField;
import com.drysign.model.Pixel;
import com.drysign.model.Registration;
import com.drysign.model.ResetPassword;
import com.drysign.model.SignerData;
import com.drysign.service.ApplicatonService;
import com.drysign.model.SB_Plan;
import com.drysign.model.SB_Subscription;
import com.drysign.model.Signature;
import com.drysign.service.RegisterService;
import com.drysign.service.SubscriptionService;
import com.drysign.utility.ApplicationUtils;
import com.drysign.utility.CommonUtils;
import com.drysign.utility.DateManipulation;
import com.drysign.utility.DocUtils;
import com.drysign.utility.EmailSender;
import com.drysign.utility.GlobalFunctions;
import com.drysign.utility.ImageType;
import com.drysign.utility.Signer;
import com.drysign.utility.UtilityException;
import com.google.gson.Gson;

@Controller
@RequestMapping("/")
public class LoginController {
	private static String SERVER_URL,TEMP_DIGITAL_URL,SUPPORT_EMAIL,TYPE_PATH=null;

	@Autowired
	private RegisterService registerService;
	
	@Autowired
	private ApplicatonService applicatonService;
	
	@Autowired
	private EmailSender emailSender;
	
	@Autowired
	private SubscriptionService subscriptionService;
	
	private static final Logger logger = Logger.getLogger(LoginController.class);

	public LoginController() {
		try {
			TYPE_PATH = new GlobalFunctions().getTypePath();
			TEMP_DIGITAL_URL = new GlobalFunctions().getTempAppDigitalSignPdfPath();
			SERVER_URL = new GlobalFunctions().getServerUrl();
			SUPPORT_EMAIL = new GlobalFunctions().getSupportUrl();
		} catch (UtilityException e) {
			// logger.error("Error while getting upload path: "+e.getMessage());
		}
	}

	@Autowired
	private RegistrationDao registerDao;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request,
			@RequestParam(value = "logout", required = false) String logout) {
		ModelAndView model = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken) && auth != null) {
			return new ModelAndView("redirect:/app/dashboard");
		}
		if (logout != null) {
			//model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");
		return model;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView login(ModelMap model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth == null) {
			return new ModelAndView("redirect:/login");
		} else if (!(auth instanceof AnonymousAuthenticationToken)) {
			return new ModelAndView("redirect:/app/dashbaord");
		} else {
			return new ModelAndView("redirect:/login");
		}
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index() {
		return new ModelAndView("index");

	}
	
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(RedirectAttributes redirectAttributes, ModelMap model, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("start logged out");
		removeAuthentication(request, response);

		redirectAttributes.addAttribute("logout", "logout");
		redirectAttributes.addFlashAttribute("logout", "logout");
		System.out.println("stop logged out");
		return "redirect:/login";
	}

	private static void removeAuthentication(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}

		HttpSession session = request.getSession();
		if (session != null) {
			session.invalidate();
			System.out.println("session is invalidate ===== ");
		} else {
			System.out.println("session is null already ===== ");
		}
	}

	@RequestMapping(value = { "/web" }, method = RequestMethod.GET)
	public ModelAndView web(HttpServletRequest request) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	if(auth == null)
		{
			return new ModelAndView("redirect:/login");
		}else
		{   
			Registration registrtaion = (Registration) auth.getPrincipal();
			String profilePic=applicatonService.getPic(registrtaion.getId(), 1);
			registrtaion.setPhoto(profilePic);
			if(registrtaion.getRole().equals("ROLE_ADMIN")){
				return new ModelAndView("redirect:/admin/view");
			}
			return new ModelAndView("redirect:/app/dashboard");
		}
	}

	@RequestMapping(value = "/forgotPassword", method = RequestMethod.POST)
	public @ResponseBody String forgotPassword(HttpServletRequest request) {
		String status = "";
		String email = request.getParameter("forgotemail");
		if (email != null) {
			String token = new GlobalFunctions().uniqueToken();
			status = registerDao.forgotPassword(email, token);
			if (status.equals("error")) {
				status = "Can't find that email, sorry.";
			} else {
				String subject = "DrySign: Reset Password";
				String url = SERVER_URL + "resetPassword?token=" + token + "&userid=" + status + "&email=" + email;
				String body="\t\t\t<b>Reset your password,</b><br />\r\n\t\t\t\t\t\t\t    <p>You are receiving this email because a request was made to reset the password for your DrySign account <a>"+email+"</a>.</p>\r\n\t\t\t\t\t\t\t    <p>If you did not ask to reset your password, then you can ignore this email and your password will not be changed.</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Reset Password</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
				try {
					status=emailSender.sendMail(SUPPORT_EMAIL, email, null,subject, body,url);
				} catch (Exception e) {
					// logger.error("Error while sending email to user:"+email+"
					// when forgot password: "+e);
				}
			}
		} else {
			status = "Please enter valid email address.";
		}

		return status;
	}

	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> registration(@RequestBody Registration registration,HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String uniqueID = new GlobalFunctions().uniqueToken();
		registration.setEmail_verification_token(uniqueID);
		registration.setEmail_verification_token(uniqueID);
		registration.setUser_type(1);
		registration.setStatus(0);
		registration.setDate(new DateManipulation().getMyDate());
		registration.setRole("ROLE_USER");
		registration.setPassword(ApplicationUtils.encryptPassword(registration.getPassword()));
		if (registration != null) {
			try {
				if (registerService.addRegistration(registration) == 1) {
					
					String url = SERVER_URL + "verify?token=" + uniqueID + "&email=" + registration.getEmail();
					
					String body = " \t\t\t<b>HI "+registration.getFirstName()+" "+registration.getLastname()+",</b><br />\r\n\t\t\t\t\t\t\t   <p>Thank you for registering with DrySign.</p>\r\n\t\t  <p>Kindly verify your account by clicking on this link :</p>\r\n\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t <a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Verify Account</a></p>\r\n\t\t\t  \r\n\t\t\t  <p>The Team at DrySign.</p>";
					String subject = "DrySign: Registration";
					
					String status=emailSender.sendMail(SUPPORT_EMAIL,registration.getEmail(),null, subject, body,url);
					if(status =="1"){
						map.put("msg", status);
						
					}else{
						map.put("msg", "Problem in Registration.");
					}
				} else if (registerService.addRegistration(registration) == 2) {
					map.put("msg",
							"The user is already registered. Please login to the system using the registered credentials.");
				} else if (registerService.addRegistration(registration) == 3) {
					map.put("msg", "Problem in Registration.");
				}
			} catch (DaoException e) {
				// logger.error("Error while Registration: "+e);
			}
		}
		return map;
	}

	public String creteTrialSubscription(Registration user,boolean flagForRenew)
	{
		Map<String,String> map = GlobalFunctions.getSubscriptionCredentials();
		String planName = GlobalFunctions.getPlanName(user.getEmail(),flagForRenew);
		
		String paymetnMethod = "";
		String active = "1";
		String clientReferId = UUID.randomUUID().toString();
		String transactionID = null;
		String gatewayResponse = null;
		String createSubscription = null;
		try{
		SB_Plan plan = subscriptionService.getTrialPlan(map.get("username"), map.get("password"), planName);
		java.sql.Timestamp todayDate = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
		java.sql.Timestamp validTill = CommonUtils.addDays(Integer.parseInt(plan.getDuration().getTime()));
		
		createSubscription = subscriptionService.createSubscripton(user.getId(),transactionID,paymetnMethod,gatewayResponse,plan,clientReferId,todayDate,validTill,active);
		}catch(Exception e){logger.error("Error while createTrialSubscription: "+e);}
		return createSubscription;
	}
	
	@RequestMapping(value = "/renew", method = RequestMethod.POST)
	@ResponseBody
	public String renew() 
	{
		String message;
		try{
			Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();			
			String status = "false";
			try{
			SB_Subscription sub = subscriptionService.checkValidSubscription(user.getId());
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
			
			if(status.equals("true"))
			{
				creteTrialSubscription(user,true);
				message = "true";
			}else{
				message = "You already have active plan. You cant subscribe until your current plan over.";
			}
		}catch(Exception e){
			message = "Error while renew subscription :" +e;
			logger.error("Error while renew subscription :" +e);
		}
		return message;
	}
	
	@RequestMapping(value = "/verify", method = RequestMethod.GET)
	public ModelAndView verify(@RequestParam("token") String token, @RequestParam("email") String email) {
		String message = null;
		int status = 0;
		if (token.equals(null)) {
			message = "Token cant be null.";
		} else {
			try {
				status = registerService.verifyRegistration(token, email);
			} catch (DaoException e) {
				logger.error("Error while getting verify registration: "+e);
			}
			if (status == 1) {
				message = "1";
				try {
					Registration user =registerService.loginCall(email);
					creteTrialSubscription(user,false);
				} catch (DaoException e) {
					logger.error("Error while getting registration: "+e);
				}
				
			} else if (status == 2) {
				message = "Invalid Token.";
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("message", message);
		return new ModelAndView("verify", map);
	}

	@RequestMapping(value = "/resetPassword", method = RequestMethod.GET)
	public @ResponseBody ModelAndView resetPassword(@ModelAttribute("command") ResetPassword resetPassword,
			HttpServletRequest request) {

		String email = request.getParameter("email");
		String userid = request.getParameter("userid");
		String token = request.getParameter("token");

		resetPassword.setEmail(email);
		resetPassword.setUserid(userid);
		resetPassword.setToken(token);
		String flag = registerService.checkValidResetPassword(resetPassword);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("resetPassword", resetPassword);
		model.put("flag", flag);
		model.put("email",email);
		model.put("userid",userid);
		model.put("token",token);
		return new ModelAndView("resetPassword", model);

	}

	//
	@RequestMapping(value = "/updateResetPassword", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateResetPassword(@RequestBody ResetPassword resetPassword,
			HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();

		String flag = registerService.checkValidResetPassword(resetPassword);
		if (flag != null && flag.equals("1")) {
			int status = registerService.updateResetPassword(resetPassword);
			if (status > 0) {
				map.put("msg", "1");
			} else {
				map.put("msg", "Error while reseting password.");
			}
		}else{
			map.put("msg", "Invalid Token");
		}
		return map;
	}
	
	@RequestMapping(value = "/submitquery", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String submitquery(@RequestParam("name") String name,@RequestParam("email") String email,@RequestParam("message") String message) {
		String status = "";
		//String name = n.getName();
	//	String email = n.getEmail();
		//String message = n.getMessage();
		
			String token = new GlobalFunctions().uniqueToken();
				String subject = "DrySign Query from - "+name+" and email id - "+email;
			//	String url = SERVER_URL + "resetPassword?token=" + token + "&userid=" + status + "&email=" + email;
			//	String body="\t\t\t<b>Reset your password,</b><br />\r\n\t\t\t\t\t\t\t    <p>You are receiving this email because a request was made to reset the password for your DrySign account <a>"+email+"</a>.</p>\r\n\t\t\t\t\t\t\t    <p>If you did not ask to reset your password, then you can ignore this email and your password will not be changed.</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Reset Password</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
				try {
					status=emailSender.sendMail( email,SUPPORT_EMAIL,null, subject, message,null);
				} catch (Exception e) {
					// logger.error("Error while sending email to user:"+email+" when forgot password: "+e);
				}
			
		

		return status;
	}

	@RequestMapping(value = "/signDocument1")
	public ModelAndView signDocument1(@RequestParam("key") String key,RedirectAttributes attr, HttpServletRequest request) throws DaoException 
	{
		ModelAndView model = new ModelAndView();
		String fileName=null;
		if(key !=null){
			SignerData signer=applicatonService.checkValidSigneKey(key);
			if(signer.getDocStatus().equals("104")){
				model.addObject("title", "SignDocument");
				model.addObject("flag", "401");
				model.addObject("errorMsg", "Invalid Link");
				model.setViewName("404page");
			}
			else if(signer.getSignStatus() == 1){
				
				model.addObject("title", "SignDocument");
				model.addObject("flag", "401");
				model.addObject("errorMsg", "Invalid Link");
				model.setViewName("404page");
			}else if(signer.getDocId() !=0 && signer.getSignStatus() ==0 && !signer.getDocStatus().equals("104")){
				File f = null;
				try {
					ApplicationDocument doc = applicatonService.getDocument(signer.getDocId(),signer.getRequestBy());
					
					if(doc.getElectronicId() == null){
						ClientEFA c=new ClientEFA();
						fileName=c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getOriginalId());
						f=new File(fileName); 
						
					}else{
						ClientEFA c=new ClientEFA();
						fileName=c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getElectronicId());
						f=new File(fileName); 
					}
					if (f.exists()) {
						
						String subject =signer.getSignerName()+" has viewed "+doc.getSubject();
						String body="\t\t\t<b>Hi "+signer.getRequestName()+",</b><br />\r\n\t\t\t\t\t\t\t<p>"+signer.getSignerName()+" has viewed the document.We'll let you know once the document has been signed.</p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
						emailSender.sendMail1(SUPPORT_EMAIL, signer.getRequestEmail(), doc.getCc(), subject, body);
						Pixel p = ApplicationUtils.getPageCount(f);
						model.addObject("numpages", "" + p.getPageCount());
						model.addObject("pwidth",p.getWidth());
						model.addObject("pheight",p.getHeight());
						model.addObject("filename", doc.getFileName());
						model.addObject("fileId", doc.getId());
						model.addObject("redirecturl", "");
						model.addObject("envelopeId", doc.getEnvelopeId());
						model.addObject("userId", doc.getUserId());
						model.addObject("email", signer.getSignerEmail());
						model.addObject("signerName", signer.getSignerName());
						model.addObject("key", key);
						model.addObject("projectName", signer.getProjectName());
						model.addObject("title", "SignDocument");
						model.addObject("returnURL", doc.getDocUrl());
						model.addObject("efaFile", fileName);
						
						//fileNaME efa
						model.setViewName("signDocument");
					
					} else {
						model.addObject("errorMsg", "File not found");
						model.addObject("flag", "401");
						model.setViewName("404page");
					}
				} catch (Exception e) {
					model.addObject("errorMsg", "File not found");
					model.addObject("flag", "401");
					model.setViewName("404page");
				}finally{
					if(f!=null){f.delete();}
				}
				
			}else{
				model.addObject("flag", "404");
				model.addObject("errorMsg", "Page not found");
				model.addObject("title", "PageNotFound");
				model.setViewName("404page");
			}
		}else{
			model.addObject("flag", "404");
			model.addObject("errorMsg", "Page not found");
			model.addObject("title", "PageNotFound");
			model.setViewName("404page");
		}
		return model;
	}
	@RequestMapping(value = "/signDocument")
	public ModelAndView signDocument(@RequestParam("key") String key,RedirectAttributes attr, HttpServletRequest request) throws DaoException 
	{
		ModelAndView model = new ModelAndView();
		//String fileName=null;
		if(key !=null){
			SignerData signer=applicatonService.checkValidSigneKey(key);
			if(signer.getDocStatus() ==null){
				model.addObject("title", "SignDocument");
				model.addObject("flag", "401");
				model.addObject("errorMsg", "Invalid Link");
				model.setViewName("404page");
			}else if(signer.getDocStatus().equals("104")){
				model.addObject("title", "SignDocument");
				model.addObject("flag", "401");
				model.addObject("errorMsg", "Invalid Link");
				model.setViewName("404page");
			}
			else if(signer.getSignStatus() == 1){
				model.addObject("title", "SignDocument");
				model.addObject("flag", "401");
				model.addObject("errorMsg", "Invalid Link");
				model.setViewName("404page");
			}else if(signer.getDocId() !=0 && signer.getSignStatus() ==0 && !signer.getDocStatus().equals("104")){
				try {
					 ApplicationDocument doc = applicatonService.getDocument(signer.getDocId(),signer.getRequestBy());
					 Registration user = registerService.getUser(signer.getRequestEmail());
					 if(user.getIsEmailAlert()==1){
							String subject =signer.getSignerName()+" has viewed "+doc.getSubject();
							String body="\t\t\t<b>Hi "+signer.getRequestName()+",</b><br />\r\n\t\t\t\t\t\t\t<p>"+signer.getSignerName()+" has viewed the document.We'll let you know once the document has been signed.</p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
							emailSender.sendMail1(SUPPORT_EMAIL, signer.getRequestEmail(), doc.getCc(), subject, body);
					}
					
					 	Signature signature=applicatonService.getSignature(null, signer.getSignerEmail());
					 	if(signature !=null){
					 		model.addObject("signature",signature.getSignature());
					 		model.addObject("signatureType",signature.getSignType());
					 		model.addObject("isSaved","YES");
					 	}else{
					 		model.addObject("isSaved","NO");
					 	}
					 	
						model.addObject("filename", doc.getFileName());
						model.addObject("fileId", doc.getId());
						model.addObject("redirecturl", "");
						model.addObject("envelopeId", doc.getEnvelopeId());
						model.addObject("docId", doc.getId());
						model.addObject("userId", doc.getUserId());
						model.addObject("email", signer.getSignerEmail());
						model.addObject("signerName", signer.getSignerName());
						model.addObject("key", key);
						model.addObject("projectName", signer.getProjectName());
						model.addObject("title", "SignDocument");
						model.addObject("returnURL", doc.getDocUrl());
						model.addObject("signRequestedBy", signer.getRequestBy());
						model.setViewName("signDocument");
				 } catch (Exception e) {
					model.addObject("errorMsg", "File not found");
					model.addObject("flag", "401");
					model.setViewName("404page");
				}
			}else{
				model.addObject("flag", "404");
				model.addObject("errorMsg", "Page not found");
				model.addObject("title", "PageNotFound");
				model.setViewName("404page");
			}
		}else{
			model.addObject("flag", "404");
			model.addObject("errorMsg", "Page not found");
			model.addObject("title", "PageNotFound");
			model.setViewName("404page");
		}
		return model;
	}
	@RequestMapping(value = "/getViewDocument", method = RequestMethod.GET)
	public @ResponseBody void getViewDocument(@RequestParam(value = "docId") String docId,
			@RequestParam(value = "fileName") String fileName,@RequestParam(value = "userId") String userId,  
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		File f = null;
		if (docId != null) {
			try {
				ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(docId),Integer.parseInt(userId));
				if(doc == null){
					String json = new Gson().toJson("invalid");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}else
				if(!doc.getDocStatus().equals("103") && doc!=null){
					ClientEFA c = new ClientEFA();
					fileName = c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getElectronicId()==null ? doc.getOriginalId() : doc.getElectronicId());
					f = new File(fileName);
					if (f.exists()) {
						
						Pixel p = ApplicationUtils.getPageCount(f);
						Map<String, String> map = new HashMap<String, String>();
						map.put("numpages", "" + p.getPageCount());
						map.put("pwidth",String.valueOf(p.getWidth()));
						map.put("pheight",String.valueOf(p.getHeight()));
						map.put("filename", f.getAbsolutePath());
						map.put("fileid", docId);
	
						String json = new Gson().toJson(map);
						response.setContentType("application/json");
						response.getWriter().write(json);
	
					} else {
						String json = new Gson().toJson("failed");
						response.setContentType("application/json");
						response.getWriter().write(json);
					}
				}else if(doc.getDocStatus().equals("103")){
					String json = new Gson().toJson("103");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}

			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DaoException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				//if(f!=null){f.delete();}
			}

		} else {
			String json = new Gson().toJson("invalid");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	
	}
	/*@RequestMapping(value = "/getImgDocument")
	public void viewDocument(@RequestParam("fileid") String fileid, @RequestParam("filename") String fname,
			@RequestParam("page") String fpage,@RequestParam("userId") int userId,RedirectAttributes attr, HttpServletResponse response) {
		// logger.info(String.format("img(fileid= %s, fname = %s, fpage = %s)",
		// fileid, fname, fpage));
		System.out.println(userId);
		
		File f = new File(fname);
		try {
			if (f.exists()) {
				ApplicationUtils.writeImageToBrowser(response, f, fpage);
			} else {
				// logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}
			
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		} finally {
			
		}
		
		File f = null;
		try {
			// File f = new File(path + fname);
			ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(fileid),userId);

			ClientEFA c = new ClientEFA();
			String fileName = c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(),
					doc.getElectronicId() == null ? doc.getOriginalId() : doc.getElectronicId());
			f = new File(fileName);
			// File f = ApplicationUtils.stream2file(doc.getElectronic() ==null
			// ? doc.getOriginal() : doc.getElectronic());
			if (f.exists()) {
				ApplicationUtils.writeImageToBrowser(response, f, fpage);
			} else {
				// logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}
			f.deleteOnExit();
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		} finally {
			f.delete();
		}
	}*/
/*	@RequestMapping(value = "/getImgDocument1",method = RequestMethod.GET)
	public @ResponseBody void viewDocument1(@RequestParam("fileid") String fileid, @RequestParam("filename") String fname,
			@RequestParam("page") String fpage,@RequestParam("userId") int userId,RedirectAttributes attr, HttpServletResponse response) {
			
		// fileid, fname, fpage));
		System.out.println(userId);
		
		File f = new File(fname);
		try {
			if (f.exists()) {
				ApplicationUtils.writeImageToBrowser(response, f, fpage);
			} else {
				// logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}
			
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		} finally {
			
		}
		String json = null;
		String base64=null;
		File f = null;
		try {
			//logger.info("TRY in fileid"+fileid+" filename"+fname+ " fpage"+fpage+" userId"+userId);
			// File f = new File(path + fname);
			ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(fileid),userId);

			ClientEFA c = new ClientEFA();
			String fileName = c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(),
					doc.getElectronicId() == null ? doc.getOriginalId() : doc.getElectronicId());
			f = new File(fileName);
			// File f = ApplicationUtils.stream2file(doc.getElectronic() ==null
			// ? doc.getOriginal() : doc.getElectronic());
			if (f.exists()) {
				base64=ApplicationUtils.writeImageToBrowser1(response, f, fpage);
				json=new Gson().toJson(base64);
				response.setContentType("application/json");
				response.getWriter().write(json);
			} else {
				// logger.error("File Not Found.");
				//attr.addFlashAttribute("fileMsg", "File Not Found.");
				json=new Gson().toJson("File Not Found.");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
			
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			//logger.info("CATCH in fileid"+fileid+" filename"+fname+ " fpage"+fpage+" userId"+userId);
			attr.addFlashAttribute("fileMsg", e);
			e.printStackTrace();
		} finally {
			f.deleteOnExit();
			f.delete();
		}
		
	}
	*/

	@RequestMapping(value = "/getImgDocument",method = RequestMethod.GET)
	public @ResponseBody void viewDocument(@RequestParam("fileid") String fileid, @RequestParam("filename") String fname,
			@RequestParam("page") String fpage,@RequestParam("userId") int userId,@RequestParam("numpages") int numpages,RedirectAttributes attr, HttpServletResponse response) {
			
		// fileid, fname, fpage));
		/*System.out.println(userId);
		
		File f = new File(fname);
		try {
			if (f.exists()) {
				ApplicationUtils.writeImageToBrowser(response, f, fpage);
			} else {
				// logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}
			
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		} finally {
			
		}
		String json = null;
		String base64=null;
		File f = null;
		try {
			//logger.info("TRY in fileid"+fileid+" filename"+fname+ " fpage"+fpage+" userId"+userId);
			// File f = new File(path + fname);
			ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(fileid),userId);

			ClientEFA c = new ClientEFA();
			String fileName = c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(),
					doc.getElectronicId() == null ? doc.getOriginalId() : doc.getElectronicId());
			f = new File(fileName);
			// File f = ApplicationUtils.stream2file(doc.getElectronic() ==null
			// ? doc.getOriginal() : doc.getElectronic());
			if (f.exists()) {
				base64=ApplicationUtils.writeImageToBrowser1(response, f, fpage);
				json=new Gson().toJson(base64);
				response.setContentType("application/json");
				response.getWriter().write(json);
			} else {
				// logger.error("File Not Found.");
				//attr.addFlashAttribute("fileMsg", "File Not Found.");
				json=new Gson().toJson("File Not Found.");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
			
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			//logger.info("CATCH in fileid"+fileid+" filename"+fname+ " fpage"+fpage+" userId"+userId);
			attr.addFlashAttribute("fileMsg", e);
			e.printStackTrace();
		} finally {
			f.deleteOnExit();
			f.delete();
		}
		*/
		String base64 = null;
		File f = null;
		String json = null;
		try {
			f = new File(fname);
			if (f.exists()) {
				base64 = ApplicationUtils.writeImageToBrowser1(response, f, fpage);
				json = new Gson().toJson(base64);
				response.setContentType("application/json");
				response.getWriter().write(json);
			} else {
				json = new Gson().toJson("File Not Found.");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			// logger.info("CATCH in fileid"+fileid+" filename"+fname+ "
			// fpage"+fpage+" userId"+userId);
			e.printStackTrace();
		} finally{
			if(Integer.parseInt(fpage)==numpages){
				logger.error("Delete File");
				f.delete();
				f.deleteOnExit();
			}
		}
		
	}
	@RequestMapping(value = "/deleteImageDocument", method = RequestMethod.GET)
	public void deleteImageDocument(@RequestParam("filename") String fname, HttpServletResponse response)
			throws IOException {
		// logger.info(String.format("img(fileid= %s, fname = %s, fpage = %s)",
		// fileid, fname, fpage));
		String status = "failed";
		File f = new File(fname);
		if (f.getName() != null) {
			f.deleteOnExit();
			f.delete();
			status = "success";
		}
		String json = new Gson().toJson(status);
		response.setContentType("application/json");
		response.getWriter().write(json);
	}
	
	@RequestMapping(value = "/getApplicationFieldData", method = RequestMethod.GET)
	public void getApplicationFieldData(@RequestParam("fname") String fname, @RequestParam("fileid") String fileid,
			@RequestParam("email") String signeremail, HttpServletResponse response) {
		response.setContentType("application/json");
		List<DocumentField> f = null;
		try {
			f = applicatonService.getApplicationFieldData(fname, fileid, signeremail);
		} catch (DaoException e) {
			// logger.error("Error while getFieldData: "+e);
		}
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// logger.error("Error while gettting getWriter: "+e.getMessage());
		}
		Gson gson = new Gson();
		out.print(gson.toJson(f));

		out.flush();
	}
	
	@RequestMapping(value = "/saveDocument", method = RequestMethod.POST)
	public @ResponseBody void saveDocument(@RequestBody List<DocumentField> documentField,HttpServletRequest request, HttpServletResponse response) throws IOException, DaoException 
	{
		String status="failed"; //
		String key = request.getParameter("token");
		DocUtils docUtils=new DocUtils();
		File f = null;
		
		File outputFile = new DocUtils().tempFile();
		String signatureString = null;
		File digitaltemp=null;
		ApplicationDocument doc=null;
		if(key !=null){
				try {
				SignerData signer=applicatonService.checkValidSigneKey(key);
				Registration user = registerService.getUser(signer.getRequestEmail());
				int isEmailAlert = user.getIsEmailAlert();
				if(signer.getSignStatus() == 1){
					status="502"; //already sign document
				}else if(signer.getDocId() !=0 && signer.getSignStatus() ==0){
					
					 
					 //update signer field url and electronic blob
					  doc = applicatonService.getDocument(signer.getDocId(),signer.getRequestBy());
					  ClientEFA c=new ClientEFA();
						if(doc.getElectronicId() == null){
							String fileName=c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getOriginalId());
							f=new File(fileName); 
							
						}else{
							String fileName=c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getElectronicId());
							f=new File(fileName); 
						}
						for(DocumentField df:documentField){
							df.setLeft(df.getLeft().replaceAll("px", ""));
							df.setTop(df.getTop().replaceAll("px", ""));
							df.setxPosition(Float.parseFloat(df.getLeft()));
							df.setyPosition(Float.parseFloat(df.getTop()));
							df.setPageNumber(df.getPageNumber()-1);
							if (df.getFieldType().equalsIgnoreCase("image") || df.getFieldType().equalsIgnoreCase("checkbox")) {
								try {
									signatureString = docUtils.modifySignatureData(df.getFieldValue());
									df.setFieldValue(docUtils.createSignature(signatureString,209,40));

								} catch (IOException e) {
									e.printStackTrace();
								}
							}
						}	
						String writefileName=docUtils.writeDocumentFields(documentField,f,outputFile);
						//update fields
						 status=applicatonService.updateSignerFields(documentField);
						
						String eRefDocId=CommonUtils.randomString(10);
						c.efaStore(c, "DocumentObject1", doc.getEnvelopeId(), eRefDocId, writefileName);
						applicatonService.updateRefDocId(doc.getId(), eRefDocId, "electronic");
						
						status=applicatonService.updateSignerStatus(signer.getSignerId(), eRefDocId, 1);
					
					//get all signer status
					boolean isNotAvailable=applicatonService.getAllSignerStatus(signer.getDocId(), signer.getSignerId());
					
					if(isNotAvailable == true){
						//Apply digital stamp and digitail_doc_id
						String digiRefDocId = CommonUtils.randomString(10);
						digitaltemp = new File(TEMP_DIGITAL_URL + digiRefDocId+".pdf");
						ApplicationUtils ap = new ApplicationUtils();
						ap.createDigitalSignature(outputFile, digitaltemp, doc.getEnvelopeId());
						String dRefDocId = CommonUtils.randomString(10);
						c.efaStore(c, "DocumentObject1", doc.getEnvelopeId(), dRefDocId, digitaltemp.getAbsolutePath());
						applicatonService.updateRefDocId(doc.getId(), dRefDocId, "digital");

						doc.setStatus(1);
						doc.setDocStatus("103");
						
						doc.setCompletedOn(CommonUtils.currentDate());
						status =applicatonService.updateDocument1(doc);
						status="500";
						if(isEmailAlert == 1){
						String subject1=doc.getSubject()+" has been signed by "+signer.getSignerName();
						String body1="\t\t\t<b>Hi "+signer.getRequestName()+",</b><br />\r\n\t\t\t\t\t\t\t<p>Your document "+doc.getFileName()+" has been signed by "+signer.getSignerName()+".You may view the status of your document at any time by logging into DrySign.</p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
						//send notification to request By
						emailSender.sendMail1(SUPPORT_EMAIL, signer.getRequestEmail(), doc.getCc(), subject1, body1);
						
						String subject="DrySign:"+doc.getSubject();
						String body="\t\t\t<b>Hi "+signer.getRequestName()+",</b><br />\r\n\t\t\t\t\t\t\t<p>Your document has been signed by all signees.You may view the status of your document at any time by logging into DrySign.</p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
						//sent email to requester with attachments
						emailSender.sendMail(SUPPORT_EMAIL, signer.getRequestEmail(), doc.getCc(), subject, body, digitaltemp.getAbsolutePath(), doc.getFileName());
						}
						
					}else{
						//check priority
						if(signer.getPriority() !=0){
							//send email to next
							int signerPriority=signer.getPriority()+1;
							Signer nextSignger=applicatonService.nextSignerData(doc.getId(), signerPriority);
							String subject = "DrySign:"+doc.getSubject();
							String url = SERVER_URL + "signDocument?key="+nextSignger.getSignerUrl();
							
							String signerName=nextSignger.getSignerName();
							String requestBy=signer.getRequestName();
							String body="\t\t\t<b>Hi "+signerName+",</b><br />\r\n\t\t\t\t\t\t\t<p>You have been requested by "+requestBy+" to sign a document in DrySign."+requestBy+" has sent you the following message: "+doc.getMessage()+".</p>\r\n\t\t\t\t\t\t\t    <p>Kindly sign the document by clicking the link below:</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Sign Document</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
							if(isEmailAlert == 1){
								emailSender.sendMail(SUPPORT_EMAIL, nextSignger.getSignerEmail(),null, subject, body, url);
							}
							
							
							/*Notification notification = new Notification();
							notification.setDocId(doc.getId());
							notification.setUserId(doc.getUserId());
							notification.setFrom("support@drysign.me");
							notification.setTo(nextSignger.getSignerEmail());
							notification.setCc("");
							notification.setSubject("TEST");
							notification.setMessage(doc.getMessage());
							notification.setStatus(emailStatus == "1" ? "success" :"failed");
							notification.setReason(emailStatus == "1" ? "ok" :"failed");
							notification.setCreatedOn(CommonUtils.currentDate());
							
							//save email status
							applicatonService.saveNotification(notification);*/
							status="500";
						}else if(signer.getPriority() ==0){
							status="500";
						}
						String subject=doc.getSubject()+" has been signed by "+signer.getSignerName();
						String body="\t\t\t<b>Hi "+signer.getRequestName()+",</b><br />\r\n\t\t\t\t\t\t\t<p>Your document "+doc.getFileName()+" has been signed by "+signer.getSignerName()+".You may view the status of your document at any time by logging into DrySign.</p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
						//send notification to request By
						if(isEmailAlert == 1){
							emailSender.sendMail1(SUPPORT_EMAIL, signer.getRequestEmail(), doc.getCc(), subject, body);
						}
					}
					
				}
			}catch(Exception e1){
				logger.error("Error while modify pdf or writing values to pdf or updating status of document: "+ e1);
			}finally{
				if(f != null){f.delete();}
				if(digitaltemp!= null){digitaltemp.delete();}
				if(outputFile != null){
					outputFile.delete();
					outputFile.deleteOnExit();
				}
			}
		}
		
		else{
			status="501"; //sign document key URL wrong
		}
		String json = new Gson().toJson(status);
		response.setContentType("application/json");
		response.getWriter().write(json);
	}
	
	@RequestMapping(value = "/successPage", method = RequestMethod.GET)
	public ModelAndView successGroupSign(@RequestParam(value = "returnURL") String returnURL) {
		
		ModelAndView model = new ModelAndView();
		model.addObject("returnUrl", returnURL);		
		return new ModelAndView("successDocument1");

	}	
	@RequestMapping(value = "/success", method = RequestMethod.GET)
	public ModelAndView success() {
		
	 return new ModelAndView("successDocument");

	}
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public ModelAndView page404() {
		ModelAndView model = new ModelAndView();
		model.addObject("title", "SignDocument");
		model.addObject("flag", "401");
		model.addObject("errorMsg", "File not found");
		model.setViewName("404page");
		return model;

	}
	
	@RequestMapping(value = "/typeSignature", method = RequestMethod.GET)
	public @ResponseBody void typeSignature(@RequestParam(value = "imgType") String imgType,HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		// List of Base64 String

		if (imgType != null && imgType != "") {
			List<String> typeFontList = createType(imgType, "mytype");
			String json = new Gson().toJson(typeFontList);
			response.setContentType("application/json");
			response.getWriter().write(json);
		} else {
			String json = new Gson().toJson("failed");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}
	
	public static List<String> createType(String myType, String fileName) throws IOException {

		List<String> type = new ArrayList<String>();

		CommonUtils c = new CommonUtils();
		for (ImageType im : c.getPropValues()) {

			BufferedImage image = new CommonUtils().convertTextToGraphic(myType, new Font(im.getFont(), Font.PLAIN, 32));
			String prefix = "file";
			String suffix = ".png";
			File directory = new File(TYPE_PATH);
			File tempFile3 = null;
			tempFile3 = File.createTempFile(prefix, suffix, directory);
			ImageIO.write(image, "png", tempFile3);
			File file = new File(directory + "/" + tempFile3.getName());
			FileInputStream imageInFile = new FileInputStream(file);
			byte imageData[] = new byte[(int) file.length()];
			imageInFile.read(imageData);

			// Converting Image byte array into Base64 String
			String imageDataString = CommonUtils.encodeImage(imageData);
			String LastString = imageDataString.replace('_', '/');
			String myString = LastString.replace('-', '+');
			String imgSrc = "data:image/png;base64," + myString;
			type.add(imgSrc);
			imageInFile.close();
			if (file.delete()) {
				//System.out.println("File is deleted");
			} else {
				System.out.println("File not found!");
			}
		}

		return type;
	}
	
	@RequestMapping(value = "/prepareDocument")
	public ModelAndView prepareDocument(@RequestParam("key") String key,RedirectAttributes attr, HttpServletRequest request) throws DaoException 
	{
		ModelAndView model = new ModelAndView();
		if(key !=null){
			Document d=applicatonService.checkValidPrepareKey(key);
			if(d.getId() == 0){
				model.addObject("flag", "404");
				model.addObject("errorMsg", "Invalid Token");
				model.addObject("title", "PageNotFound");
				model.setViewName("404page");	
			}
			else if(d.getId() !=0 && d.getDocStatus().equals("101")){
				//get signer list
				List<Signer> signerList=applicatonService.getSignerList1(d.getId());
				
				model.addObject("signerListSize", signerList.size());
				model.addObject("signerList", signerList);
				model.addObject("docId", d.getId());
				model.addObject("userId", d.getUserId());
				model.addObject("title", "Prepare Document");
				model.addObject("prepareReturnURL", d.getPrepareReturnURL());
				model.setViewName("prepareDocument");	
				
			}else if(d.getDocStatus().equals("102")){
				model.addObject("flag", "402");
				model.addObject("errorMsg", "YOU HAVE ALREADY PREPARED THE DOCUMENT");
				model.addObject("title", "PageNotFound");
				model.setViewName("404page");
			}
			else{
				model.addObject("flag", "404");
				model.addObject("errorMsg", "Page not found");
				model.addObject("title", "PageNotFound");
				model.setViewName("404page");
			}
		}else{
			model.addObject("flag", "404");
			model.addObject("errorMsg", "Page not found");
			model.addObject("title", "PageNotFound");
			model.setViewName("404page");
		}
		return model;
	}

	/*****
	 * 
	 * @param docId
	 * @param fileName
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	/*@RequestMapping(value = "/ajaxGetDocument", method = RequestMethod.GET)
	public @ResponseBody void ajaxGetDocument(@RequestParam(value = "docId") String docId,@RequestParam(value = "userId") String userId,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		// List of Base64 String
		File f = null;
		String fileName=null;
		if (docId != null && userId!=null) {

			try {
				ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(docId),Integer.parseInt(userId));
				if(doc == null){
					String json = new Gson().toJson("invalid");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}else
				if(!doc.getDocStatus().equals("103") && doc!=null){
					ClientEFA c = new ClientEFA();
					fileName = c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getOriginalId());
					f = new File(fileName);
					if (f.exists()) {
					
						Pixel p = ApplicationUtils.getPageCount(f);
					
						Map<String, String> map = new HashMap<String, String>();
						map.put("numpages", "" + p.getPageCount());
						map.put("pwidth",String.valueOf(p.getWidth()));
						map.put("pheight",String.valueOf(p.getHeight()));
						map.put("filename", doc.getFileName());
						map.put("fileid", docId);
	
						String json = new Gson().toJson(map);
						response.setContentType("application/json");
						response.getWriter().write(json);
	
					} else {
						String json = new Gson().toJson("failed");
						response.setContentType("application/json");
						response.getWriter().write(json);
					}
				}else if(doc.getDocStatus().equals("103")){
					String json = new Gson().toJson("103");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}

			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DaoException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				if(f!=null){f.delete();}
			}

		} else {
			String json = new Gson().toJson("invalid");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}
	*/
	@RequestMapping(value = "/ajaxGetDocument", method = RequestMethod.GET)
	public @ResponseBody void ajaxGetDocument1(@RequestParam(value = "docId") String docId,@RequestParam(value = "userId") String userId,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		// List of Base64 String
		File f = null;
		String fileName=null;
		if (docId != null && userId!=null) {

			try {
				ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(docId),Integer.parseInt(userId));
				if(doc == null){
					String json = new Gson().toJson("invalid");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}else
				if(!doc.getDocStatus().equals("103") && doc!=null){
					ClientEFA c = new ClientEFA();
					fileName = c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getOriginalId());
					f = new File(fileName);
					if (f.exists()) {
					
						Pixel p = ApplicationUtils.getPageCount(f);
					
						Map<String, String> map = new HashMap<String, String>();
						map.put("numpages", "" + p.getPageCount());
						map.put("pwidth",String.valueOf(p.getWidth()));
						map.put("pheight",String.valueOf(p.getHeight()));
						map.put("filename", f.getAbsolutePath());
						map.put("fileid", docId);
	
						String json = new Gson().toJson(map);
						response.setContentType("application/json");
						response.getWriter().write(json);
	
					} else {
						String json = new Gson().toJson("failed");
						response.setContentType("application/json");
						response.getWriter().write(json);
					}
				}else if(doc.getDocStatus().equals("103")){
					String json = new Gson().toJson("103");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}

			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DaoException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				//if(f!=null){f.delete();}
			}

		} else {
			String json = new Gson().toJson("invalid");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}
	
	
	@RequestMapping(value = "/savePrepareDocument", method = RequestMethod.POST)
	public @ResponseBody void savePrepareDocument(@RequestParam("key") String key,HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<DocumentField> documentField) throws IOException, DaoException {
		String prepare_status=null; //FAILED
		if(key !=null){
			Document d=applicatonService.checkValidPrepareKey(key);
			if( d.getId() == 0){  
				prepare_status= "201"; //KEY IS NOT EXIST 
			}else if(d.getDocStatus().equals("102")){
				prepare_status= "202"; //YOU HAVE ALREDY PREPARE THE DOCUMENT
			}else{
			    //update status
				ApplicationDocument ad=new ApplicationDocument();
				ad.setDocStatus("102");
				ad.setStatus(0);
				ad.setId(d.getId());
				ad.setUpdatedOn(CommonUtils.currentDate());
				String doc_status=applicatonService.updateDocument(ad);
				//save new fields
				for(DocumentField df:documentField){
					
					/*df.setLeft(df.getLeft().replaceAll("px", ""));
					df.setTop(df.getTop().replaceAll("px", ""));
					//df.setPageNumber(docUtils.getPageNumber(Float.parseFloat(df.getTop()),df.getPageHeight()));
					// set top position
					df.setTop(String.valueOf(docUtils.getTopPosition(df.getPageNumber(), Float.parseFloat(df.getTop()), df.getPageHeight())));
					*/
					df.setxPosition(Float.parseFloat(df.getLeft()));
					df.setyPosition(Float.parseFloat(df.getTop()));
				}
				String field_status=applicatonService.saveDocumentFields(documentField);
				if(field_status.equalsIgnoreCase("SUCCESS") && doc_status.equalsIgnoreCase("SUCCESS")){
					prepare_status ="200"; //OK
				}else{
					prepare_status ="204"; //ERROR WHILE SAVE FIELDS
				}
			}
		}else{
			prepare_status= "203"; //KEY IS NULL:
		}
		//String fieldStatus=applicatonService.saveDocumentFields(documentField);
		String json = new Gson().toJson(prepare_status);
		response.setContentType("application/json");
		response.getWriter().write(json);
		
	}
	
	@RequestMapping(value = "/api", method = RequestMethod.GET)
	public ModelAndView api(){
		
		return new ModelAndView("api");
	}
	
	@RequestMapping(value = "/apiregistration", method = RequestMethod.GET)
	public ModelAndView apiregistration(){
		
		return new ModelAndView("/apiregistration");
	}
	
	
	@RequestMapping(value="/formregisterkey", method = RequestMethod.POST)
    public @ResponseBody Map<String ,Object>  submittedFromData(@RequestBody Registration registration, HttpServletRequest request,HttpServletResponse response) {	
		
		Map<String ,Object> map = new HashMap<String,Object>();
    	String uniqueID = new GlobalFunctions().uniqueToken();
    	registration.setEmail_verification_token(uniqueID);
    	registration.setUser_type(2);
    	registration.setStatus(1);
    	registration.setDate(new DateManipulation().getMyDate());
    	registration.setClientSecret(RandomStringUtils.randomAlphabetic(5));
    	registration.setRole("ROLE_APP");
    	
    	registration.setPhone(registration.getPhone().replace("\"", ""));
//    	registration.setPincode(registration.getPincode().replace("\"", ""));
    	//System.out.println(registration.getPhone());
    	String password=RandomStringUtils.randomAlphabetic(10);
    	//registrationValidation.validate(registration, result);
    	registration.setPassword(ApplicationUtils.encryptPassword(password));
    	
			try {
				if(registerService.addRegistration(registration)==1)
				{
					String body=	"\r\n\t\t\t\t\t\t\t<p>Your DrySign account has been activated, with the following login details:</p><br><br>"
									+"Login name: " + registration.getEmail() +"<br>"
									+"Password: " +password + "<br>"
									+"Client Id: restapp<br>"
									+"Secret Id: restapp<br><br>"
									+">Please refer this link : "+SERVER_URL+"/api for download API </strong></p></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
					String subject = "DrySign: Your account is now activated";
					
					emailSender.sendMail1(SUPPORT_EMAIL, registration.getEmail(), null, subject, body);
					
					registration.setFirstName(null);
					registration.setEmail(null);
					registration.setPassword(null);
					
					map.put("msg", "1");
					
					
				}
				else if(registerService.addRegistration(registration)==2)
				{
					map.put("msg", "This Email is already exists.");
				
				}
				else if(registerService.addRegistration(registration)==3)
				{
					map.put("msg", "Problem in Registration.");
				
				}
			} catch (DaoException e) {
				logger.error("Error while Registration: "+e);
			}
		
		return map;
	}	

	/*Start viewing document*/
	
	@RequestMapping(value = "/viewReadOnlyDocument")
	public ModelAndView viewReadOnlyDocument(@RequestParam("envelopeid") String envelopeId) throws DaoException 
	{
		ModelAndView model = new ModelAndView();
		if(envelopeId !=null){

			try {
				 ApplicationDocument doc = applicatonService.getDocumentByEnvelopeId(envelopeId);
					model.addObject("filename", doc.getFileName());
					model.addObject("fileId", doc.getId());
					model.addObject("redirecturl", "");
					model.addObject("envelopeId", doc.getEnvelopeId());
					model.addObject("docId", doc.getId());
					model.addObject("userId", doc.getUserId());
					model.addObject("title", "View Document");
					model.addObject("returnURL", doc.getDocUrl());
					model.setViewName("viewDocument");
			 } catch (Exception e) {
				model.addObject("errorMsg", "File not found");
				model.addObject("flag", "401");
				model.setViewName("404page");
			}
		}else{
			model.addObject("flag", "404");
			model.addObject("errorMsg", "Page not found");
			model.addObject("title", "PageNotFound");
			model.setViewName("404page");
		}
		return model;
	}
	
	@RequestMapping(value = "/getViewReadOnlyDocument", method = RequestMethod.GET)
	public @ResponseBody void getViewReadOnlyDocument(@RequestParam(value = "envelopeId") String envelopeId, HttpServletResponse response) throws IOException {
		File f = null;
		
		if (envelopeId != null) {
			try {
				ApplicationDocument doc = applicatonService.getDocumentByEnvelopeId(envelopeId);
				String fileName=doc.getFileName();
				
				
					if( doc!=null){
						ClientEFA c = new ClientEFA();
						fileName = c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getElectronicId()==null ? doc.getOriginalId() : doc.getElectronicId());
						f = new File(fileName);
						if (f.exists()) {
							Pixel p = ApplicationUtils.getPageCount(f);
							Map<String, String> map = new HashMap<String, String>();
							map.put("numpages", "" + p.getPageCount());
							map.put("pwidth",String.valueOf(p.getWidth()));
							map.put("pheight",String.valueOf(p.getHeight()));
							map.put("filename", f.getAbsolutePath());
							map.put("fileid", String.valueOf(doc.getId()));
		
							String json = new Gson().toJson(map);
							response.setContentType("application/json");
							response.getWriter().write(json);
		
						} else {
							String json = new Gson().toJson("failed");
							response.setContentType("application/json");
							response.getWriter().write(json);
						}
					}
					
			

			} catch (Exception e) {
				String json = new Gson().toJson("invalid");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}

		} else {
			String json = new Gson().toJson("invalid");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	
	}
	
	@RequestMapping(value = "/typeSignature1", method = RequestMethod.GET)
	public @ResponseBody void typeSignature1(@RequestParam(value = "imgType") String imgType,HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		// List of Base64 String

		if (imgType != null && imgType != "") {
			List<String> typeFontList = createType(imgType, "mytype");
			String json = new Gson().toJson(typeFontList);
			response.setContentType("application/json");
			response.getWriter().write(json);
		} else {
			String json = new Gson().toJson("failed");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}
	
	@RequestMapping(value = "/createsignature", method = RequestMethod.GET)
	public ModelAndView createsignature(@RequestParam("token") String token) throws DaoException {
		ModelAndView model = new ModelAndView();
		if(token !=null){
			//check token exist in database
			Signature signature=applicatonService.getSignature(token,null);
			if(signature ==null ){
				model.addObject("response", "error");
				model.addObject("message", "Token does not exist in DrySign.");
			}
			else{
				model.addObject("userSignature", signature.getSignature());
				model.addObject("firstName", signature.getFirstName());
				model.addObject("lastName", signature.getLastName());
				model.addObject("email", signature.getEmail());
				model.addObject("status", signature.getStatus());
				model.addObject("id", signature.getId());
				model.addObject("response", "success");
				model.addObject("message", "ok");
				
				
			}
		}else{
			model.addObject("response", "error");
			model.addObject("message", "Invalid token");
		}
		model.addObject("title", "Signature");
		model.setViewName("signature");
		return model;
	}
	@RequestMapping(value = "/saveUserSignature", method = RequestMethod.POST)
	public @ResponseBody void saveUserSignature(@RequestBody Signature userSignature,HttpServletRequest request,HttpServletResponse response) throws DaoException, IOException {
		String json = new Gson().toJson("failed");
		Signature sign=null;
		if (userSignature.getToken() != null){
			@SuppressWarnings("unused")
			String signature=null;
			DocUtils docUtils=new DocUtils();
			signature = docUtils.modifySignatureData(userSignature.getSignature());
			
			json=applicatonService.saveUserSignature(userSignature);
			if(json.equalsIgnoreCase("SUCCESS")){
				sign=applicatonService.getSignature(userSignature.getToken(),userSignature.getEmail());
				json=sign.getSignature();
			}
		} else {
			json="FAILURE";
			
		}
		json = new Gson().toJson(json);
		response.setContentType("application/json");
		response.getWriter().write(json);
	}
	/*End viewing document*/
	
	@RequestMapping(value = "/saveSignerSignature", method = RequestMethod.POST)
	public @ResponseBody void saveSignature(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Signature userSignature) throws IOException, DaoException {
				String bigName = userSignature.getFullName();
				String[] names = bigName.split(" ");
				userSignature.setFirstName( names[0]);
				userSignature.setLastName(names[names.length-1]);
				
			String responseStatus = applicatonService.saveUserSignature(userSignature);
			if (responseStatus.equalsIgnoreCase("SUCCESS")) {
				String json = new Gson().toJson("success");
				response.setContentType("application/json");
				response.getWriter().write(json);
			} else {
				String json = new Gson().toJson("failed");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
	}
	
	@RequestMapping(value = "/saveResizeSignature", method = RequestMethod.POST)
	public @ResponseBody void resizeSignature(@RequestBody ApplicationDocument doc,HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		// List of Base64 String
		String base64String=null;
		if (doc.getDataURL() != null && doc.getDataURL() != "") {
			try {
				DocUtils docUtils=new DocUtils();
				String signatureString = docUtils.modifySignatureData(doc.getDataURL());
				String filePath=docUtils.createSignature(signatureString,750,186);
				base64String=DocUtils.encodeFileToBase64Binary(filePath);
				String json = new Gson().toJson(base64String);
				response.setContentType("application/json");
				response.getWriter().write(json);
				
			} catch (IOException e) {
				String json = new Gson().toJson("failed");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
			
		} else {
			String json = new Gson().toJson("failed");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}
	
}

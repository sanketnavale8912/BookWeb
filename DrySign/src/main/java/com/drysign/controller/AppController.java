package com.drysign.controller;
import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.text.WordUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.drysign.dao.DaoException;
import com.drysign.efa.ClientEFA;
import com.drysign.externalapp.resources.googledrive.GoogleDriveConstant;
import com.drysign.externalapp.resources.googledrive.OneDriveResource;
import com.drysign.model.ApplicationDocument;
import com.drysign.model.DocumentCount;
import com.drysign.model.DocumentField;
import com.drysign.model.Draft;
import com.drysign.model.EFAConfigDetails;
import com.drysign.model.GoogleDriveResource;
import com.drysign.model.JsonDocumentData;
import com.drysign.model.Notification;
import com.drysign.model.Pixel;
import com.drysign.model.Registration;
import com.drysign.model.ResetPassword;
import com.drysign.model.SB_Purchase;
import com.drysign.model.Signature;
import com.drysign.service.ApplicatonService;
import com.drysign.service.RegisterService;
import com.drysign.service.SubscriptionService;
import com.drysign.utility.ApplicationUtils;
import com.drysign.utility.CommonUtils;
import com.drysign.utility.DateManipulation;
import com.drysign.utility.DocUtils;
import com.drysign.utility.EmailSender;
import com.drysign.utility.ExternalAppResourceUtil;
import com.drysign.utility.GlobalFunctions;
import com.drysign.utility.ImageResizer;
import com.drysign.utility.ImageType;
import com.drysign.utility.SendEmail;
import com.drysign.utility.Signer;
import com.drysign.utility.UtilityException;
import com.google.api.services.drive.Drive;
import com.google.gson.Gson;

@Controller
@RequestMapping("/app")
public class AppController {

	private static String TEMP_DIGITAL_URL, EFA_FILE_PATH,SERVER_URL,SUPPORT_EMAIL,TYPE_PATH,SIGNATURE_PATH,DRIVE_PATH= null;
	private static final Logger logger = Logger.getLogger(AppController.class);
	AppController() {
		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			TEMP_DIGITAL_URL = globalfunctions.getTempAppDigitalSignPdfPath();
			SIGNATURE_PATH = globalfunctions.getSignaturePath();
			EFAConfigDetails cEFA = globalfunctions.getEFAdetails();
			TYPE_PATH = globalfunctions.getTypePath();
			EFA_FILE_PATH = cEFA.getDownloadFilePath();
			SERVER_URL = new GlobalFunctions().getServerUrl();
			SUPPORT_EMAIL = new GlobalFunctions().getSupportUrl();
			DRIVE_PATH = globalfunctions.getTemporaryFilePath();
			// logger.info(String.format("SelfsignController(PATH = %s , )",
			// TEMP_DIGITAL_URL));
		} catch (UtilityException e) {
			// logger.error(e);
		}
	}
	@Autowired
	private EmailSender emailSender;
	
	public static String ServerResponse = "";
	@Autowired
	private RegisterService registerService;

	@Autowired
	private ApplicatonService applicatonService;


	@Autowired
	private SubscriptionService subscriptionService;

	@RequestMapping(value = { "/dashboard" }, method = RequestMethod.GET)
	public ModelAndView dashboard(HttpServletRequest request, HttpServletResponse response) 
	{

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		String expires = "";
		float days = 0;
		float noofdays=0;
		float daysLeftPercent = 0 ;
		boolean upgrade = false;
		SB_Purchase activePurchase = null;
		long totalLeftDoc =0;
		if (session != null) {
			Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			try {
				DocumentCount documentCount = applicatonService.getDocumentCount(user.getId());
				if(documentCount != null){
					model.addObject("totalDocument", documentCount.getTotal());
					model.addObject("completed", documentCount.getCompleted());
					model.addObject("outForSignature", documentCount.getOutForSignature());
					model.addObject("deleted", documentCount.getOutForSignature());
					model.addObject("draft", documentCount.getDraft());
				}
				Signature signture=applicatonService.getSignature(null,user.getEmail());
				if(signture !=null){
					model.addObject("signature",signture.getSignature());
					model.addObject("signatureType",signture.getSignType());
				}
			} catch (DaoException e) {
				e.printStackTrace();
			}
			
			try{
			activePurchase = subscriptionService.getActiveSubscription(user.getId());
			if(activePurchase != null){
				//SimpleDateFormat myFormat = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss");
				days = new DateManipulation().daysCalculation(activePurchase.getSubscription().getSubscriptionEndTime());
			    expires = new SimpleDateFormat("MM/dd/yyyy").format(activePurchase.getSubscription().getSubscriptionEndTime());
			    long creditdoc = activePurchase.getSubscription().getCreditedDocuments();
			    long debitdoc = activePurchase.getSubscription().getUsedDocuments();
			    totalLeftDoc = creditdoc-debitdoc;
			    if(totalLeftDoc <= 0 || days <= 0 )
			    {
			    	upgrade = true;
			    }
			    //days chart total percent calculation
			    noofdays = Integer.parseUnsignedInt(activePurchase.getDurationtime());
			    daysLeftPercent = (float) ((days/noofdays) ==1  ? (days/noofdays) - .01 : (days/noofdays)) ;
			}else{
				upgrade = true;
			}
			
			}catch(Exception e){
				logger.error("Error while getting getActiveSubscription: "+e);
			}
			model.addObject("title", "Dashboard");
			model.addObject("message", "Welcome to document!");
			model.addObject("activePurchase",activePurchase);
			model.addObject("expires",expires);
			model.addObject("days",(int)days);
			model.addObject("upgrade",upgrade);
			model.addObject("isInternalEmail",GlobalFunctions.isInternalEmail(user.getEmail()));
			model.addObject("daysLeftPercent",daysLeftPercent);
			model.addObject("totalLeftDoc",totalLeftDoc);
			model.setViewName("dashboard");
		
		} else {
			model.setViewName("login");
		}
		return model;
	}
	public boolean upgrade(int userId)
	{
		String expires = "";
		float days = 0;
		float noofdays=0;

		boolean upgrade = false;
		SB_Purchase activePurchase = null;
		
		activePurchase = subscriptionService.getActiveSubscription(userId);
		if(activePurchase != null){

			days = new DateManipulation().daysCalculation(activePurchase.getSubscription().getSubscriptionEndTime());
		    expires = new SimpleDateFormat("MM/dd/yyyy").format(activePurchase.getSubscription().getSubscriptionEndTime());
		    long creditdoc = activePurchase.getSubscription().getCreditedDocuments();
		    long debitdoc = activePurchase.getSubscription().getUsedDocuments();
		    
		    if(creditdoc-debitdoc <= 0 || days <= 0 )
		    {
		    	upgrade = true;
		    }
		   
		}else{
			upgrade = true;
		}
		return upgrade;
	}
	
	/*public float daysCalculation(Timestamp endSubscriptionTime)
	{
		
		
		float days = 0;
		 Date date2 = null;
		 try {
			SimpleDateFormat myFormat = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss");
			java.sql.Timestamp date1 = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
			date2 = myFormat.parse(new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(endSubscriptionTime));			
		    long diff = date2.getTime() - date1.getTime();
		    days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) > 0 ? TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) : 0;
		    //days = days >0 ? days+1 : days + 1;
		} catch (ParseException e) {

				e.printStackTrace();
		}
		return days;
	}	*/	
	@RequestMapping(value = { "/document" }, method = RequestMethod.GET)
	public ModelAndView document(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			model.addObject("title", "Document");
			model.addObject("message", "Welcome to document!");
			model.setViewName("document");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	
	@RequestMapping(value = { "/document/egnyte" }, method = RequestMethod.GET)
	public ModelAndView egnyte() {
		ModelAndView model = new ModelAndView();
		model.setViewName("egnyte");			
		return model;
	}	
	
	@RequestMapping(value = { "/document/selfsign" }, method = RequestMethod.GET)
	public ModelAndView selfsign(HttpServletRequest request, HttpServletResponse response) throws DaoException {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			//ApplicationDocument mySingature=applicatonService.getSignature(user.getId(), 1);
			Signature signture=applicatonService.getSignature(null,user.getEmail());
			model.addObject("signature",signture==null?"":signture.getSignature());
			model.addObject("title", "SelfSign");
			model.addObject("message", "Welcome to selfsign!");
			model.setViewName("selfsign");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "/document/groupsign" }, method = RequestMethod.GET)
	public ModelAndView groupsign(HttpServletRequest request, HttpServletResponse response) throws DaoException {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			ApplicationDocument mySingature=applicatonService.getSignature(user.getId(), 1);
			model.addObject("signature",mySingature.getDataURL());
			model.addObject("title", "GroupSign");
			model.addObject("message", "Welcome to groupsign!");
			model.setViewName("groupsign");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "/history/completedDocuments" }, method = RequestMethod.GET)
	public ModelAndView completedDocuments(HttpServletRequest request, HttpServletResponse response) {

		Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId = String.valueOf(user.getId());
		Map<String, String> model = new HashMap<String, String>();
		try {
			List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
			jsonDocList = applicatonService.completedDocuments(userId == null ? 0 : Integer.parseInt(userId));
			ObjectMapper mapper = new ObjectMapper();
			model.put("list", mapper.writeValueAsString(jsonDocList));
			model.put("title", "Completed Documents");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("completedDocuments", model);
	}

	/*Start new pagination*/
	@ResponseBody
    @RequestMapping(value="/history/completeddocumentlist", method=RequestMethod.GET)
    public  String completedDocumentList( HttpServletRequest request) 
	{
		Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId = String.valueOf(user.getId());
		List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
		jsonDocList = applicatonService.completedDocuments(userId == null ? 0 : Integer.parseInt(userId));
		ObjectMapper mapper = new ObjectMapper();
		
		
		String message = null;
		try {
			System.out.println(mapper.writeValueAsString(jsonDocList));
			message = "{\"aaData\":[[\"agreement.pdf\",\"G\",\"05/11/2017 11:37:47 AM\",\"9367\"]],\"iTotalDisplayRecords\":195}";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			

		return message;
	}
	/*End new pagination*/
	
	@RequestMapping(value = { "/history/outforSignature" }, method = RequestMethod.GET)
	public ModelAndView outforSignature(HttpServletRequest request, HttpServletResponse response) {

		Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId = String.valueOf(user.getId());
		Map<String, String> model = new HashMap<String, String>();
		try {
			List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
			jsonDocList = applicatonService.outForSignature(userId == null ? 0 : Integer.parseInt(userId));
			ObjectMapper mapper = new ObjectMapper();
			model.put("list", mapper.writeValueAsString(jsonDocList));
			model.put("title", "Out For Signature");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("outforsignature", model);
	}

	@RequestMapping(value = { "/history/draft" }, method = RequestMethod.GET)
	public ModelAndView draft(HttpServletRequest request, HttpServletResponse response) {

		Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId = String.valueOf(user.getId());
		Map<String, String> model = new HashMap<String, String>();
		try {
			List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
			jsonDocList = applicatonService.getDraft(userId == null ? 0 : Integer.parseInt(userId));
			ObjectMapper mapper = new ObjectMapper();
			model.put("list", mapper.writeValueAsString(jsonDocList));
			model.put("title", "Draft");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("draft", model);
	}
	
	@RequestMapping(value = { "/document/redirect/{id}" }, method = RequestMethod.GET)
	public ModelAndView redirectDocument(@PathVariable("id") String envelopeId, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, DaoException {
		Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			int isDocId=0;
			isDocId=applicatonService.getDocumentId(envelopeId, user.getId());
			if(isDocId !=0){
			
			ApplicationDocument document = applicatonService.getDocument(isDocId,user.getId());
			if(!document.getDocStatus().equals("103") && document!=null){
			Draft d=new Draft();
			try {
				d= applicatonService.getDocumentDraft(isDocId);
				int step=d.getStepNumber();
					
					if(document.getSignType().equals("S")){
						ApplicationDocument mySingature=applicatonService.getSignature(user.getId(), 1);
						model.addObject("signature",mySingature.getDataURL());
						
						if(step == 3 || step == 2){
							model.addObject("dragList", d.getUrl());
							model.addObject("increment", d.getIncrement());
						}
						model.addObject("stepNumber", d.getStepNumber());
						model.addObject("documentName", document.getFileName());
						model.addObject("docId", document.getId());
						model.addObject("draftId", d.getDraftId());
						
						model.addObject("flag", "draft");
						model.addObject("title", "SelfSign");
						model.addObject("message", "Welcome to selfsign!");
						
						model.setViewName("selfsign");
					}else{
						ApplicationDocument mySingature=applicatonService.getSignature(user.getId(), 1);
						model.addObject("signature",mySingature.getDataURL());
						model.addObject("dragList", d.getUrl());
						model.addObject("increment", d.getIncrement());
					
						model.addObject("stepNumber", d.getStepNumber());
						model.addObject("documentName", document.getFileName());
						model.addObject("docId", document.getId());
						model.addObject("draftId", d.getDraftId());
						model.addObject("flag", "draft");
						
						model.addObject("title", "GroupSign");
						model.addObject("message", "Welcome to groupsign!");
						model.setViewName("groupsign");
					}
	
				
			} catch (NumberFormatException | DaoException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 }else{
			 if(document.getSignType().equals("G")){
				 model.addObject("flag", "103");
				 model.addObject("title", "GroupSign");
				 model.addObject("message", "Welcome to groupsign!");
				 model.setViewName("groupsign");
			 }else{
				 model.addObject("flag", "103");
				 model.addObject("title", "SelfSign");
				 model.addObject("message", "Welcome to selfsign!");
				 model.setViewName("selfsign");
			 }
		 }
		}else{
			 model.setViewName("pagenotfound");
		}	
	} else {
		model.setViewName("login");
	}
	return model;
 }
	

	@RequestMapping(value = { "/profile" }, method = RequestMethod.GET)
	public ModelAndView profile(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String pic=applicatonService.getPic(user.getId(), 1);
			model.addObject("mypic",pic);
			model.addObject("title", "Profile");
			model.addObject("message", "Welcome to profile!");
			model.setViewName("profile");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "/test1" }, method = RequestMethod.GET)
	public ModelAndView test1(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			model.addObject("title", "Profile");
			model.addObject("message", "Welcome to profile!");
			model.setViewName("profile");
		} else {
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value = { "/settings" }, method = RequestMethod.GET)
	public ModelAndView settings(HttpServletRequest request, HttpServletResponse response) throws DaoException {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			
			Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			Registration registration=registerService.getSettingDetails(register.getEmail());
			String theme = registration.getTheme();
			System.out.println("Theme-->"+theme);
			String projectname = registration.getProject();
			System.out.println("Project--->"+projectname);
			//get seeting details i/p register.getEmail()
			
			
			model.addObject("projectname", projectname);
			model.addObject("theme", theme);
			model.addObject("title", "Settings");
		
			model.setViewName("settings");
		} else {
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value = { "/savesettings" }, method = RequestMethod.GET)
	public ModelAndView savesettings(@RequestParam("project") String project, @RequestParam("theme") String theme) throws DaoException  {
		
		System.out.println("project==="+project);
		String msg = applicatonService.saveSetting(project,theme);
		ModelAndView model = new ModelAndView();
		
		model.setViewName("settings");
		model.addObject("status", msg);
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Registration registration=registerService.getSettingDetails(register.getEmail());
		String theme1 = registration.getTheme();
		System.out.println("Theme-->"+theme1);
		String projectname = registration.getProject();
		System.out.println("Project--->"+projectname);
		//get seeting details i/p register.getEmail()
		
		
		model.addObject("projectname", projectname);
		model.addObject("theme", theme1);
		return model;

		
	}
	
	@RequestMapping(value="/picupload",method=RequestMethod.POST )
    public @ResponseBody void uploadFile(HttpServletRequest request, HttpServletResponse response,@RequestBody ApplicationDocument doc ){
        try{
            Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    		
           int responseStatus= applicatonService.savePhoto(register.getId(), doc.getDataURL());
            
            if (responseStatus != 0) {
				String json = new Gson().toJson("success");
				response.setContentType("application/json");
				response.getWriter().write(json);
			} else {
				String json = new Gson().toJson("failed");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
            
        }catch(Exception e){
        	e.printStackTrace();
        }
	
    }

	@RequestMapping(value = "/getProfile", method = RequestMethod.GET)
	public @ResponseBody void getProfile(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// List of Base64 String
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Registration registration = null;
		try {
			registration = registerService.loginCall(register.getEmail());
		} catch (DaoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (registration != null) {
			String json = new Gson().toJson(registration);
			response.setContentType("application/json");
			response.getWriter().write(json);
		} else {
			String json = new Gson().toJson("failed");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	}

	@RequestMapping(value = "/saveProfile", method = RequestMethod.POST)
	public @ResponseBody void saveProfile(@RequestBody Registration registration, HttpServletRequest request,
			HttpServletResponse response) throws IOException, DaoException {
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (registration != null && register != null) {
			// not editable fields
			registration.setId(register.getId());
			registration.setRole(register.getRole());
			registration.setEmail(register.getEmail());
			int status = registerService.updateRegistration(registration);
			registration.setFirstName(registration.getFirstName());
			registration.setLastname(registration.getLastname());
			registration.setPhone(registration.getPhone());
			registration.setCountry(registration.getCountry());
			registration.setState(registration.getState());
			registration.setPincode(registration.getPincode());
		//	registration.setEmail(registration.getEmail());
            List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
             grantedAuths.add(new SimpleGrantedAuthority(registration.getRole()));
            Authentication authentication = new UsernamePasswordAuthenticationToken(registration, registration.getPassword(), grantedAuths);
            SecurityContextHolder.getContext().setAuthentication(authentication);

			if (status > 0) {
				String json = new Gson().toJson("success");
				response.setContentType("application/json");
				response.getWriter().write(json);
			} else {
				String json = new Gson().toJson("failed");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
		}
	}

	@RequestMapping(value = { "/changePasword" }, method = RequestMethod.GET)
	public ModelAndView changePasword(HttpServletRequest request, HttpServletResponse response) throws DaoException {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {

			Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication()
					.getPrincipal();
			Registration registration = registerService.getUser(register.getEmail());
			String password = ApplicationUtils.encryptPassword(registration.getPassword());
			model.addObject("title", "Change Password");
			model.addObject("message", "Welcome to updatePassword!");
			model.addObject("password", password);
			model.setViewName("changePassword");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "/updatePasword" }, method = RequestMethod.POST)
	public void updatePasword(@RequestBody ResetPassword resetPassword, HttpServletRequest request,
			HttpServletResponse response) throws DaoException, IOException {
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (resetPassword != null && register != null) {

			String encryptPassword = ApplicationUtils.encryptPassword(resetPassword.getPassword());
			register.setPassword(encryptPassword);
			int status = registerService.updatePassword(register);
			if (status > 0) {
				ServerResponse = "success";

			} else {
				ServerResponse = "failed";
			}
			String json = new Gson().toJson(ServerResponse);
			response.setContentType("application/json");
			response.getWriter().write(json);
		} else {
			String json = new Gson().toJson("failed");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}

	/****
	 * Upload Document
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	public @ResponseBody void uploadDocument(MultipartHttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String uploadStatus = null;
		String envelopeId = "";
		List<String> docList = new ArrayList<String>();
		String signtype = request.getParameter("signtype");
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		if (ipAddress == null) {
			ipAddress = request.getRemoteAddr();
		}

		// Step 1: check file extension(handle in javaScript)
		MultipartFile multipartFile = request.getFile("files");
		if(!upgrade(register.getId()))
		{
			
		
		if (multipartFile != null) {
			
			
			
			DocUtils docUtils = new DocUtils();

			Path path = docUtils.resizePDF(multipartFile); // Step 2: resize PDF
															// (8.5* 11 if not)

			envelopeId = new GlobalFunctions().uniqueToken(); // Step 3: create
																// envelopeId
																// and refDocId
			String refDocId = CommonUtils.randomString(10);

			ClientEFA c = new ClientEFA();
			String efaStatus = c.efaStore(c, "DocumentObject1", envelopeId, refDocId, path.toAbsolutePath().toString()); // Step
																															// 4:
																															// save
																															// PDF
																															// in
																															// EFA

			// DocUtils.deletePDF(path); // Step 5:delete PDF

			if (efaStatus == "success") {

				// Step 6 :Store Meta data in SQL Server Status 101(Draft)
				String docId = applicatonService.insertDocument(register.getId(), multipartFile.getOriginalFilename(),
						envelopeId, refDocId, 0, "A", signtype, ipAddress, 101);

				if (docId != null) {
					String draftId = applicatonService.insertDraft(Integer.parseInt(docId), 1, "");
					if (draftId != null) {
						docList.add(docId);
						docList.add(draftId);

						String json = new Gson().toJson(docList);
						response.setContentType("application/json");
						response.getWriter().write(json);

					} else {
						uploadStatus = "failed"; // Draft Issue handlle
						String json = new Gson().toJson(uploadStatus);
						response.setContentType("application/json");
						response.getWriter().write(json);
					}
				} else {
					uploadStatus = "failed"; // docID issue
					String json = new Gson().toJson(uploadStatus);
					response.setContentType("application/json");
					response.getWriter().write(json);
				}
			} else {
				uploadStatus = "failed"; // efa issue
				String json = new Gson().toJson(uploadStatus);
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
		}
		}else
		{
			uploadStatus = "subscriptionend"; // subscription end
			String json = new Gson().toJson(uploadStatus);
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	}

	/*****
	 * 
	 * @param docId
	 * @param fileName
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/getDocument", method = RequestMethod.GET)
	public @ResponseBody void getDocument(@RequestParam(value = "docId") String docId,
			@RequestParam(value = "fileName") String fileName, @RequestParam(value = "draftId") String draftId,@RequestParam(value = "flag") String flag,@RequestParam(value = "step") String step,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		// List of Base64 String
		File f = null;
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (docId != null && fileName != "") {

			try {
				ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(docId),register.getId());
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
						if(flag != "draft"){
							applicatonService.updateDraft(Integer.parseInt(step), Integer.parseInt(draftId), "",0);
						}
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

	@RequestMapping(value = "/img")
	public @ResponseBody  void img(@RequestParam("fileid") String fileid, @RequestParam("filename") String fname,
			@RequestParam("page") String fpage,@RequestParam("numpages") int numpages, RedirectAttributes attr, HttpServletResponse response) {
		// logger.info(String.format("img(fileid= %s, fname = %s, fpage = %s)",
		// fileid, fname, fpage));
		/*File f = new File(fname);
		//Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		try {
		
			if (f.exists()) {
				ApplicationUtils.writeImageToBrowser(response, f, fpage);
			} else {
				// logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}
			//f.deleteOnExit();
		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		} finally {
		
		}*/
		
/*		File f = null;
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		try {
			// File f = new File(path + fname);
			ApplicationDocument doc = applicatonService.getDocument(Integer.parseInt(fileid),register.getId());

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
		}*/
		
		
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

	@RequestMapping(value = "/step2SelfSign", method = RequestMethod.POST)
	public @ResponseBody void step2SelfSign(HttpServletRequest request, HttpServletResponse response,
			@RequestBody DocumentField doc) throws IOException, DaoException {
		HttpSession session = request.getSession(false);
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (session != null) {
			
			if( doc.getDocId() !=0){
				ApplicationDocument document = applicatonService.getDocument(doc.getDocId(),register.getId());
				if(document == null){
					String json = new Gson().toJson("invalid");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}
				else if(!document.getDocStatus().equals("103") && doc!=null){
					String responseStatus = applicatonService.updateDraft(doc.getStepNumber(), doc.getDraftId(), doc.getFieldHtml(),doc.getIncrement());
					document.setUpdatedOn(CommonUtils.currentDate());
					applicatonService.updateDocument(document);
					if (responseStatus.equalsIgnoreCase("success")) {
						String json = new Gson().toJson("success");
						response.setContentType("application/json");
						response.getWriter().write(json);
					} else {
						String json = new Gson().toJson("failed");
						response.setContentType("application/json");
						response.getWriter().write(json);
					}
			    }else if(document.getDocStatus().equals("103")){
			    	String json = new Gson().toJson("103");
					response.setContentType("application/json");
					response.getWriter().write(json);
			    }
			  }else{
				    String json = new Gson().toJson("invalid");
					response.setContentType("application/json");
					response.getWriter().write(json);
			  }
		}	
	}

	@RequestMapping(value = "/saveSelfsign", method = RequestMethod.POST)
	public @ResponseBody void saveSelfsign(HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<DocumentField> documentField) throws IOException, DaoException {
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		DocUtils docUtils = new DocUtils();
		String signatureString = null;
		String responseStatus = null;
		File outputFile = new DocUtils().tempFile();
		
		if (!documentField.isEmpty()) {
			ApplicationDocument document = applicatonService.getDocument(documentField.get(0).getDocId(),register.getId());
			if(document == null){
				String json = new Gson().toJson("invalid");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}else
			if(!document.getDocStatus().equals("103") && document!=null){
			for (DocumentField df : documentField) {
				// Replace PX
				//df.setLeft(df.getLeft().replaceAll("px", ""));
				//df.setTop(df.getTop().replaceAll("px", ""));
				// set page number
				df.setPageNumber(df.getPageNumber()-1);
				// set top position
				//df.setTop(String.valueOf(docUtils.getTopPosition(df.getPageNumber(), Float.parseFloat(df.getTop()), df.getPageHeight())));
				
				df.setxPosition(Float.parseFloat(df.getLeft()));
				df.setyPosition(Float.parseFloat(df.getTop()));
				if (df.getFieldType().equalsIgnoreCase("image") || df.getFieldType().equalsIgnoreCase("checkbox")) {
					try {
						signatureString = docUtils.modifySignatureData(df.getFieldValue());
						df.setFieldValue(docUtils.createSignature(signatureString,209,40));

					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				df.setUserId(register.getId());
			}
			File file = null;
			// InputStream is = null;
			String writefileName = null;
			try {
				//ApplicationDocument document = applicatonService.getDocument(documentField.get(0).getDocId());
				// create temp file
				// file = ApplicationUtils.stream2file(document.getOriginal());
				// 1.Read document
				ClientEFA c = new ClientEFA();
				String fileName = c.efaLookUp(c, "DocumentObject1", document.getEnvelopeId(), document.getOriginalId());
				file = new File(fileName);

				writefileName = docUtils.writeDocumentFields(documentField, file,outputFile);

				String eRefDocId = CommonUtils.randomString(10);
				c.efaStore(c, "DocumentObject1", document.getEnvelopeId(), eRefDocId, writefileName);
				applicatonService.updateRefDocId(documentField.get(0).getDocId(), eRefDocId, "electronic");
				
				String digiRefDocId = CommonUtils.randomString(10);
				File digitaltemp = new File(TEMP_DIGITAL_URL + digiRefDocId+".pdf");
				ApplicationUtils ap = new ApplicationUtils();
				ap.createDigitalSignature(outputFile, digitaltemp, document.getEnvelopeId());

				applicatonService.saveDocumentFields(documentField);

				String dRefDocId = CommonUtils.randomString(10);
				c.efaStore(c, "DocumentObject1", document.getEnvelopeId(), dRefDocId, digitaltemp.getAbsolutePath());
				applicatonService.updateRefDocId(documentField.get(0).getDocId(), dRefDocId, "digital");

				document.setStatus(1);
				document.setDocStatus("103");
				document.setCompletedOn(CommonUtils.currentDate());
				document.setSubject(documentField.get(0).getSubject());
				document.setMessage(documentField.get(0).getMessage());
				applicatonService.updateDocument(document);

				applicatonService.deleteDraft(document.getId());

				if (documentField.get(0).getType().equals("send")) {

					// int emailStatus=emailSender.sendMail(register.getEmail(),
					// to, subject, message);

					Notification notification = new Notification();
					notification.setDocId(document.getId());
					notification.setUserId(document.getUserId());
					notification.setFrom(register.getEmail());
					notification.setTo(documentField.get(0).getTo());
					notification.setCc(documentField.get(0).getCc());
					notification.setSubject(documentField.get(0).getSubject());
					notification.setMessage(documentField.get(0).getMessage());
					notification.setStatus("success");
					notification.setReason("ok");
					notification.setCreatedOn(CommonUtils.currentDate());

					applicatonService.saveNotification(notification);
					
					emailSender.sendMail(register.getEmail(),documentField.get(0).getTo(),documentField.get(0).getCc(),documentField.get(0).getSubject(),documentField.get(0).getMessage(),digitaltemp.getAbsolutePath(),document.getFileName());
				}

				digitaltemp.delete();

				responseStatus = "success";
			} catch (DaoException de) {
				// logger.error("Error while reading document for self sign:
				// "+de);
				responseStatus = "failed";
			} catch (Exception e) {
				// logger.error("Error while writing values on document for self
				// sign: "+e);
				responseStatus = "failed";
			} finally {
				// if(is!=null){is.close();}
				if (file != null) {
					file.delete();
				}
				if(outputFile != null){
					outputFile.delete();
					outputFile.deleteOnExit();
				}
			}
			if (responseStatus.equalsIgnoreCase("success")) {
				String json = new Gson().toJson("success");
				response.setContentType("application/json");
				response.getWriter().write(json);
			} else {
				String json = new Gson().toJson("failed");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
		  }else if(document.getDocStatus().equals("103")){
				String json = new Gson().toJson("103");
				response.setContentType("application/json");
				response.getWriter().write(json);
		  }
		} else {
			String json = new Gson().toJson("invalid");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	}

	@RequestMapping(value = "/deleteDocument", method = RequestMethod.GET)
	public @ResponseBody void deleteDocument(@RequestParam(value = "docId") String docId, HttpServletRequest request,
			HttpServletResponse response) throws IOException, NumberFormatException, DaoException {
		
		
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if (docId != null) {
			ApplicationDocument document = applicatonService.getDocument(Integer.parseInt(docId),register.getId());
			if(document == null){
				String json = new Gson().toJson("invalid");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}else if(!document.getDocStatus().equals("103") && document!=null){
				applicatonService.deleteDocument("104", Integer.parseInt(docId),register.getId());
				String json = new Gson().toJson("success");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}else if(document.getDocStatus().equals("103")){
				String json = new Gson().toJson("103");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
		} else  {
			String json = new Gson().toJson("invalid");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	}
	
	@RequestMapping(value = "/deleteDocumentByEnvelopeId", method = RequestMethod.GET)
	public @ResponseBody void deleteDocumentByEnvelopeId(@RequestParam(value = "docId") String envelopeId, HttpServletRequest request,
			HttpServletResponse response) throws IOException, NumberFormatException, DaoException {
		
		
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		
		if (envelopeId != null) {
			int docId=applicatonService.getDocumentId(envelopeId, register.getId());
			ApplicationDocument document = applicatonService.getDocument(docId,register.getId());
			if(document == null){
				String json = new Gson().toJson("invalid");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}else if(!document.getDocStatus().equals("103") && document!=null){
				applicatonService.deleteDocument("104",docId,register.getId());
				String json = new Gson().toJson("success");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}else if(document.getDocStatus().equals("103")){
				String json = new Gson().toJson("103");
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
		} else  {
			String json = new Gson().toJson("invalid");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	}

	/**
	 * @author Sanket.Navale view and download a file from - inside project,
	 *         located in resources folder. - outside project, located in File
	 *         system somewhere.
	 * @param response
	 * @param type
	 * @throws IOException
	 * @throws DaoException
	 * @throws NumberFormatException
	 */
	@RequestMapping(value = "/downloadFiles/{type}", method = RequestMethod.GET)
	public @ResponseBody void downloadFiles(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type) throws IOException, NumberFormatException, DaoException {
		String docId = request.getParameter("docId");
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ApplicationDocument document = applicatonService.getDocument(Integer.parseInt(docId),register.getId());

		ClientEFA c = new ClientEFA();
		String fileName = c.efaLookUp(c, "DocumentObject1", document.getEnvelopeId(), document.getDigitalld());
		
		File f = new File(fileName);
		String json = new Gson().toJson(f.getName());
		response.setContentType("application/json");
		try {
			response.getWriter().write(json);
		} catch (IOException e2) {
			// logger.error("Error while write json to response : " +
			// e2.getMessage());
		} finally {
			// f.delete();

		}
	}

	/**
	 * @author Sanket.Navale view and download a file from - inside project,
	 *         located in resources folder. - outside project, located in File
	 *         system somewhere.
	 * @param response
	 * @param type
	 * @throws IOException
	 * @throws DaoException 
	 * @throws NumberFormatException 
	 */
	@RequestMapping(value = "/download/{type}", method = RequestMethod.GET)
	public @ResponseBody void downloadFile(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type) throws IOException, NumberFormatException, DaoException {

		File file = null;
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String fileName = request.getParameter("fileName");
		String docId = request.getParameter("docId");
		ApplicationDocument document = applicatonService.getDocument(Integer.parseInt(docId),register.getId());
		file = new File(EFA_FILE_PATH + fileName);
		if (!file.exists()) {
			String errorMessage = "Please do not refresh browser.";
			 
			// System.out.println(errorMessage);
			OutputStream outputStream = response.getOutputStream();
			outputStream.write(errorMessage.getBytes(Charset.forName("UTF-8")));
			outputStream.close();
			return ;
		}

		String mimeType = URLConnection.guessContentTypeFromName(file.getName());
		if (mimeType == null) {
			// System.out.println("mimetype is not detectable, will take 
			// default");
			mimeType = "application/octet-stream";
		}
		// System.out.println("mimetype : " + mimeType);
		response.setContentType(mimeType);
		if (type.equalsIgnoreCase("internal")) {
			response.setHeader("Content-Disposition", String.format("inline; filename=\"" +document.getFileName() + "\""));
		} else {
			response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", document.getFileName()));
		}
		response.setContentLength((int) file.length());
		InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
		// Copy bytes from source to destination(outputstream in this example),
		// closes both streams.
		FileCopyUtils.copy(inputStream, response.getOutputStream());

		inputStream.close();
		file.delete();

	}
	
	@RequestMapping(value = "/saveSignature", method = RequestMethod.POST)
	public @ResponseBody void saveSignature(HttpServletRequest request, HttpServletResponse response,
			@RequestBody ApplicationDocument doc) throws IOException, DaoException {

		HttpSession session = request.getSession(false);
		if (session != null) {
			Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication()
					.getPrincipal();
			Signature userSignature = new Signature();
			//String uniqueID = new GlobalFunctions().uniqueToken();
			userSignature.setFirstName(register.getFirstName());
			userSignature.setLastName(register.getLastname());
			userSignature.setEmail(register.getEmail());
			userSignature.setStatus(1);
			userSignature.setSignature(doc.getDataURL());
			userSignature.setSignType(doc.getSignType());
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
	}

	@RequestMapping(value = "/saveSignerList", method = RequestMethod.POST)
	public @ResponseBody void saveSignerList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<DocumentField> documentField) throws IOException {
		HttpSession session = request.getSession(false);
		String responseStatus=null;
		if (session != null) {
			if(!documentField.isEmpty()){
				if(documentField.get(0).getSignType().equals("G")){
					responseStatus=	applicatonService.saveTempSigner(documentField);
					//applicatonService.updateDraft(2, documentField.get(0).getDraftId(), "", 0);
				}
				if (responseStatus.equalsIgnoreCase("success")) {
					String json = new Gson().toJson("success");
					response.setContentType("application/json");
					response.getWriter().write(json);
				} else {
					String json = new Gson().toJson("failed");
					response.setContentType("application/json");
					response.getWriter().write(json);
				}
			}else{
					String json = new Gson().toJson("failed");
					response.setContentType("application/json");
					response.getWriter().write(json);
			}
		}
	}
	
	@RequestMapping(value = "/getSignerList", method = RequestMethod.GET)
	public @ResponseBody void createTypeFonts(@RequestParam(value = "docId") String docId, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		if (docId != null && docId != "") {
			List<DocumentField> documentFieldList = applicatonService.getTempSigner(Integer.parseInt(docId));
			String json = new Gson().toJson(documentFieldList);
			response.setContentType("application/json");
			response.getWriter().write(json);
		} else {
			String json = new Gson().toJson("failed");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}

	@RequestMapping(value = "/saveGroupSign", method = RequestMethod.POST)
	public @ResponseBody void saveGroupSign(HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<DocumentField> documentField) throws IOException, DaoException {
		String status="failed";
		//1.Check document is exist or not
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (!documentField.isEmpty()) {
			ApplicationDocument document = applicatonService.getDocument(documentField.get(0).getDocId(),register.getId());
			if(document !=null && !document.getDocStatus().equals("103")){
				DocUtils docUtils = new DocUtils();
				
				List<Signer> signerList=docUtils.removeDuplicateSignerData(documentField);
				
				for(Signer s:signerList){
					if(documentField.get(0).getIsActivePriority().equals("inactive"))
					{
						s.setPriority(0);
					}
					Registration r=registerService.getUser(s.getSignerEmail());
					s.setUserId(r.getId());
					s.setDocId(document.getId());
					s.setSignerUrl(CommonUtils.randomString(25));
					s.setSignerName(WordUtils.capitalizeFully(s.getSignerName()));
					System.out.println(s.getSignerName());
					int signerId=applicatonService.saveGroupSigner(s);
					s.setSignerId(signerId);	
					
				}
				for(DocumentField df:documentField){
					for(Signer s1:signerList){
						if(s1.getSignerEmail().equalsIgnoreCase(df.getSignerEmail())){
							df.setUserId(s1.getSignerId());
						}
					}
					if(documentField.get(0).getIsActivePriority().equals("inactive"))
					{
						df.setPriority(0);
					}
					
					//df.setFieldValue(df.getSignerName());
					//df.setLeft(df.getLeft().replaceAll("px", ""));
					//df.setTop(df.getTop().replaceAll("px", ""));
					//df.setPageNumber(docUtils.getPageNumber(Float.parseFloat(df.getTop()),df.getPageHeight()));
					// set top position
					//df.setTop(String.valueOf(docUtils.getTopPosition(df.getPageNumber(), Float.parseFloat(df.getTop()), df.getPageHeight())));
					
					df.setxPosition(Float.parseFloat(df.getLeft()));
					df.setyPosition(Float.parseFloat(df.getTop()));
					
				}	
				status=applicatonService.saveGroupSignFields(documentField);
			if(status =="success"){
					for(Signer s:signerList){
						//get token from signer
						String token="";
						if(s.getPriority() != 0 && s.getPriority() == 1){
							token=applicatonService.getSignerToken(s.getSignerId());
							if(token !=null && token !=""){
								String subject = "DrySign:"+documentField.get(0).getSubject();
								String url = SERVER_URL + "signDocument?key="+token;
								String signer=s.getSignerName();
								String requestBy=register.getFirstName()+" "+register.getLastname();
								String body="\t\t\t<b>Hi "+signer+",</b><br />\r\n\t\t\t\t\t\t\t<p>You have been requested by "+WordUtils.capitalize(requestBy)+" to sign a document in DrySign."+WordUtils.capitalize(requestBy)+" has sent you the following message: <b>"+documentField.get(0).getMessage()+"</b>.</p>\r\n\t\t\t\t\t\t\t    <p>Kindly sign the document by clicking the link below:</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Sign Document</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
								
								String emailStatus=emailSender.sendMail(SUPPORT_EMAIL, s.getSignerEmail(),null, subject, body, url);
								
								Notification notification = new Notification();
								notification.setDocId(document.getId());
								notification.setUserId(document.getUserId());
								notification.setFrom(register.getEmail());
								notification.setTo(s.getSignerEmail());
								notification.setCc(documentField.get(0).getCc());
								notification.setSubject(documentField.get(0).getSubject());
								notification.setMessage(documentField.get(0).getMessage());
								notification.setStatus(emailStatus == "1" ? "success" :"failed");
								notification.setReason(emailStatus == "1" ? "ok" :"failed");
								notification.setCreatedOn(CommonUtils.currentDate());
								
								//save email status
								applicatonService.saveNotification(notification);
								break;
							}
						}else if(s.getPriority() == 0){
							token=applicatonService.getSignerToken(s.getSignerId());
							if(token !=null && token !=""){
								String subject = "DrySign:"+documentField.get(0).getSubject();
								String url = SERVER_URL + "signDocument?key="+token;
								
								String requestBy=register.getFirstName()+" "+register.getLastname();
								String body="\t\t\t<b>Hi "+s.getSignerName()+",</b><br />\r\n\t\t\t\t\t\t\t<p>You have been requested by "+WordUtils.capitalize(requestBy)+" to sign a document in DrySign."+WordUtils.capitalize(requestBy)+" has sent you the following message: <b>"+documentField.get(0).getMessage()+"</b>.</p>\r\n\t\t\t\t\t\t\t    <p>Kindly sign the document by clicking the link below:</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Sign Document</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
								
								String emailStatus=emailSender.sendMail(SUPPORT_EMAIL, s.getSignerEmail(),null, subject, body, url);
								
								Notification notification = new Notification();
								notification.setDocId(document.getId());
								notification.setUserId(document.getUserId());
								notification.setFrom(register.getEmail());
								notification.setTo(s.getSignerEmail());
								notification.setCc(documentField.get(0).getCc());
								notification.setSubject(documentField.get(0).getSubject());
								notification.setMessage(documentField.get(0).getMessage());
								notification.setStatus(emailStatus == "1" ? "success" :"failed");
								notification.setReason(emailStatus == "1" ? "ok" :"failed");
								notification.setCreatedOn(CommonUtils.currentDate());
								
								//save email status
								applicatonService.saveNotification(notification);
							}
						}
						
						
					}
				}
				}else{
					status="failed";
				}
			}else{
			status="failed";
		}
		
		
		String json = new Gson().toJson(status);
		response.setContentType("application/json");
		response.getWriter().write(json);
	}
	
/*	@RequestMapping(value = { "/getpic" }, method = RequestMethod.GET)
	public ModelAndView getpic(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);
		ModelAndView model = new ModelAndView();
		if (session != null) {
			Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String pic=applicatonService.getpic(user.getId(), 1);
			model.addObject("mypic",pic);
			model.setViewName("profile");
		} else {
			model.setViewName("login");
		}
		return model;
}*/
	@RequestMapping(value = "/history/sendemail", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String submitquery(@RequestParam("subject") String subject,@RequestParam("email") String email,@RequestParam("message") String message,@RequestParam("docId") String docId,@RequestParam("cc") String cc) throws DaoException {
		String status = "";
		//File file = null;
		//String name = n.getName();
	//	String email = n.getEmail();
		//String message = n.getMessage();
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String token = new GlobalFunctions().uniqueToken();
			ApplicationDocument document = applicatonService.getDocument(Integer.parseInt(docId),register.getId());
			ClientEFA c = new ClientEFA();
			String fileName = c.efaLookUp(c, "DocumentObject1", document.getEnvelopeId(), document.getDigitalld());
			
			File oldfile =new File(fileName);
			String name= document.getFileName();

		//	File f = new File(fileName);
			System.out.println("file-- "+ fileName+" document name is - "+name);
			//String test =EFA_FILE_PATH + document.getFileName();
			//	String subject = "DrySign Query from - "+name+" and email id - "+email;
			//	String url = SERVER_URL + "resetPassword?token=" + token + "&userid=" + status + "&email=" + email;
			//	String body="\t\t\t<b>Reset your password,</b><br />\r\n\t\t\t\t\t\t\t    <p>You are receiving this email because a request was made to reset the password for your DrySign account <a>"+email+"</a>.</p>\r\n\t\t\t\t\t\t\t    <p>If you did not ask to reset your password, then you can ignore this email and your password will not be changed.</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Reset Password</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
				try {
					status=emailSender.sendMail( SUPPORT_EMAIL,email,cc, subject, message,oldfile.getAbsolutePath(),name);
				} catch (Exception e) {
					// logger.error("Error while sending email to user:"+email+" when forgot password: "+e);
				}
			
		

		return status;
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
	
	@RequestMapping(value = "/resizeSignature", method = RequestMethod.POST)
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
	
	
	@ResponseBody
    @RequestMapping(value="/history/sendreminder", method=RequestMethod.POST)
    public  String sendReminder( HttpServletRequest request) throws DaoException
	{
		String message = "";
			String token=applicatonService.getSignerToken(Integer.parseInt(request.getParameter("signerId")));
			String subject = "DrySign: " + request.getParameter("subject");
			String url = SERVER_URL + "signDocument?key=" + token;
			String body = "\t\t\t<b>Hi "+request.getParameter("signerName")+",</b><br />\r\n\t\t\t\t\t\t\tReminder! </br/><br/>"
					+ "You have been requested by " + request.getParameter("requestedBy")
					+ " to sign a document in DrySign. " + "<br/>" + request.getParameter("requestedBy")
					+ " has sent you the following message: " + request.getParameter("message") + ""
					+ "</br/> <br/> Kindly sign the document by clicking on this link:</br> <br/> <a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href='" + url
					+ "'>Sign Document</a><br>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.";

			try {
				emailSender.sendMail1(SUPPORT_EMAIL,request.getParameter("signerEmailId"),null , subject, body);
				message = "Reminder has been sent successfully.";
				logger.info(body);
			} catch (Exception e) {
				message = "Error while sending reminder to signer: " + e.getMessage();
				logger.error("Error while sending reminder to signer: " + e.getMessage());
			}
		

		return message;
	}

	@ResponseBody
	@RequestMapping(value = "/history/sendReAssign", method = RequestMethod.POST)
	public String sendReAssign(HttpServletRequest request) throws DaoException {
		String status = null;
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String signerName = request.getParameter("signerName");
		String requestBy = request.getParameter("requestedBy");
		String signerId = request.getParameter("signerId");
		String docId = request.getParameter("docId");
		String newEmail = request.getParameter("newEmail");
		String oldEmail = request.getParameter("oldEmail");
		String subject1 = request.getParameter("subject");
		String signurl = CommonUtils.randomString(20);
		status = applicatonService.updateSignerEmail(signerName,signurl, Integer.parseInt(signerId), newEmail,Integer.parseInt(docId));
		String token = applicatonService.getSignerToken(Integer.parseInt(signerId));
		String url = SERVER_URL + "signDocument?key=" + token;
		
		//Send email-Old Email Id
		//Send email to new Email Id
		//String subject="DrySign: Cancel Document";
		//String body = "\t\t\t<b>Hi " + signerName + ",</b><br />\r\n\t\t\t\t\t\t\t <p>You don't have to sign the document.It has been assigned to someone else.</p>";
		//emailSender.sendMail1(SUPPORT_EMAIL, oldEmail,null,subject, body);
		
		
		
		//Send email to new Email Id
		String body1 = "\t\t\t<b>Hi " + signerName + ",</b><br />\r\n\t\t\t\t\t\t\t    <p>You have been requested by "
				+ requestBy
				+ " to sign a document in DrySign.</p>\r\n\t\t\t\t\t\t\t    <p>Kindly sign the document by clicking the link below:</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""
				+ url + "\">Sign Document</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
		String subject2="DrySign:"+subject1;
		emailSender.sendMail(SUPPORT_EMAIL, newEmail, null,subject2 , body1, url);
		
		//Send email to requestor
		//String body2 = "\t\t\t<b>Hi " + register.getFirstName() + ",</b><br />\r\n\t\t\t\t\t\t\t <p>The document has been reassigned to "+newEmail+".</p>";
		
		//String subject3="ReAssign:"+subject1;
		//emailSender.sendMail1(SUPPORT_EMAIL, register.getEmail(),null,subject3, body2);
				
		
		return status;
	}
	
	@ResponseBody
	@RequestMapping(value = "/history/sendDiscard", method = RequestMethod.POST)
	public HashMap<String, String> sendDiscard(HttpServletRequest request) throws DaoException, IOException {
		String status = "FAILURE";
		HashMap<String, String> map = new HashMap<String, String>();
		int signerId = Integer.parseInt(request.getParameter("signerId"));
		int priority = Integer.parseInt(request.getParameter("priority"));
		int docId = Integer.parseInt(request.getParameter("docId"));
		String subject = request.getParameter("subject");
		String messgae = request.getParameter("message");
		String signername = request.getParameter("signerName");
		String signerEmailId = request.getParameter("signerEmailId");
		
		
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (docId != 0 && signerId != 0) {

			List<Signer> signer = applicatonService.getSignerList(docId);
			status = applicatonService.removeSigner(docId, signerId);
			// size 1:Discard document
			if (signer.size() == 1) {

				if (signer.get(0).getSignerId() == signerId) {
					if (status.equalsIgnoreCase("SUCCESS")) {
						status = applicatonService.deleteDocument("104", docId, register.getId());
					}
					map.put(status, "You have successfully remove signer and document has also deleted");
				}
			} else {
				boolean isNotAvailable = applicatonService.getAllSignerStatus(docId, signerId);
				if(isNotAvailable == true){
					//Apply digital signature
					File outputFile = new DocUtils().tempFile();
					String digiRefDocId = CommonUtils.randomString(10);
					ApplicationDocument doc = applicatonService.getDocument(docId,register.getId());
					File f = null;
					File digitaltemp = new File(TEMP_DIGITAL_URL + digiRefDocId+".pdf");
					ApplicationUtils ap = new ApplicationUtils();
					ClientEFA c=new ClientEFA();
					if(doc.getElectronicId() == null){
						String fileName=c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getOriginalId());
						f=new File(fileName); 
						
					}else{
						String fileName=c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getElectronicId());
						f=new File(fileName); 
					}
					
					ap.createDigitalSignature(f, digitaltemp, doc.getEnvelopeId());
					String dRefDocId = CommonUtils.randomString(10);
					c.efaStore(c, "DocumentObject1", doc.getEnvelopeId(), dRefDocId, digitaltemp.getAbsolutePath());
					applicatonService.updateRefDocId(doc.getId(), dRefDocId, "digital");

					doc.setStatus(1);
					doc.setDocStatus("103");
					doc.setCompletedOn(CommonUtils.currentDate());
					status =applicatonService.updateDocument(doc);
					status="500";
					
				
					String subject1="DrySign:"+doc.getSubject();
					String body="\t\t\t<b>Hi "+register.getFirstName()+" "+register.getLastname() +",</b><br />\r\n\t\t\t\t\t\t\t<p>Your document has been signed by all signees.You may view the status of your document at any time by logging into DrySign.</p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
					//sent email to requester with attachments
					emailSender.sendMail(SUPPORT_EMAIL, register.getEmail(), doc.getCc(), subject1, body, digitaltemp.getAbsolutePath(), doc.getFileName());
					
				}else{
						if (signer.get(0).getPriority() > 0) {
						// UPDATE PRIORITY
						int signerPriority=priority+1;
						Signer nextSignger=applicatonService.nextSignerData(docId, signerPriority);
						int i = 1;
						for (Signer s : signer) {
							if (s.getSignerId() != signerId) {
								s.setPriority(i);
								s.setDocId(docId);
								status = applicatonService.updateSignerPriority(s);
								i++;
							}
						}
						//next forward
						
						String subject1 = "DrySign:"+subject;
						String url = SERVER_URL + "signDocument?key="+nextSignger.getSignerUrl();

						String signerName=nextSignger.getSignerName();
						String requestBy=register.getFirstName()+" "+register.getLastname();
						String body="\t\t\t<b>Hi "+signerName+",</b><br />\r\n\t\t\t\t\t\t\t<p>You have been requested by "+requestBy+" to sign a document in DrySign."+requestBy+" has sent you the following message: "+messgae+".</p>\r\n\t\t\t\t\t\t\t    <p>Kindly sign the document by clicking the link below:</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Sign Document</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
						emailSender.sendMail(SUPPORT_EMAIL, nextSignger.getSignerEmail(),null, subject1, body, url);
					}
				}
				
				// get all signer status
				
				
				
				map.put(status, "You have successfully remove signer");
			}
			
			//Send email to requestor
		//	String body2 = "\t\t\t<b>Hi " + signername + ",</b><br />\r\n\t\t\t\t\t\t\t <p>The document has been discard.You don't have to sign the document</p>";
			
		//	String subject3="Discard:"+subject;
		//	emailSender.sendMail1(SUPPORT_EMAIL, signerEmailId,null,subject3, body2);
			
			//Send email to requestor
		//	String body3 = "\t\t\t<b>Hi " + register.getFirstName()+" "+register.getLastname() + ",</b><br />\r\n\t\t\t\t\t\t\t <p>The document has been discard to "+signerEmailId+"</p>";
			
			//emailSender.sendMail1(SUPPORT_EMAIL, register.getEmail(),null,subject3, body3);

		}
		return map;
	}
	
	@RequestMapping(value = "/submitfeedback", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String submitquery(@RequestParam("name") String name,@RequestParam("email") String email,@RequestParam("message") String message) {
		String status = "";
		//String name = n.getName();
	//	String email = n.getEmail();
		//String message = n.getMessage();
		
			String token = new GlobalFunctions().uniqueToken();
				String subject = "DrySign Feedback from - "+name+" and email id - "+email;
			//	String url = SERVER_URL + "resetPassword?token=" + token + "&userid=" + status + "&email=" + email;
			//	String body="\t\t\t<b>Reset your password,</b><br />\r\n\t\t\t\t\t\t\t    <p>You are receiving this email because a request was made to reset the password for your DrySign account <a>"+email+"</a>.</p>\r\n\t\t\t\t\t\t\t    <p>If you did not ask to reset your password, then you can ignore this email and your password will not be changed.</p>\r\n\t\t\t\t\t\t\t\t<p style=\"text-align: center\"> \r\n\t\t\t\t\t\t\t\t<a style=\"background: #00bc9c; color: #fff; padding: 5px 20px;border-radius: 4px;text-transform: uppercase;    text-decoration: none;\" href=\""+url+"\">Reset Password</a></p>\r\n\t\t\t\t\t\t\t\t<p>The Team at DrySign.</p>";
				try {
					status=emailSender.sendMail( email,SUPPORT_EMAIL, subject, message);
				} catch (Exception e) {
					// logger.error("Error while sending email to user:"+email+" when forgot password: "+e);
				}
			
		

		return status;
	}
	@RequestMapping(value="/saveDropoxChooserFile",method=RequestMethod.POST,produces = {"application/json"})
	public @ResponseBody void saveDropoxChooserFile(@RequestBody OneDriveResource oneDriveResource,HttpServletResponse response, HttpServletRequest request) throws DaoException{
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//ResponseEntity< GoogleDriveResource>  response = null;
		 String urlStr=new String(oneDriveResource.getDownloadedUrl());
		 String uploadStatus = null;
		try {
			String ipAddress = request.getHeader("X-FORWARDED-FOR");
			String signtype = request.getParameter("signtype");
			List<String> docList = new ArrayList<String>();
			if (ipAddress == null) {
				ipAddress = request.getRemoteAddr();
			}
			
			if(!upgrade(register.getId()))
			{
			
			if(oneDriveResource.getFileName() != null)
			{
		       Path filePath = FileSystems.getDefault().getPath(DRIVE_PATH, oneDriveResource.getFileName());
		
		       ExternalAppResourceUtil.downloadUsingNIO(urlStr, filePath.toString());
		       
		       String envelopeId = "";
				envelopeId = new GlobalFunctions().uniqueToken();

				String refDocId = CommonUtils.randomString(10);

				ClientEFA c = new ClientEFA();
				String efaStatus = c.efaStore(c, "DocumentObject1", envelopeId, refDocId,DRIVE_PATH + oneDriveResource.getFileName());
				System.out.println("Done");
				

				if (efaStatus == "success") {

					// Step 6 :Store Meta data in SQL Server Status 101(Draft)
					String docId = applicatonService.insertDocument(register.getId(), oneDriveResource.getFileName(),
							envelopeId, refDocId, 0, "A", signtype, ipAddress, 101);

					if (docId != null) {
						String draftId = applicatonService.insertDraft(Integer.parseInt(docId), 1, "");
						if (draftId != null) {
							docList.add(docId);
							docList.add(draftId);

							String json = new Gson().toJson(docList);
							response.setContentType("application/json");
							response.getWriter().write(json);

						} else {
							uploadStatus = "failed"; // Draft Issue handlle
							String json = new Gson().toJson(uploadStatus);
							response.setContentType("application/json");
							response.getWriter().write(json);
						}
					} else {
						uploadStatus = "failed"; // docID issue
						String json = new Gson().toJson(uploadStatus);
						response.setContentType("application/json");
						response.getWriter().write(json);
					}
				} else {
					uploadStatus = "failed"; // efa issue
					String json = new Gson().toJson(uploadStatus);
					response.setContentType("application/json");
					response.getWriter().write(json);
				}
		
			}
			}else
			{
				uploadStatus = "subscriptionend"; // subscription end
				String json = new Gson().toJson(uploadStatus);
				response.setContentType("application/json");
				response.getWriter().write(json);
			}	
		
		} catch (IOException e) {
			//response = new  ResponseEntity<GoogleDriveResource>(new GoogleDriveResource(),HttpStatus.FORBIDDEN);
		}
		
		
	//	return response ;
		
	}
	
	


/*Start Egnyte java code*/

@RequestMapping(value="/saveFileByEgnyte",method=RequestMethod.POST,produces = {"application/json"})
public @ResponseBody void saveFileByEgnyte(@RequestBody OneDriveResource oneDriveResource,HttpServletResponse response, HttpServletRequest request) throws DaoException{
	Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	//ResponseEntity< GoogleDriveResource>  response = null;
	 String urlStr=new String(oneDriveResource.getDownloadedUrl());
	 String uploadStatus = null;
	try {
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		String signtype = request.getParameter("signtype");
		List<String> docList = new ArrayList<String>();
		if (ipAddress == null) {
			ipAddress = request.getRemoteAddr();
		}
		
		if(!upgrade(register.getId()))
		{
		
		if(oneDriveResource.getFileName() != null)
		{
	       //Path filePath = FileSystems.getDefault().getPath(DRIVE_PATH, oneDriveResource.getFileName());
			String fileAbsPath = new DocUtils().StrStreamToFile(urlStr,oneDriveResource.getFileName());
	       //ExternalAppResourceUtil.downloadUsingNIO(urlStr, filePath.toString());
	       
	       String envelopeId = "";
			envelopeId = new GlobalFunctions().uniqueToken();

			String refDocId = CommonUtils.randomString(10);

			ClientEFA c = new ClientEFA();
			String efaStatus = c.efaStore(c, "DocumentObject1", envelopeId, refDocId,fileAbsPath);
			System.out.println("Done");
			

			if (efaStatus == "success") {

				// Step 6 :Store Meta data in SQL Server Status 101(Draft)
				String docId = applicatonService.insertDocument(register.getId(), oneDriveResource.getFileName(),envelopeId, refDocId, 0, "A", signtype, ipAddress, 101);

				if (docId != null) {
					String draftId = applicatonService.insertDraft(Integer.parseInt(docId), 1, "");
					if (draftId != null) {
						docList.add(docId);
						docList.add(draftId);

						String json = new Gson().toJson(docList);
						response.setContentType("application/json");
						response.getWriter().write(json);

					} else {
						uploadStatus = "failed"; // Draft Issue handlle
						String json = new Gson().toJson(uploadStatus);
						response.setContentType("application/json");
						response.getWriter().write(json);
					}
				} else {
					uploadStatus = "failed"; // docID issue
					String json = new Gson().toJson(uploadStatus);
					response.setContentType("application/json");
					response.getWriter().write(json);
				}
			} else {
				uploadStatus = "failed"; // efa issue
				String json = new Gson().toJson(uploadStatus);
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
	
		}
		}else
		{
			uploadStatus = "subscriptionend"; // subscription end
			String json = new Gson().toJson(uploadStatus);
			response.setContentType("application/json");
			response.getWriter().write(json);
		}	
	
	} catch (IOException e) {
		//response = new  ResponseEntity<GoogleDriveResource>(new GoogleDriveResource(),HttpStatus.FORBIDDEN);
	}
	
	
//	return response ;
	
}


}

/*End Egnyte java code*/
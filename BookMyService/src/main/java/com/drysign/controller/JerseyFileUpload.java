package com.drysign.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.ObjectWriter;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.drysign.dao.DaoException;
import com.drysign.efa.ClientEFA;
import com.drysign.model.ApplicationDocument;
import com.drysign.model.Audit;
import com.drysign.model.BackgroundSignDocument;
import com.drysign.model.BackgroundSignDocumentResponse;
import com.drysign.model.ClientAuth;
import com.drysign.model.ClientUser;
import com.drysign.model.CreateSignatureRequest;
import com.drysign.model.CreateSignatureResponse;
import com.drysign.model.DocumentSigner;
import com.drysign.model.DocumentSignerWrapper;
import com.drysign.model.Download;
import com.drysign.model.DownloadDocumentWrapper;
import com.drysign.model.Registration;
import com.drysign.model.RestDocument;
import com.drysign.model.RestDocumentField;
import com.drysign.model.SB_Purchase;
import com.drysign.service.JerseyService;
import com.drysign.utility.ApplicationUtils;
import com.drysign.utility.CommonUtils;
import com.drysign.utility.DateManipulation;
import com.drysign.utility.FileUtils;
import com.drysign.utility.GlobalFunctions;
import com.drysign.utility.UtilityException;
import com.ooc.CosNaming.Database.Create;


 /**
 * @author matadeen.sikarawar
 *
 */
@Path("/api")
@Controller
public class JerseyFileUpload extends SpringBeanAutowiringSupport{
	static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	static SecureRandom rnd = new SecureRandom();
	@Autowired
	private  JerseyService jerseyService;
	String className = this.getClass().getSimpleName();
	
	private final static Logger logger = Logger.getLogger(JerseyFileUpload.class);
	private static String SERVER_URL ;
	private static String TEMP_DIGITAL_URL = null;
	
	ObjectMapper mapper = new ObjectMapper();
	FileUtils fileUtils = new FileUtils();
	public JerseyFileUpload() {
		try {
			SERVER_URL = new GlobalFunctions().getServerUrl();
			TEMP_DIGITAL_URL = new GlobalFunctions().getTempAppDigitalSignPdfPath();
		} catch (UtilityException e) {
			logger.error("Error while getting upload path: "+e.getMessage());
		}
	}
	
	/* matadeen sikarwar
	 * /* Start REST json service for language independent
	 */
	
	
	@POST
	@Path("/preparedocumentapi")
	/*@Consumes("application/json")
	@Produces({ MediaType.APPLICATION_JSON })*/
	//@ApiOperation(value = "Gets a customer based on customer id", notes = "Retrieves a single customer", response = RestDocument.class)
    //@RequestMapping(method = RequestMethod.GET, produces = { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON }, value = "/jsoncreatedocument")
    //@ResponseBody
    public String prepareDocumentApi(@Context HttpServletRequest request,String jsondocument) {

		RestDocument document=null;
		try {
			document = mapper.readValue(jsondocument, RestDocument.class);
			ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
			
			if(document !=null)
			{
				String status = FileUtils.signersListValidate(document);
				if(status !=null && status=="1")
				{
				String fileName = document.getDocumentName();
				InputStream fileInputStream = FileUtils.StrToStream(document.getFilePath(),document.getDocumentName());
				
				jsondocument = createDocumentUtil(request, fileInputStream, fileName, jsondocument);
				
				//creating signers
				document = mapper.readValue(jsondocument, RestDocument.class);
				if(document.getEnvelopeId()!=null)
				{
					String prepareKey = randomString(25);
					String prepareUrl = SERVER_URL+"prepareDocument?key="+prepareKey;
					String readOnlyUrl = SERVER_URL+"viewReadOnlyDocument?envelopeid="+document.getEnvelopeId();
					document.setUrl(prepareUrl);
					document.setViewDocumentUrl(readOnlyUrl);
					status = insertSigners(prepareKey,document);
					
					document.setStatus("success");
					jsondocument = ow.writeValueAsString(document);
				}
				}else{
					
					document.setStatus(status);
					jsondocument = ow.writeValueAsString(document);
				}
			}
			
		} catch (IOException e1) {
			logger.error("Error while jsonCreateDocument: "+e1);
		}

		
	return jsondocument;
    }
	
	/* matadeen sikarwar
	 * /* End REST json service for language independent
	 */

	/* matadeen sikarwar
	 * /* Start REST service for java users
	 */
	@POST
	@Path("/createdocument")
	@Consumes({ MediaType.MULTIPART_FORM_DATA })
	public Response createDocument(@Context HttpServletRequest request,@FormDataParam("file") InputStream fileInputStream, @FormDataParam("file") FormDataContentDisposition fileMetaData, @FormDataParam("jsonDocumentWrapper") String jsonObject, @HeaderParam("Authorization") String auth)
	{
		
		String classMethod = className+ ":  createDocument" ;
		logger.info(String.format("Enter into "+classMethod+"(fileInputStream = %s, fileMetaData = %s, jsonDocumentWrapper = %s, auth = %s )", fileInputStream,fileMetaData,jsonObject, auth));		
		
		String fileName = fileMetaData.getFileName();
		
		jsonObject = createDocumentUtil(request, fileInputStream, fileName, jsonObject);
		
		logger.info("Exit from: "+ classMethod );
		return Response.ok(jsonObject).build();
	}
	
	

	
	private String insertSigners(String prepareKey, RestDocument document) 
	{
		String status = "";
		String signersEmail = document.getSignerEmail();
		String signersName  = document.getSignerName();
		
		List<String> signersEmailList = Arrays.asList(signersEmail.split(","));
		List<String> signersNameList = Arrays.asList(signersName.split(","));
		signersEmailList.removeAll(Collections.singleton(null));
		signersNameList.removeAll(Collections.singleton(null));
		
		Map<String, Object> signersMap = new HashMap<String, Object>();
		//Map<String, Object> signersMap = IntStream.range(0, signersNameList.size()).boxed().collect(Collectors.toMap(signersNameList::get, signersEmailList::get));
		for (int i = 0; i < signersEmailList.size(); i++) {
			signersMap.put(signersNameList.get(i), signersEmailList.get(i));
			}
		
		status = jerseyService.insertSigners(prepareKey,signersMap,document);
		return status;
	}

	
	public String createDocumentUtil(HttpServletRequest request,InputStream fileInputStream,String fileName,String jsonObject)
	{
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		int userId = 0;
		if (ipAddress == null) {
			   ipAddress = request.getRemoteAddr();
		}
		Authentication auth1 = SecurityContextHolder.getContext().getAuthentication();
		if (auth1 != null) {
			Registration user = (Registration) auth1.getPrincipal();
			userId= user.getId();
				
		}
		
		
		RestDocument document = null;
		String envelopeId = new GlobalFunctions().uniqueToken();
		String msg = null;
		try {
			document = mapper.readValue(jsonObject, RestDocument.class);
			if(document.getDocumentName()==null){
				document.setDocumentName(fileName);
				
			}else{
				fileName = document.getDocumentName();
			}
			document.setClientIPAddress(ipAddress);
			msg= uploadUtil(envelopeId,fileInputStream,fileName,document);
			if(msg == "success"){
				document.setEnvelopeId(envelopeId);
				document.setStatus(msg);
			}
		}catch (IOException e1) {
			e1.printStackTrace();
		}
		
		
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String jsonDocument = jsonObject;
		document.setStatus(msg);
		
		try {
			jsonDocument = ow.writeValueAsString(document);
		} catch (IOException e) {
			
				Audit audit=new Audit();
				audit.setUserId(userId);
				audit.setIpAddress(ipAddress);
				audit.setWebRequest(jsonObject);
				audit.setWebResponse(jsonDocument);
				audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
				audit.setResponseStatus(e.getMessage());
				audit.setCreatedOn(DateManipulation.currentDate());
				jerseyService.saveAudit(audit);
		
			
			logger.error("Error while write value as stirng by objectWriter: "+e);
		}
		
		//Audit 
			Audit audit=new Audit();
			audit.setUserId(userId);
			audit.setIpAddress(ipAddress);
			audit.setWebRequest(jsonObject);
			audit.setWebResponse(jsonDocument);
			audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
			audit.setResponseStatus(msg);
			audit.setCreatedOn(DateManipulation.currentDate());
			jerseyService.saveAudit(audit);
		
		
		logger.info("message: "+msg);
		
		return jsonDocument;
	}

	
	@POST
	@Path("/updatedocument")
	public Response updatedocument(@Context HttpServletRequest request,String jsonObject)
	{
		String classMethod = className+ ":  updatedocument" ;
		logger.info(String.format("Enter into "+classMethod+"(jsonObject = %s)", jsonObject));		
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		int userId = 0;
		if (ipAddress == null) {
			   ipAddress = request.getRemoteAddr();
		}
		Authentication auth1 = SecurityContextHolder.getContext().getAuthentication();
		if (auth1 != null) {
			Registration user = (Registration) auth1.getPrincipal();
			userId= user.getId();
		}
		
		RestDocument document = null;
		
		String msg = "success";
		try {
			document = mapper.readValue(jsonObject, RestDocument.class);
			
			if(document != null && document.getDocumentFields() != null)
			{
				String flag = fileUtils.validateDocument(document);
				if(flag.equals("success"))
				{
					String envelopeId = document.getEnvelopeId();
					if(envelopeId !=null && envelopeId != "")
					{
						int docId = jerseyService.isValidEnvelopeId(envelopeId,document.getOriginatorEmail());
						if(docId !=0)
						{
							String token = new GlobalFunctions().uniqueToken();
							document.setId(docId);
							int signerId = jerseyService.modifyDocument(document,token);
							if(signerId != 0)
							{
								String validation = fieldsValidation(document);
								if( validation == "success")
								{
									try {
										Download download = new Download();
										download.setEnvelopeId(envelopeId);
										download.setFileName(document.getDocumentName());
										 
										ApplicationDocument doc = jerseyService.getDocument(download);
										
										//ApplicationDocument doc = jerseyService.getDocument(envelopeId);
										if(doc.getOriginalId() !=null){
											File file=null;
											//File f = ApplicationUtils.stream2file(doc.getOriginal());
											ClientEFA c=new ClientEFA();
											String fileName=c.efaLookUp(c, "DocumentObject1", doc.getEnvelopeId(), doc.getOriginalId());
											file=new File(fileName); 
											
											File outputFile = new FileUtils().tempFile();
											String eFileName = fileUtils.writeEnvelopeId1(file,outputFile, envelopeId);
											file=new File(eFileName);
											String eRefDocId=randomString(10);
											c.efaStore(c, "DocumentObject1", document.getEnvelopeId(), eRefDocId, eFileName);
											int updateElectronicId=jerseyService.updateRefDocId(doc.getId(), eRefDocId, "electronic");
											//int updateStatus = jerseyService.modifyDocumentBlob(electronic, envelopeId, "electronic");
											if(updateElectronicId!=1){
												msg = "Error while updating blob field in document table.";
											}else{
												//Registration user = jerseyService.getUser(document.getOriginatorEmail());
												
												String signerUrl=jerseyService.getSignUrl(signerId);
												
												//String userUrl = "&projectname="+user.getProject()+"&theme="+user.getTheme().substring(1)+"&linktodrysign="+user.getLinktodrysign()+"&deviceversion="+user.getDeviceVersion();
												//String returnUrl = document.getReturnUrl() == null ? "": document.getReturnUrl();
												String url = SERVER_URL+"signDocument?key="+signerUrl;
												document.setUrl(url);
											}
											file.delete();
											outputFile.deleteOnExit();
											
										}else{
											msg = "File Blob is null. ";
										}
										
										
									} catch (Exception e) {
										msg = e.toString();
									}
									
								}else{
									msg = validation;
								}
								
								
								
							}else{
								msg = "Error: Document cant be empty.";
							}
						}else{
							msg = "EnvelopeId cannot be empty";
						}
						
					}else{
						msg = "EnvelopeId cannot be empty";
					}
					
				}else{
					msg = flag;
				}
			}
			
		}catch (IOException e1) {
			msg = e1.getMessage();
			e1.printStackTrace();
			Audit audit=new Audit();
			audit.setUserId(userId);
			audit.setIpAddress(ipAddress);
			audit.setWebRequest(jsonObject);
			audit.setWebResponse(e1.getMessage());
			audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
			audit.setResponseStatus(msg);
			audit.setCreatedOn(DateManipulation.currentDate());
			jerseyService.saveAudit(audit);
		}
		
		
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String jsonClientUser = jsonObject;
		document.setStatus(msg);
		try {
			jsonClientUser = ow.writeValueAsString(document);
		} catch (IOException e) {
			logger.error("Error while write value as stirng by objectWriter: "+e);
		}
		

		//Audit 
		Audit audit=new Audit();
		audit.setUserId(userId);
		audit.setIpAddress(ipAddress);
		audit.setWebRequest(jsonObject);
		audit.setWebResponse(jsonClientUser);
		audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
		audit.setResponseStatus(msg);
		audit.setCreatedOn(DateManipulation.currentDate());
		jerseyService.saveAudit(audit);
		logger.info("message: "+msg);
		
		logger.info("Exit from "+classMethod);
		return Response.ok(jsonClientUser).build();
	}

	
	private String fieldsValidation(RestDocument document) 
	{
		String message = "";
		for(RestDocumentField documentSignField: document.getDocumentFields())
		{	
			String fieldType = documentSignField.getFieldType();
			if( fieldType.equals("text") || fieldType.equals("image"))
			{
				String fieldName = documentSignField.getFieldName();
				if(fieldName.equals("name") || fieldName.equals("date") || fieldName.equals("sign"))
				{
					if(documentSignField.getPageNumber() >0)
					{
						
						if(documentSignField.getxPosition() >0 && documentSignField.getxPosition() <= 814)
						{}else{
							message = "Field X position must be between 1 to 814.";
							break;
						}

						/*if(documentSignField.getyPosition()>0 && documentSignField.getyPosition() <=1154)
						{}else{
							message = "Field Y position must be between 1 to 1154.";
							break;
						}*/

						if(documentSignField.getFieldHeight() > 9 && documentSignField.getFieldHeight() <= 100 )
						{}else{
							message = "Field Height must be between 10 to 100.";
							break;
						}

						if(documentSignField.getFieldWidth() >= 50 && documentSignField.getFieldWidth() <= 1000)
						{
							message = "success";
						}else{
							message = "Field Width must be between 50 to 1000.";
							break;
						}
					
					
					
					}else{
						message = "Field Page number must be greater than 1.";
						break;
					}
				}else{
					message = "Field Name must be name or date or sign";
					break;
				}
			}else{
				message = "Field Type must be text or image.";
				break;
			}
		}
		
		return message;
	}




	
	@POST
	@Path("/getsigners")
	public String getsigners(@Context HttpServletRequest request,String envelopeId) throws IOException
	{
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		
		DocumentSignerWrapper dsw = new DocumentSignerWrapper();
		List<DocumentSigner> signers = new ArrayList<DocumentSigner>();
		
		String availableSigners = jerseyService.availableSigners(envelopeId);
		if(availableSigners == ""){
			String url = SERVER_URL+"signDocument?key=";
			signers = jerseyService.getSigners(envelopeId,url);
			for(DocumentSigner signer : signers){
				
			}
			dsw.setDocumentSigner(signers);
		}
		dsw.setMessage(availableSigners);
		String res = ow.writeValueAsString(dsw);
		
		return res;
	}


	@POST
	@Path("/download")
	public String download(@Context HttpServletRequest request,String jsonDownload)
	{
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		Map<String,Object> map = downloadUtil(request, jsonDownload);
		Download download = (Download)map.get("download");
		File file = (File) map.get("file");
		
		DownloadDocumentWrapper ddw = new DownloadDocumentWrapper();
		String res = null;

        String encodedBase64 = null;
        if(file !=null){
        try {
        
        	InputStream in = new FileInputStream(file);
            byte[] bytes = new byte[(int)file.length()];
            in.read(bytes);
            encodedBase64 = new String(Base64.encodeBase64(bytes));
            ddw.setBase64String(encodedBase64);
            in.close();
            ddw.setMessage("success");
           
        } catch(Exception e){
        	ddw.setMessage(download.getStatus() + e);
        }
        }else{
        	ddw.setMessage(download.getStatus());
        }
        try {
			res = ow.writeValueAsString(ddw);
		} catch (IOException e) {
			logger.error("Error while converting to json+ " +ddw);
			logger.error(e);
		}
		
        
		return res;
	}
	
	
	@POST
	@Path("/downloadDocument")
	public Response downloadDocument(@Context HttpServletRequest request,String jsonDownload) throws IOException
	{
		Map<String,Object> map = downloadUtil(request, jsonDownload);
		File file = (File) map.get("file");
		Download download = (Download) map.get("download");
		InputStream in = null;
		if(file!=null){
			in = new FileInputStream(file);
		}
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		try {
			jsonDownload = ow.writeValueAsString(download);
		} catch (IOException ex) {
			logger.error("Error while write value as stirng by objectWriter: "+ex);
			download.setStatus("Error while write value as stirng by objectWriter: "+ex);
		}
		
		return Response.ok(in).header("download", jsonDownload).build();
	}
	
	private Map<String,Object> downloadUtil(HttpServletRequest request, String jsonDownload)
	{
		InputStream in = null;
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		int userId = 0;
		if (ipAddress == null) {
			   ipAddress = request.getRemoteAddr();
		}
		Authentication auth1 = SecurityContextHolder.getContext().getAuthentication();
		if (auth1 != null) {
			Registration user = (Registration) auth1.getPrincipal();
			userId= user.getId();
		}
		
		
		ApplicationDocument document = new ApplicationDocument();
		
		File file=null;
		Download download = null;
		try {
			download = mapper.readValue(jsonDownload, Download.class);
			if(download.getEnvelopeId() ==null){
				download.setStatus("Envelope id cannot be null.");
			}else if(download.getFileName() ==null){
				download.setStatus("File name id cannot be null.");
			}else{
				try{
				document = jerseyService.getDocument(download);
				if(document !=null){
				//File file = ApplicationUtils.stream2file(document.getDigital());
				
				ClientEFA c=new ClientEFA();
				String fileName=c.efaLookUp(c, "DocumentObject1", document.getEnvelopeId(), document.getDigitalld());
				file=new File(fileName); 
				//is = new FileInputStream(file);
				download.setStatus("success");
				download.setFileName(document.getFileName());
				download.setEnvelopeId(document.getEnvelopeId());
				//is.close();
				//Audit 
				Audit audit=new Audit();
				audit.setUserId(userId);
				audit.setIpAddress(ipAddress);
				audit.setWebRequest(download.getEnvelopeId());
				audit.setWebResponse("true");
				audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
				audit.setResponseStatus("success");
				audit.setCreatedOn(DateManipulation.currentDate());
				jerseyService.saveAudit(audit);
				}else{
					download.setStatus("File "+download.getFileName()+ " for the given envelopeId "+download.getEnvelopeId()+" does not exist in DrySign. ");
				}
				}catch(Exception e){
					download.setStatus("File "+download.getFileName()+ " for the given envelopeId "+download.getEnvelopeId()+" does not exist in DrySign. ");
				}
			
			}
			
			
			ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
			try {
				jsonDownload = ow.writeValueAsString(download);
			} catch (IOException e) {
				logger.error("Error while write value as stirng by objectWriter: "+e);
				download.setStatus("Error while write value as stirng by objectWriter: "+e);
			}
			
			
			
		} catch (Exception e) {
			logger.error("Error while downloadDocument By web service api: for documentid: "+download.getEnvelopeId()+" Error is : "+e);
			download.setStatus("Error while downloadDocument By web service api: for documentid: "+download.getEnvelopeId()+" Error is : "+e);
			ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
			try {
				jsonDownload = ow.writeValueAsString(download);
			} catch (IOException ex) {
				logger.error("Error while write value as stirng by objectWriter: "+ex);
				download.setStatus("Error while write value as stirng by objectWriter: "+ex);
			}
			
			//Audit 
			/*Audit audit=new Audit();
			audit.setUserId(userId);
			audit.setIpAddress(ipAddress);
			audit.setWebRequest(download.getEnvelopeId());
			audit.setWebResponse("false");
			audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
			audit.setResponseStatus(e.getMessage());
			audit.setCreatedOn(DateManipulation.currentDate());
			jerseyService.saveAudit(audit);*/
		}finally {
			//is.close();
			//file.delete();
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("file", file);
		map.put("download", download);
		return map;

	}
	

	
	public Registration getUser(String email){
		Registration user = null;
		try {
			user = jerseyService.getUser(email);
		} catch (DaoException e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public String uploadUtil(String envelopeId, InputStream fileInputStream, String fileName, RestDocument document)
	{
		
		String msg ="";
		//String fileName = fileMetaData.getFileName();
		String signType = "R";//R=>REST
		int status = 0;
		boolean upgrade = false;
		Registration user = null;
		
		Authentication auth1 = SecurityContextHolder.getContext().getAuthentication();
		if (auth1 != null) {
			user = (Registration) auth1.getPrincipal();			
		}
		
			if(document == null){
				msg = "Document request cannnot be null.";
			}else if(user ==null){
				msg = "User is not valid.";
			}
			else
			{
				String email = user.getEmail();
				String clientIPAddress = document.getClientIPAddress();
				boolean flag = false;
				if(email !=null){
					flag = ApplicationUtils.validate(email);
				}
				
				if(flag)
				{
					// Start pdf uploading
					if(fileUtils.checkValidPdf(fileName))
					{
						File f=null;
						//InputStream inputStream = fileUtils.WriteFile(fileInputStream,fileName);
						String fileName1 = fileUtils.WriteFile1(fileInputStream,fileName);
						f=new File(fileName1);
						if(fileName1 !=null)
						{
							
							//Registration user = getUser(email);
							/*if(user != null)
							{*/
								int uploadFlag;
								try {
									
									upgrade = upgrade(user.getId());
									if(!upgrade)
									{
									uploadFlag = jerseyService.createDocument(user.getId(),envelopeId,fileName,status,signType,document.getSubject(),document.getMessage(),clientIPAddress,document.getReturnUrl());
									
									String oRefDocId=randomString(10);
									ClientEFA c=new ClientEFA();
									fileName1=c.efaStore(c, "DocumentObject1", envelopeId, oRefDocId, fileName1);
									
									int uploadOrignalId=jerseyService.updateRefDocId(uploadFlag, oRefDocId, "original");
									 
									if(uploadFlag > 0 && uploadOrignalId != 0)
									{
										msg = "success";
									}else{
										msg = "problem while inserting to db.";
									}
									}else{
										msg = "Error, Kindly subscribe drysign subscription plan.";
								  }
								} catch (DaoException e) {
									logger.error("problem while inserting to db: "+e);
								}
								
							/*}else{
								msg = "Originator email not exist.";
							}*/
							f.delete();
						}else{ msg = "Error while writing pdf to physical directory. "; }
					}else{ msg = "Only pdf files accepted."; }
					// End pdf uploading
				}else{ msg = "Originator email not valid."; }
			}
	
		return msg;
	}
	
	 public static String randomString( int len ){
		   StringBuilder sb = new StringBuilder( len );
		   for( int i = 0; i < len; i++ ) 
		      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
		   return sb.toString();
		} 
  
	 
	/* matadeen sikarwar
		 * /* End rest service for java users
	 */

	 
	 
	 
	@POST
	@Path("/getDocumentHistory")
	public Response getDocumentHistory(@Context HttpServletRequest request,String jsonObj)
	{
		String classMethod = className+ ":  getDocumentHistory" ;
		logger.info(String.format("Enter into "+classMethod+"(jsonObj = %s)", jsonObj));	
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		int userId = 0;
		if (ipAddress == null) {
			   ipAddress = request.getRemoteAddr();
		}
		Authentication auth1 = SecurityContextHolder.getContext().getAuthentication();
		if (auth1 != null) {
			Registration user = (Registration) auth1.getPrincipal();
			userId= user.getId();
		}
		
		
		RestDocument document = null;
		
		String msg = "success";
		try {
			document = mapper.readValue(jsonObj, RestDocument.class);
			if(document != null)
			{
				if(document.getEnvelopeId() == null || document.getEnvelopeId() =="")
				{
					msg = "Please enter envelope id.";
					
				}else
				{
					if(document.getOriginatorEmail() == null || document.getOriginatorEmail() == "")
					{
						msg = "Please enter email of originator.";
					}else
					{
						document = jerseyService.getDocumentHistory(document);
						msg = document.getStatus();
					}
				}
				
			}else{
				msg = "Please enter email and envelope id.";
			}
			
		}catch (IOException e1) {
			msg = e1.getMessage();
			e1.printStackTrace();
			
			Audit audit=new Audit();
			audit.setUserId(userId);
			audit.setIpAddress(ipAddress);
			audit.setWebRequest(jsonObj);
			audit.setWebResponse(e1.getMessage());
			audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
			audit.setResponseStatus(msg);
			audit.setCreatedOn(DateManipulation.currentDate());
			jerseyService.saveAudit(audit);
		}
		
		
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String jsonClientUser = jsonObj;
		document.setStatus(msg);
		
		try {
			jsonClientUser = ow.writeValueAsString(document);
		} catch (IOException e) {
			logger.error("Error while write value as string by objectWriter: "+e);
		}
		

		//Audit 
		Audit audit=new Audit();
		audit.setUserId(userId);
		audit.setIpAddress(ipAddress);
		audit.setWebRequest(jsonObj);
		audit.setWebResponse(jsonClientUser);
		audit.setMethodName(Thread.currentThread().getStackTrace()[1].getMethodName());
		audit.setResponseStatus(msg);
		audit.setCreatedOn(DateManipulation.currentDate());
		jerseyService.saveAudit(audit);
		
		logger.info("Exit from "+classMethod);
		return Response.ok(jsonClientUser).build();
	}
	
	public boolean upgrade(int userId)
	{
		String expires = "";
		float days = 0;
		float noofdays=0;

		boolean upgrade = false;
		SB_Purchase activePurchase = null;
		
		activePurchase = jerseyService.getActiveSubscription(userId);
		if(activePurchase != null){

			days = daysCalculation(activePurchase.getSubscription().getSubscriptionEndTime());
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
	
	public float daysCalculation(Timestamp endSubscriptionTime)
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
	}	
	
	
	@POST
	@Path("/adduserservice")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces({ MediaType.APPLICATION_JSON })
	public Response addUserService(String jsonClientUser)
	{	
		logger.info(String.format("addUserService(jsonClientUser = %s )", jsonClientUser));
		String message = null;
		
		ClientUser clientUser = null;
		//read data from json
		try {
			clientUser = mapper.readValue(jsonClientUser,ClientUser.class);
			//validation
			
			if(clientUser.getEmail() == null && clientUser.getEmail().isEmpty()){
				message = "User email can't be null.";
			}else if(clientUser.getPassword() == null && clientUser.getPassword().isEmpty()){
				message = "User password can't be null.";
			}else if(clientUser.getClient().getClientId() == 0){
				message = "Please specify client id.";
			}else{
				
				//add user
				try {
					message = jerseyService.addUserJersey(clientUser);
				} 
				catch (DaoException e) 
				{
					logger.error("Error while addUser: "+e);
					message = "Error while addUser: "+e.getMessage();
				}
				
			}
						
		}
		catch(Exception e)
		{
			logger.error("Error while parsing readValue from jsonDocumentWrapper: "+e);
			message = "Error while parsing readValue from jsonDocumentWrapper: "+e.getMessage();
		}
		
		
		return Response.ok(message).build();
	}

	@POST
	@Path("/getAllClientUser")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces({ MediaType.APPLICATION_JSON })
	public Response getAllClientUser(String jsonClientAuth)
	{
		logger.info(String.format("getAllClientUser( jsonClientAuth = %s)", jsonClientAuth));
		ClientAuth clientUserAuth = null;
		String message = null;
		
		ClientUser clientUser = new ClientUser();

		/*clientUser.setEmail("user@gmail.com");
		clientUser.setPassword("user");
		clientUser.setStatus(1);
		clientUser.setDateTime(new Date(0));

		ClientUser clientUser1 = new ClientUser();
		clientUser1.setEmail("user@gmail.com");
		clientUser1.setPassword("user");
		clientUser1.setStatus(1);
		clientUser1.setDateTime(new Date(0));*/

		List<ClientUser> clientUsers = new ArrayList<ClientUser>();
		/*clientUsers.add(clientUser);
		clientUsers.add(clientUser1);*/
		
		try {
			clientUserAuth = mapper.readValue(jsonClientAuth,ClientAuth.class);
			
			
			
			try {
				clientUsers = jerseyService.getAllClientUserService(clientUserAuth);

				ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
				
				try {
					message = ow.writeValueAsString(clientUsers);
				}catch (Exception e1) {
					logger.error("Error while writing to json: "+e1);
					message = "Error while writing to json: "+e1.getMessage();
				}
				
			} catch (DaoException e) {
				logger.error(e);
				message = e.getMessage();
			}
			
			
		} catch (Exception e) {
			logger.error("Error while parsing readValue from jsonDocumentWrapper: "+e);
			message = "Error while parsing readValue from jsonDocumentWrapper: "+e.getMessage();
		}

		
		logger.info(message);
		return Response.ok(message).build();
	}
	

	@POST
	@Path("/upload")
	@Consumes({ MediaType.MULTIPART_FORM_DATA })
	public Response uploadDocument(@FormDataParam("file") InputStream fileInputStream, @FormDataParam("file") FormDataContentDisposition fileMetaData, @FormDataParam("jsonDocumentWrapper") String jsonObject, @HeaderParam("Authorization") String auth)
	{
		String classMethod = className+ ":  updatedocument" ;
		logger.info(String.format("Enter into "+classMethod+"(jsonObject = %s)", jsonObject));		
		
		RestDocument document = null;
		String fileName = fileMetaData.getFileName();
		String msg = "success";
		try {
			document = mapper.readValue(jsonObject, RestDocument.class);
			if(document != null && document.getDocumentFields() != null)
			{
				String flag = fileUtils.validateDocument(document);
				if(flag.equals("success"))
				{
					String envelopeId = new GlobalFunctions().uniqueToken();
					String uploadStatus= uploadUtil(envelopeId,fileInputStream,fileName,document);
					if(uploadStatus == "success"){
						document.setEnvelopeId(envelopeId);
						String token = new GlobalFunctions().uniqueToken();
						int message = jerseyService.modifyDocument(document,token);
						if(message != 0)
						{

							String returnUrl = document.getReturnUrl() == null ? "": document.getReturnUrl();
							String url = SERVER_URL+"applicationsigndocument?token="+token+"&envelopeid="+envelopeId+"&email="+document.getSignerEmail()+"&redirecturl="+returnUrl;
							document.setUrl(url);
							
						}else{
							msg = "Error: Document cant be empty.";
						}
					}else{
						msg = uploadStatus;
					}
					
					
				}else{
					msg = flag;
				}
			}
			
		}catch (IOException e1) {
			msg = e1.getMessage();
			e1.printStackTrace();
		}
		
		
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String jsonClientUser = jsonObject;
		document.setStatus(msg);
		try {
			jsonClientUser = ow.writeValueAsString(document);
		} catch (IOException e) {
			logger.error("Error while write value as stirng by objectWriter: "+e);
		}
		

		
		logger.info("message: "+msg);
		
		logger.info("Exit from "+classMethod);
		return Response.ok(jsonClientUser).build();
	}
	
	
	/*Start background document sign*/
	
	
	@POST
	@Path("/createsignature")
    public String createSignature(@Context HttpServletRequest request,String jsonSignature)
	{
		CreateSignatureResponse returnResponse = new CreateSignatureResponse();
		String response = "";
		String msg = "";
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		try {
			CreateSignatureRequest input = mapper.readValue(jsonSignature, CreateSignatureRequest.class);
			if(input.getFirstname()==null || input.getFirstname().isEmpty()){
				msg="First Name cannot be empty.";
			}else if(input.getLastname()==null || input.getLastname().isEmpty()){
				msg="Last Name cannot be empty.";
			}else if(input.getEmail()==null || input.getEmail().isEmpty()){
				msg="Email cannot be empty.";
			}else{
				String token = new GlobalFunctions().uniqueToken();
				input.setToken(token);
				
				input = (CreateSignatureRequest) jerseyService.createSignature(input);
				if(input.getMessage()!=null && input.getMessage()=="success"){
					String url = SERVER_URL+"createsignature?token="+input.getToken();
					returnResponse.setCreateSignatureUrl(url);
					returnResponse.setEmail(input.getEmail());
					msg=input.getMessage();
				}else{
					msg=input.getMessage();
				}
				
			}
			
		} catch (IOException e1) {
			msg = "Error while Marshalling / Unmarshalling in create signature: "+e1;
			logger.error(msg);
		}
		returnResponse.setMessage(msg);
		try {response = ow.writeValueAsString(returnResponse);} catch (IOException e) {logger.error("Error while write : "+e);}
		return response;
	}
	
	
	@POST
	@Path("/backgroundsigndocument")
    public String backgroundSignDocument(@Context HttpServletRequest request,String jsondocument)
	{

		BackgroundSignDocument document=null;
		BackgroundSignDocumentResponse response = new BackgroundSignDocumentResponse();
		String responseReturn=null;
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		try {
			document = mapper.readValue(jsondocument, BackgroundSignDocument.class);
			
			
			if(document !=null)
			{
				String status = FileUtils.validateBackgroundDoc(document);
				if(status !=null && status=="1")
				{
					String fileName = document.getDocumentName();
					InputStream fileInputStream = FileUtils.StrToStream(document.getFileBase64String(),document.getDocumentName());
				
					/*start creating document*/
					
					String ipAddress = request.getHeader("X-FORWARDED-FOR");
					int userId = 0;
					if (ipAddress == null) {
						   ipAddress = request.getRemoteAddr();
					}
					
					String envelopeId = new GlobalFunctions().uniqueToken();
					
					try {
						RestDocument restDoc = new RestDocument();
						restDoc.setClientIPAddress(ipAddress);
						restDoc.setSubject(document.getSubject());
						restDoc.setMessage(document.getMessage());
						status= uploadUtil(envelopeId,fileInputStream,fileName,restDoc);
						if(status == "success")
						{
						Registration user = null;
						Authentication auth1 = SecurityContextHolder.getContext().getAuthentication();
						user = (Registration) auth1.getPrincipal();			

							document = jerseyService.backgroundSignDocumentSave(document,envelopeId,user.getId());
							if(document !=null && "success".equals(document.getMessage()))
							{
								//start electronic digital sign
								
								status = electronicDigitalSign(document, envelopeId,userId);
								if("success".equalsIgnoreCase(status)){
									String readOnlyUrl = SERVER_URL+"viewReadOnlyDocument?envelopeid="+envelopeId;
									response.setViewDocumentUrl(readOnlyUrl);
									response.setDocumentName(fileName);
									response.setEnvelopeId(envelopeId);
									response.setMessage(status);
								}
								//end electronic sign
								
								
							}else{status = document.getMessage();}
						}	
					}catch (Exception e1) {
						String eMSG = "Error while upload document util: "+e1;
						logger.error(eMSG);
						status = eMSG;
					}
					/*end creating document*/
				
				}
				response.setMessage(status);
			}else{
				response.setMessage("Document can not be null.");
				logger.error("Document can not be null.");
			}
			
		} catch (IOException e1) {
			response.setMessage("Error while operation on backgroundsigndocument: "+e1);
			logger.error("Error while operation on backgroundsigndocument: "+e1);
		}
		try {responseReturn = ow.writeValueAsString(response);} catch (IOException e) {logger.error("Error while write : "+e);}

		
	return responseReturn;
    }
	


	
	public String electronicDigitalSign(BackgroundSignDocument document,String envelopeId,int userId)
	{
		String status = null;
		File outputFile = null;
		File file = null;
		File digitaltemp = null;
		try{
			ApplicationDocument savedDocument = jerseyService.getDocument(envelopeId);
			
			ClientEFA c = new ClientEFA();
			String fileName = c.efaLookUp(c, "DocumentObject1", envelopeId, savedDocument.getOriginalId());
			file = new File(fileName);
			FileUtils fileUtils=new FileUtils();
			outputFile = fileUtils.tempFile();
			String writefileName = null;
			try{
				writefileName = fileUtils.writeDocumentFields(document.getDocumentFields(), file,outputFile);
				String eRefDocId = CommonUtils.randomString(10);
				c.efaStore(c, "DocumentObject1", envelopeId, eRefDocId, writefileName);
				jerseyService.updateRefDocId(savedDocument.getId(), eRefDocId, "electronic");
				
				String digiRefDocId = CommonUtils.randomString(10);
				digitaltemp = new File(TEMP_DIGITAL_URL + digiRefDocId+".pdf");
				try{
					fileUtils.createDigitalSignature(outputFile, digitaltemp, envelopeId);
					String dRefDocId = CommonUtils.randomString(10);
					c.efaStore(c, "DocumentObject1", envelopeId, dRefDocId, digitaltemp.getAbsolutePath());
					jerseyService.updateRefDocId(savedDocument.getId(), dRefDocId, "digital");
					status = jerseyService.updateDocument(1,103,CommonUtils.currentDate(),savedDocument.getId());
				}catch(Exception e1){
					status = "Error while digital  sign: "+e1;
					logger.error(status);
				}
			}catch(Exception e2){
				status = "Error while electronic  sign: "+e2;
				logger.error(status);
			}
			
		}catch(Exception e3){
			status = "Error while geting document sign: "+e3;
			logger.error(status);
		}finally{
			if(outputFile!=null){outputFile.deleteOnExit();}
			if(file!=null){file.deleteOnExit();}
			if(digitaltemp!=null){digitaltemp.deleteOnExit();}
		}
		return status;
	}
	
	
	/*End background document sign*/
}
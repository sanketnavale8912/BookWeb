package com.drysign.externalapp.resources.googledrive;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.drysign.efa.ClientEFA;
import com.drysign.model.GoogleDriveResource;
import com.drysign.model.Registration;
import com.drysign.model.SB_Purchase;
import com.drysign.service.ApplicatonService;
import com.drysign.service.SubscriptionService;
import com.drysign.utility.CommonUtils;
import com.drysign.utility.DateManipulation;
import com.drysign.utility.ExternalAppResourceUtil;
import com.drysign.utility.GlobalFunctions;
import com.drysign.utility.UtilityException;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.InputStreamContent;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;
import com.google.gson.Gson;
/**
 * 
 * @author priyaranjan.kumar
 *
 */
@Controller
@RequestMapping("/cloud")
public class GoogleDriveResources {
     
	 private static GoogleAuthorizationCodeFlow flow = null;
	  private Credential credential = null;
	  String efaStatus= null;

		String DRIVE_PATH;
		
		@Autowired
		private SubscriptionService subscriptionService;
	  
		@Autowired
		private ApplicatonService applicatonService;
		
		GoogleDriveResources(){
			try {
				DRIVE_PATH = new GlobalFunctions().getTemporaryFilePath();
			} catch (UtilityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
//	@Value("${directory.Google.Drive.download}")
//	private  String googleDriveDownloadLocation;
	/*@RequestMapping(value="/savePickFile",method=RequestMethod.POST,produces = {"application/json"})
	public ResponseEntity<GoogleDriveResource> savePickFile(@RequestBody GoogleDriveResource googleDriveResource){
		
		ResponseEntity< GoogleDriveResource>  response = null;
		 String s1=new String(googleDriveResource.getFileContent());
		try {
			
		Path filePath = FileSystems.getDefault().getPath(googleDriveDownloadLocation, googleDriveResource.getFileName());
		OutputStream outputStream = new BufferedOutputStream(
				Files.newOutputStream(filePath));
					outputStream.write(googleDriveResource.getFileContent().getBytes(), 0, googleDriveResource.getFileContent().length());
			new String(googleDriveResource.getFileContent());
			response = new  ResponseEntity<GoogleDriveResource>(googleDriveResource,HttpStatus.CREATED);
			
		
		
		
		} catch (IOException e) {
			response = new  ResponseEntity<GoogleDriveResource>(new GoogleDriveResource(),HttpStatus.FORBIDDEN);
		}
		
		
		return response ;
		
	}*/
	
	
	@RequestMapping(value = "/downloadFieByFileId", method = RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody void/*ResponseEntity<String>*/ downloadFromDrive(@RequestBody GoogleDriveResource googleDriveResource, HttpServletResponse response, HttpServletRequest request) {
		
		String uploadStatus = null;
		Registration register = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		String signtype = request.getParameter("signtype");
		List<String> docList = new ArrayList<String>();
		if (ipAddress == null) {
			ipAddress = request.getRemoteAddr();
		}
	
		try {
			flow = ExternalAppResourceUtil.getFlow(flow);
		//	List<String> fileDownloaded = null;
			Drive service = new Drive.Builder(
					GoogleDriveConstant.HTTP_TRANSPORT,
					GoogleDriveConstant.JSON_FACTORY, getStoredCredentials(googleDriveResource.getAccessToken()))
					.setApplicationName(
							GoogleDriveConstant.APPLICATION_NAME).build();
			if(!upgrade(register.getId()))
			{
			
			File file = service.files().get(googleDriveResource.getFileId()).execute();
			if(file != null)
			{
		//	fileDownloaded = downloadFile(service, file , googleDriveResource.getFileName());
			List<String> fileDownloaded = new ArrayList<String>();
			
			String envelopeId = "";
			String fileId = file.getId();
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			service.files().get(fileId).executeMediaAndDownloadTo(outputStream);
			
			// FileOutputStream fos = new
			// FileOutputStream(System.getProperty(PlexusGDriveConstant.USER_HOME)+file.getId().concat(file.getName()));
			FileOutputStream fos = new FileOutputStream(new java.io.File(DRIVE_PATH +googleDriveResource.getFileName()));
			outputStream.writeTo(fos);
			fos.close();
			fileDownloaded.add(file.getName());
			
			envelopeId = new GlobalFunctions().uniqueToken(); 

	String refDocId = CommonUtils.randomString(10);

	ClientEFA c = new ClientEFA();
	 efaStatus = c.efaStore(c, "DocumentObject1", envelopeId, refDocId, DRIVE_PATH+googleDriveResource.getFileName());
	System.out.println("Done");
		//	return fileDownloaded;
			
			if (fileDownloaded != null) {
				if (efaStatus == "success") {

					// Step 6 :Store Meta data in SQL Server Status 101(Draft)
					String docId = applicatonService.insertDocument(register.getId(), googleDriveResource.getFileName(),
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
			}
			}else
		{
			uploadStatus = "subscriptionend"; // subscription end
			String json = new Gson().toJson(uploadStatus);
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
			}
			catch (Exception ex) {

		}

		//return response;

	}
	
	private  List<String> downloadFile(Drive service, File file,String fileName)
			throws Exception {
		List<String> fileDownloaded = new ArrayList<String>();
		
		String envelopeId = "";
		String fileId = file.getId();
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		service.files().get(fileId).executeMediaAndDownloadTo(outputStream);
		
		// FileOutputStream fos = new
		// FileOutputStream(System.getProperty(PlexusGDriveConstant.USER_HOME)+file.getId().concat(file.getName()));
		FileOutputStream fos = new FileOutputStream(new java.io.File(
				DRIVE_PATH +fileName));
		outputStream.writeTo(fos);
		fos.close();
		fileDownloaded.add(file.getName());
		
		envelopeId = new GlobalFunctions().uniqueToken(); 

String refDocId = CommonUtils.randomString(10);

ClientEFA c = new ClientEFA();
 efaStatus = c.efaStore(c, "DocumentObject1", envelopeId, refDocId, DRIVE_PATH+fileName);
System.out.println("Done");
		return fileDownloaded;
	}
	

	public Credential getStoredCredentials(String accessToken) {
		
		Credential credential = new GoogleCredential.Builder()
				.setJsonFactory(GoogleDriveConstant.JSON_FACTORY)
				.setTransport(GoogleDriveConstant.HTTP_TRANSPORT)
				.setClientSecrets(GoogleDriveConstant.APP_CLIENT_ID,
						GoogleDriveConstant.APP_CLIENT_SECRET).build();
		credential.setAccessToken(accessToken);
	
		return credential;
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
	

	  
	  private static String getUserFolderId(List<File> files, String userFolderId,String driveFolder) {
			for (File file : files) {
				if (file.getName().equalsIgnoreCase(driveFolder)) {
					userFolderId = file.getId();
				}
			}
			return userFolderId;
		}
	  private static void setUploadFolder(Drive service,String uploadDir ,String uploadSourceDir) throws Exception {
			File fileMetadata = new File();
			fileMetadata.setName(uploadDir);
			String folderID =null;
			fileMetadata.setMimeType("application/vnd.google-apps.folder");
			try {
				
				File file = service.files().create(fileMetadata).setFields("id").execute();
				folderID = file.getId();
				System.out.println("Folder ID: " + file.getId());
				
			} catch (Exception e) {
				e.printStackTrace();

			}
			uploadFileInFolder(service,folderID,uploadSourceDir);

		}
		
	 public static List<String> uploadBinaryFileInFolder(Drive service, String folderID,byte[] fileContent ,String fileNmae) throws IOException {
			//String userFolderId = null;
			File fileMetadata = new File();
			List<String> fileUploaded = new ArrayList<String>();
				
			fileMetadata.setName(fileNmae);
			
				fileMetadata.setParents(Collections.singletonList(folderID));
				//java.io.File filePath = new java.io.File(userFile.getAbsolutePath());
				//FileContent mediaContent = new FileContent("", filePath);
				File file = service.files().create(fileMetadata, new InputStreamContent("text/plain", new ByteArrayInputStream(fileContent))).setFields("id, parents").execute();
				System.out.println("File ID: " + file.getId());
				fileUploaded.add(fileNmae);
			
			
			
			return fileUploaded;
		}
		
		
		
		public static List<String> uploadFileInFolder(Drive service, String folderID,String uploadSourceDir) throws IOException {
			//String userFolderId = null;
			File fileMetadata = new File();
			List<String> fileUploaded = new ArrayList<String>();
			ArrayList<java.io.File> uFile=new ArrayList<java.io.File>();
			java.io.File uploadDirectory = new java.io.File(uploadSourceDir);

			java.io.File [] uploadDirectoryContents = uploadDirectory.listFiles();
			
	        for (java.io.File file : uploadDirectoryContents){
	            if (file.isFile()){
	            	uFile.add(file);
	                System.out.println(file.getName()+"\tPATH\t"+file.getAbsolutePath());
	            }
	        }
			
			for(java.io.File userFile:uFile){
			fileMetadata.setName(userFile.getName());
			
				fileMetadata.setParents(Collections.singletonList(folderID));
				java.io.File filePath = new java.io.File(userFile.getAbsolutePath());
				FileContent mediaContent = new FileContent("", filePath);
				File file = service.files().create(fileMetadata, mediaContent).setFields("id, parents").execute();
				System.out.println("File ID: " + file.getId());
				fileUploaded.add(userFile.getName());
			
			
			}
			return fileUploaded;
		}


}

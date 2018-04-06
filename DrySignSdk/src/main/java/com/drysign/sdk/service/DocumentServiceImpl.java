package com.drysign.sdk.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.CopyOption;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.ObjectWriter;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.MultiPart;
import org.glassfish.jersey.media.multipart.MultiPartFeature;
import org.glassfish.jersey.media.multipart.file.FileDataBodyPart;

import com.drysign.sdk.Config;
import com.drysign.sdk.model.Document;
import com.drysign.sdk.model.Oauth2Token;


/**
 * @author Matadeen.Sikarawar
 *
 */
public class DocumentServiceImpl implements DocumentService{

	private static final Logger logger = Logger.getLogger(DocumentServiceImpl.class);
	static ObjectMapper mapper = new ObjectMapper();

	public Document documentService(Document document,Oauth2Token oauth2Token) 
	{
			//get configuration
			Config.init();
			String auth = Config.getBase64EncodedClientCrendetials();

			document.setReturnUrl(Config.getReturnUrl());
			document.setOriginatorEmail(Config.getOriginatorEmail());
			document.setSubject(Config.getSubject());
			document.setMessage(Config.getMessage());
			
			try{
			//convert documentWrapper into json format
			ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
			String jsonClientUser = ow.writeValueAsString(document);
		
			//REST CALL
		 	Client client = ClientBuilder.newBuilder().register(MultiPartFeature.class).build();
		    WebTarget webTarget = client.target(Config.getApiBase()+"rest/api/upload");
		    MultiPart multiPart = new MultiPart();
		    multiPart.setMediaType(MediaType.MULTIPART_FORM_DATA_TYPE);

		    FileDataBodyPart fileDataBodyPart = new FileDataBodyPart("file",new File(document.getFilePath()),MediaType.APPLICATION_OCTET_STREAM_TYPE);
		    multiPart.bodyPart(fileDataBodyPart);
		    multiPart.bodyPart(new FormDataBodyPart("jsonDocumentWrapper", jsonClientUser));

		    Response response = webTarget.request().header("Authorization", "Bearer"+oauth2Token.getAccessToken()).post(Entity.entity(multiPart, multiPart.getMediaType()));
		    document = mapper.readValue(response.readEntity(String.class), Document.class);
		    String message = document.getStatus();
		    
		    document.setStatus("status: "+response.getStatus() + " statusInfo: "+ response.getStatusInfo() + " message: " + message);
		    
		    //System.out.println(response.readEntity(String.class));
		    fileDataBodyPart.cleanup();
		    multiPart.close();
			}catch(Exception e){
				logger.error("Error while document Service: "+e);
			}
		return document;
	}


	public Document createDocument(Document document,Oauth2Token oauth2Token) 
	{
		//get configuration
		Config.init();
		String auth = Config.getBase64EncodedClientCrendetials();

		document.setReturnUrl(Config.getReturnUrl());
		document.setOriginatorEmail(Config.getOriginatorEmail());
		document.setSubject(Config.getSubject());
		document.setMessage(Config.getMessage());
		try{
			//convert documentWrapper into json format
			ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
			String jsonClientUser = ow.writeValueAsString(document);
		
			//REST CALL
		 	Client client = ClientBuilder.newBuilder().register(MultiPartFeature.class).build();
		    WebTarget webTarget = client.target(Config.getApiBase()+"rest/api/createdocument");
		    MultiPart multiPart = new MultiPart();
		    multiPart.setMediaType(MediaType.MULTIPART_FORM_DATA_TYPE);
	
		    FileDataBodyPart fileDataBodyPart = new FileDataBodyPart("file",new File(document.getFilePath()),MediaType.APPLICATION_OCTET_STREAM_TYPE);
		    multiPart.bodyPart(fileDataBodyPart);
		    multiPart.bodyPart(new FormDataBodyPart("jsonDocumentWrapper", jsonClientUser));
	
		    Response response = webTarget.request().header("Authorization", "Bearer"+oauth2Token.getAccessToken()).post(Entity.entity(multiPart, multiPart.getMediaType()));
		    document = mapper.readValue(response.readEntity(String.class), Document.class);
		    String message = document.getStatus();
		    
		    document.setStatus("status: "+response.getStatus() + " statusInfo: "+ response.getStatusInfo() + " message: " + message);
		    
		    //System.out.println(response.readEntity(String.class));
		    fileDataBodyPart.cleanup();
		    multiPart.close();
		}catch(Exception e){
			logger.error("Error while createDocument : "+e);
	    }
	return document;
}

	public Document updateDocument(Document document,Oauth2Token oauth2Token) 
	{
		//get configuration
		Config.init();
		String auth = Config.getBase64EncodedClientCrendetials();

		document.setReturnUrl(Config.getReturnUrl());
		document.setOriginatorEmail(Config.getOriginatorEmail());
		document.setSubject(Config.getSubject());
		document.setMessage(Config.getMessage());
		try{
			//convert documentWrapper into json format
			ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
			String jsonClientUser = ow.writeValueAsString(document);
		
			//REST CALL
			ClientConfig config = new ClientConfig();
			Client client = ClientBuilder.newClient(config);
		    WebTarget webTarget = client.target(Config.getApiBase()+"rest/api/updatedocument");
	
		    Response response = webTarget.request().header("Authorization", "Bearer"+oauth2Token.getAccessToken()).post(Entity.entity(jsonClientUser, MediaType.APPLICATION_JSON));
		    document = mapper.readValue(response.readEntity(String.class), Document.class);
		    String message = document.getStatus();
		    
		    document.setStatus("status: "+response.getStatus() + " statusInfo: "+ response.getStatusInfo() + " message: " + message);

		}catch(Exception e){
			logger.error("Error while updateDocument : "+e);
	    }
	return document;
	}

	public boolean downloadDocument(String documentId,Oauth2Token oauth2Token) 
	{
		boolean flag = false;
		
		//get configuration
		Config.init();
		String auth = Config.getBase64EncodedClientCrendetials();

		try{
			
			//REST CALL
			ClientConfig config = new ClientConfig();
			Client client = ClientBuilder.newClient(config);
			WebTarget target = client.target(Config.getApiBase()+"rest/api/downloadDocument");
	        Response response = target.request().accept(MediaType.APPLICATION_JSON).header("Authorization", "Bearer"+oauth2Token.getAccessToken()).post(Entity.entity(documentId, MediaType.APPLICATION_JSON), Response.class);
	        
	        /*System.out.println("status: "+response.getStatus() + " statusInfo: "+ response.getStatusInfo() + " response: " + response);*/
	        if(response.getStatus() == 200)
	        {
	        	CopyOption[] options = new CopyOption[]{StandardCopyOption.REPLACE_EXISTING }; 
	        	InputStream input = (InputStream)response.getEntity();
	 	        final Path destination = Paths.get(Config.getDocumentDownloadPath()+documentId+".pdf");
	 	        Files.copy(input, destination,options);
	 	        flag = true;
	 	        
	        }else{
	        	flag = false;
	        }
	       
		}catch(Exception e){
			flag = false;
			logger.error("Error while downloadDocument : "+e);
		}
		
		return flag;
	}


	public Object getUsers(String token) 
	{

		
		//get configuration
		Config.init();
		String auth = Config.getBase64EncodedClientCrendetials();

		try{
			
			//REST CALL
			ClientConfig config = new ClientConfig();
			Client client = ClientBuilder.newClient(config);
			WebTarget target = client.target(Config.getApiBase()+"api/users/");
	        Response response = target.request().accept(MediaType.APPLICATION_JSON).header("Authorization", "Bearer " + token).post(Entity.entity("", MediaType.APPLICATION_JSON), Response.class);
	        
	        System.out.println("status: "+response.getStatus() + " statusInfo: "+ response.getStatusInfo() + " response: " + response);
	       
	       
		}catch(Exception e){

			logger.error("Error while downloadDocument : "+e);
		}
		
		return null;
	}
	
	
}

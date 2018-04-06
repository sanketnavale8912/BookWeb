package com.drysign.sdk;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;

import com.drysign.sdk.manager.UserManager;
import com.drysign.sdk.model.Document;
import com.drysign.sdk.model.Oauth2Token;
import com.drysign.sdk.service.DocumentService;
import com.drysign.sdk.service.DocumentServiceImpl;

public class DrySignClient {

	private DocumentService documentService = null;
	public DrySignClient(){
		documentService = new DocumentServiceImpl();
	}
	
	public Document uploadDocument(Document document)
	{
		UserManager userManager=new UserManager();
		Oauth2Token oauth2Token=userManager.getToken();
		
		Document doc = documentService.documentService(document,oauth2Token);
		return doc;
	}

	public boolean downloadDocument(String documentId) {
		
		UserManager userManager=new UserManager();
		Oauth2Token oauth2Token=userManager.getToken();
		return documentService.downloadDocument(documentId,oauth2Token);
	}

	public Document createDocument(Document document) 
	{
		UserManager userManager=new UserManager();
		Oauth2Token oauth2Token=userManager.getToken();
		return documentService.createDocument(document,oauth2Token);
	}

	public Document updateDocument(Document document) 
	{
		UserManager userManager=new UserManager();
		Oauth2Token oauth2Token=userManager.getToken();
		return documentService.updateDocument(document,oauth2Token);
	}

	public Object getUsers() 
	{
		UserManager userManager=new UserManager();
		Oauth2Token oauth2Token=userManager.getToken();
		return documentService.getUsers(oauth2Token.getAccessToken());
		
	}

}

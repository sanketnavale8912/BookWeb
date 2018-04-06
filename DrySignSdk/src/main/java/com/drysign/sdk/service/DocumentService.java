package com.drysign.sdk.service;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;

import com.drysign.sdk.model.Document;
import com.drysign.sdk.model.Oauth2Token;

public interface DocumentService  {

	Document documentService(Document document, Oauth2Token oauth2Token) ;

	boolean downloadDocument(String documentId, Oauth2Token oauth2Token);

	Document createDocument(Document document, Oauth2Token oauth2Token);

	Document updateDocument(Document document, Oauth2Token oauth2Token);

	Object getUsers(String token);

}

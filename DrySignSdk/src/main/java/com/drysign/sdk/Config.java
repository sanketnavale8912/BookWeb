package com.drysign.sdk;

import java.io.UnsupportedEncodingException;
import java.util.ResourceBundle;
import java.util.StringTokenizer;

import org.apache.tomcat.util.codec.binary.Base64;

public class Config {

	private static final ResourceBundle BUNDLE = ResourceBundle.getBundle("drysign");
	private static String apiBase;
	private static String clientId;
	private static String clientSecret;
	private static String documentDownload;
	private static String returnUrl;
	private static String originatorEmail;
	private static String subject;
	private static String message;
	
	public static void init()
	{
		if(apiBase == null || apiBase.length() == 0){
			apiBase = BUNDLE.getString("drysign.api.url");
			clientId = BUNDLE.getString("drysign.api.clientid");
			clientSecret = BUNDLE.getString("drysign.api.clientsecret");
			documentDownload = BUNDLE.getString("drysign.document.download.path");
			returnUrl = BUNDLE.getString("drysign.api.redirect.url");
			originatorEmail = BUNDLE.getString("drysign.sender.email");
			subject = BUNDLE.getString("drysign.mail.subject");
			message = BUNDLE.getString("drysign.mail.message");
		}
	}
	
	public static String getApiBase(){
		return apiBase;
	}
	
	public static String getClientId(){
		return clientId;
	}
	
	public static String getClientSecret(){
		return clientSecret;
	}
	
	public static String getDocumentDownloadPath(){
		return documentDownload;
	}
	
	public static String getReturnUrl(){
		return returnUrl;
	}
	
	public static String getOriginatorEmail(){
		return originatorEmail;
	}
	
	public static String getSubject(){
		return subject;
	}

	public static String getMessage(){
		return message;
	}
	public static String getBase64EncodedClientCrendetials()
	{
		String clientIdAndSecret = getClientId() + ":" + getClientSecret();
		byte[] encodedCrenditals = Base64.encodeBase64(clientIdAndSecret.getBytes());
		return new String(encodedCrenditals);
	}
	
	public static String getBase64DecodedClientCredentials(String auth) throws UnsupportedEncodingException{
		byte[] decodedBytes = Base64.decodeBase64(auth);
		String clientIdAndSecret = new String(decodedBytes,"UTF-8");
		final StringTokenizer tokenizer = new StringTokenizer(clientIdAndSecret,":");
		System.out.println(tokenizer.nextToken());
		System.out.println(tokenizer.nextToken());
		

		return apiBase;
	}
	
	public static void main(String[] args) throws UnsupportedEncodingException {
		
		System.out.println(Config.getBase64EncodedClientCrendetials());
		getBase64DecodedClientCredentials(Config.getBase64EncodedClientCrendetials());
	}
}

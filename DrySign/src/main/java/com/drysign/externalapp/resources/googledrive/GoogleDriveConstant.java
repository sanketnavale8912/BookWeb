package com.drysign.externalapp.resources.googledrive;



import java.util.Arrays;
import java.util.List;

import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
/**
 * 
 * @author priyaranjan.kumar
 *
 */
public interface GoogleDriveConstant {
	
	 String ACCESS_TYPE = "offline";
	 String APPRROVAL_PROMPT = "force";
	 String REDIRECT_URI = "postmessage";
	 String CLIENTSECRET_LOCATION = "/client_secret.json";
	 List<String> SCOPES = Arrays.asList("https://www.googleapis.com/auth/drive","email","profile");
	 JacksonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
	 HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
     String APPLICATION_NAME = "DrySign";
     String FOLDER_AVAILABLITY = "Folder Not Exit with Name";
     String VERIFID = "Verified";
	 String APP_CLIENT_ID = "927346535684-gkrnjl6o6akimdjse81gp3lb1j79n957.apps.googleusercontent.com";
	 String APP_CLIENT_SECRET = "BT7FAgf1A-dhiPZspNexXFjh";
	 String USER_HOME = "user.home";

}

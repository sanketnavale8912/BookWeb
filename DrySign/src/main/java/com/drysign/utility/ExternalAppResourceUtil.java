package com.drysign.utility;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.util.List;

import com.drysign.externalapp.resources.googledrive.GoogleDriveConstant;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
/**
 * 
 * @author Priyaranjan.Kumar
 *
 */
public class ExternalAppResourceUtil {
	
	
	
	public static GoogleAuthorizationCodeFlow getFlow(GoogleAuthorizationCodeFlow flow) throws IOException {
	    if (flow == null) {
	       	InputStream in = ExternalAppResourceUtil.class.getResourceAsStream(GoogleDriveConstant.CLIENTSECRET_LOCATION);
			GoogleClientSecrets clientSecret = GoogleClientSecrets.load( GoogleDriveConstant.JSON_FACTORY,new InputStreamReader(in));
	        flow = new GoogleAuthorizationCodeFlow.Builder(
	        		GoogleDriveConstant.HTTP_TRANSPORT, GoogleDriveConstant.JSON_FACTORY, clientSecret, GoogleDriveConstant.SCOPES)
	               .setAccessType(GoogleDriveConstant.ACCESS_TYPE)
	               .setApprovalPrompt(GoogleDriveConstant.APPRROVAL_PROMPT).build();
	    }
	    return flow;
	  }

	
	public static Credential exchangeCode(String authorizationCode,GoogleAuthorizationCodeFlow flow)
		      throws Exception {
		   
		     
		      GoogleTokenResponse response = flow
		          .newTokenRequest(authorizationCode)
		          .setRedirectUri(GoogleDriveConstant.REDIRECT_URI)
		          .execute();
		      return flow.createAndStoreCredential(response, null);
		    
		  }	
	
	
	
	
	
	public static String getUserFolderId(List<File> files, String userFolderId,String downloadDir) {
		for (File file : files) {
			if (file.getName().equalsIgnoreCase(downloadDir)) {
				userFolderId = file.getId();
			}
		}
		return userFolderId;
	}
	
	
	public  static void downloadFile(Drive service, File file, String DownLoadFilePath) {
		try {
		String fileId = file.getId();
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		service.files().get(fileId).executeMediaAndDownloadTo(outputStream);

			FileOutputStream fos = new FileOutputStream(new java.io.File("D:\\Files\\"+file.getId().concat(file.getName())));
			outputStream.writeTo(fos);
			fos.close();
			//fileDownloaded.add(file.getName());
		} catch (IOException ioe) {
				System.out.println("Google documents are not allowed likewise G_doc or G_spreadsheeets etc.");
				return;
			//	ioe.printStackTrace();
		}
	}
	
	

    public static void downloadUsingStream(String urlStr, String file) throws IOException{
        URL url = new URL(urlStr);
        BufferedInputStream bis = new BufferedInputStream(url.openStream());
        FileOutputStream fis = new FileOutputStream(file);
        byte[] buffer = new byte[1024];
        int count=0;
        while((count = bis.read(buffer,0,1024)) != -1)
        {
            fis.write(buffer, 0, count);
        }
        fis.close();
        bis.close();
    }

     public static void downloadUsingNIO(String urlStr, String file) throws IOException {
        URL url = new URL(urlStr);
        ReadableByteChannel rbc = Channels.newChannel(url.openStream());
        FileOutputStream fos = new FileOutputStream(file);
        fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
        fos.close();
        rbc.close();
    }
	
	
	
}

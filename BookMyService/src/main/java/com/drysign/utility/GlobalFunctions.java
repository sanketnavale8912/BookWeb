package com.drysign.utility;

import java.io.InputStream;
import java.util.Properties;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.drysign.model.EFAConfigDetails;

public class GlobalFunctions {
	
	Properties prop = new Properties();
	InputStream input = null;
	
	private static final Logger logger= Logger.getLogger(GlobalFunctions.class);
	public String uniqueToken(){
		return UUID.randomUUID().toString();
	}
	
	public EFAConfigDetails getEFAdetails() throws UtilityException {

		EFAConfigDetails efa = new EFAConfigDetails();
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("efa.properties");
			prop.load(input);
			efa.setDownloadFilePath(prop.getProperty("downloadFilePath"));
			efa.setHost(prop.getProperty("host"));
			efa.setPort(prop.getProperty("port"));
			efa.setServer(prop.getProperty("server"));
			efa.setUsername(prop.getProperty("username"));
			efa.setPassword(prop.getProperty("password"));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return efa;

	}
	
	public String getUploadPath() throws UtilityException
	{

		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.originalpath");
		}catch(Exception e){
			logger.error("Error while reading commonsutils file: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file: "+ e.getMessage());
		}
		return url;
	}

	public String getServerUrl() throws UtilityException 
	{
		
		String serverUrl = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			serverUrl = prop.getProperty("server.url");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file: "+ e.getMessage());
		}
		return serverUrl;
	
	}

	public String getCertificatePath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("key.path");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, key.path property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, key.path property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getDigitalSignatureFilePath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.signedpath");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, pdf.signedpath property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.signedpath property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getSignaturePath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.signature");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, pdf.signature property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.signature property: "+ e.getMessage());
		}
		return url;
	
	}
	
	public String getTypePath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.type");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, pdf.type property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.type property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getSignPdfPath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.fieldwrite");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getAppElectronicSignPdfPath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.app.electronic.docs");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getAppDigitalSignPdfPath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.app.digital.docs");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getOrignalPdfPath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.originalpath");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.fieldwrite property: "+ e.getMessage());
		}
		return url;
	
	}
	
	public String getTempAppElectronicSignPdfPath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("temp.electronic");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, temp.electronic property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, temp.electronic property: "+ e.getMessage());
		}
		return url;
	
	}
	public String getTempAppDigitalSignPdfPath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("temp.digital");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getProfilePicPath() throws UtilityException
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("profile.pic");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
		}
		return url;
	
	}

	public String getTemporaryFilePath() throws UtilityException 
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("temp.files");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
		}
		return url;
	
	}
	
	public String getEmailBackGroundImage() throws UtilityException 
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("email.bckimage");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
		}
		return url;
	
	}
	
	public String getEmailSourceHOVlogo() throws UtilityException 
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("email.sourceHOV");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
		}
		return url;
	
	}
	
	public String getEmailDrySignLogo() throws UtilityException 
	{
		
		String url = null;
		try{
			
			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("email.drySignLogo");
			
		}catch(Exception e){
			logger.error("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, temp.digital property: "+ e.getMessage());
		}
		return url;
	
	}
	
	public String getCertificatePassword() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("key.password");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, key.password property: " + e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, key.path property: " + e.getMessage());
		}
		return url;

	}

}

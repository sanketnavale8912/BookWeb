package com.drysign.utility;

import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.UUID;
import org.apache.log4j.Logger;

import com.drysign.model.EFAConfigDetails;

public class GlobalFunctions {

	Properties prop = new Properties();
	InputStream input = null;

	private static final Logger logger = Logger.getLogger(GlobalFunctions.class);

	public String uniqueToken() {
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
	
	
	public String getUploadPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.originalpath");
		} catch (Exception e) {
			logger.error("Error while reading commonsutils file: " + e.getMessage());
			throw new UtilityException("Error while reading commonsutils file: " + e.getMessage());
		}
		return url;
	}

	public String getServerUrl() throws UtilityException {

		String serverUrl = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			serverUrl = prop.getProperty("server.url");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file: " + e.getMessage());
			throw new UtilityException("Error while reading commonsutils file: " + e.getMessage());
		}
		return serverUrl;

	}

	public String getCertificatePath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("key.path");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, key.path property: " + e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, key.path property: " + e.getMessage());
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

	public String getDigitalSignatureFilePath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.signedpath");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, pdf.signedpath property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, pdf.signedpath property: " + e.getMessage());
		}
		return url;

	}

	public String getSignaturePath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.signature");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, pdf.signature property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, pdf.signature property: " + e.getMessage());
		}
		return url;

	}

	public String getTypePath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.type");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, pdf.type property: " + e.getMessage());
			throw new UtilityException("Error while reading commonsutils file, pdf.type property: " + e.getMessage());
		}
		return url;

	}

	public String getSignPdfPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.fieldwrite");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
		}
		return url;

	}

	public String getAppElectronicSignPdfPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.app.electronic.docs");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
		}
		return url;

	}

	public String getAppDigitalSignPdfPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.app.digital.docs");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
		}
		return url;

	}

	public String getOrignalPdfPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("pdf.originalpath");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, pdf.fieldwrite property: " + e.getMessage());
		}
		return url;

	}

	public String getTempAppElectronicSignPdfPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("temp.electronic");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, temp.electronic property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, temp.electronic property: " + e.getMessage());
		}
		return url;

	}

	public String getTempAppDigitalSignPdfPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("temp.digital");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, temp.digital property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, temp.digital property: " + e.getMessage());
		}
		return url;

	}

	public String getProfilePicPath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("profile.pic");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, temp.digital property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, temp.digital property: " + e.getMessage());
		}
		return url;

	}

	public String getTemporaryFilePath() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("temp.files");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, temp.digital property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, temp.digital property: " + e.getMessage());
		}
		return url;

	}

	public String getEmailBackGroundImage() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("email.bckimage");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, temp.digital property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, temp.digital property: " + e.getMessage());
		}
		return url;

	}

	public String getEmailSourceHOVlogo() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("email.sourceHOV");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, temp.digital property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, temp.digital property: " + e.getMessage());
		}
		return url;

	}

	public String getEmailDrySignLogo() throws UtilityException {

		String url = null;
		try {

			input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
			prop.load(input);
			url = prop.getProperty("email.drySignLogo");

		} catch (Exception e) {
			logger.error("Error while reading commonsutils file, temp.digital property: " + e.getMessage());
			throw new UtilityException(
					"Error while reading commonsutils file, temp.digital property: " + e.getMessage());
		}
		return url;

	}
	
	public static Map<String,String> getSubscriptionCredentials()
	{
		
		logger.info(String.format("Enter into getSubscriptionCredentials()"));
		
		Map<String,String> map = new HashMap<String,String>();
		try{
		ResourceBundle resource = ResourceBundle.getBundle("commonsutils");
	  	String username = resource.getString("subscribing.model.username");
	  	String password = resource.getString("subscribing.model.password");
	  	map.put("username", username);
	  	map.put("password", password);
		}catch(Exception e){
			map.put("username", null);
		  	map.put("password", null);
			logger.error("Error while getting username, password from properties file commonsutils: "+e);
		}
		
		logger.info("exit from getSubscriptionCredentials()");
		return map;	
	}

	public static String getPlanName(String email, boolean flagForRenew) 
	{
		logger.info(String.format("Enter into getPlanName()"));		
		String planName = null;
		try{
		ResourceBundle resource = ResourceBundle.getBundle("commonsutils");    	
    	if(isInternalEmail(email))
    	{    		
    		planName = resource.getString("plan.corporate.suscription");
    	}else if(!flagForRenew){
    		planName = resource.getString("plan.trial.subscription");
    	}
		
		
		
		}catch(Exception e)
		{			
			logger.error("Error while getting username, password from properties file commonsutils: "+e);
		}
		
		logger.info("exit from getTrialPlanName()");
		return planName;	
	}
	
	public static boolean isInternalEmail(String email){
		boolean planType;
		ResourceBundle resource = ResourceBundle.getBundle("commonsutils");
		String internalDomain = resource.getString("users.domain.subscription");;
    	String []ArrayOfInternalDomains = internalDomain.split(",");
    	
    	String []incomingDomain = email.split("@");
    	if(incomingDomain.length == 2 && Arrays.asList(ArrayOfInternalDomains).contains(incomingDomain[1].toLowerCase()))
    	{
    		planType = true;
    	}else{
    		planType = false;
    	}
		return planType;
		
	}

	public String getSupportUrl() 
	{
		logger.info(String.format("Enter into getSupportUrl()"));		
		String supportEmail = null;
		try{
		ResourceBundle resource = ResourceBundle.getBundle("commonsutils");
		supportEmail = resource.getString("smtp.username");
		}catch(Exception e)
		{			
			logger.error("Error while getting username, password from properties file commonsutils: "+e);
		}
		
		logger.info("exit from getTrialPlanName()");
		return supportEmail;	
	}
	
	public static String getDownloadFilePath() 
	{
		logger.info(String.format("Enter into getTrialPlanName()"));		
		String trialPlanName = null;
		try{
		ResourceBundle resource = ResourceBundle.getBundle("efa");
		trialPlanName = resource.getString("downloadFilePath");
		}catch(Exception e)
		{			
			logger.error("Error while getting username, password from properties file commonsutils: "+e);
		}
		
		logger.info("exit from getTrialPlanName()");
		return trialPlanName;	
	}
	
	public static String gdrivepath() 
	{
		logger.info(String.format("Enter into gdrivepath()"));		
		String trialPlanName = null;
		try{
		ResourceBundle resource = ResourceBundle.getBundle("commonsutils");
		trialPlanName = resource.getString("gdrivedownload");
		}catch(Exception e)
		{			
			logger.error("Error while getting gdrive file path: "+e);
		}
		
		logger.info("exit from gdrivepath()");
		return trialPlanName;	
	}

}
